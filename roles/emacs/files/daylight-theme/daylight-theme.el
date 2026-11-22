;;; daylight-theme.el --- Light theme by day, dark theme by night -*- lexical-binding: t; -*-

;; Author: A. Ishikawa
;; Version: 0.1.0
;; Package-Requires: ((emacs "27.1"))
;; Keywords: faces

;;; Commentary:

;; `daylight-theme-mode' loads `daylight-theme-light' from sunrise and
;; `daylight-theme-dark' from sunset, and switches again at each one.
;;
;;   (setq daylight-theme-light 'leuven
;;         daylight-theme-dark 'leuven-dark)
;;   (daylight-theme-mode 1)
;;
;; Sunrise and sunset are computed for `calendar-latitude' and
;; `calendar-longitude' when they are set.  Otherwise they are computed for
;; the main city of the system time zone, read from zone1970.tab.  That needs
;; no network, follows a laptop between time zones, and is not changed by a
;; VPN.  Restart Emacs after the system time zone changes, because Emacs
;; reads the time zone offset only at startup.
;;
;; When there is no location, as with the UTC time zone, or no sunrise or
;; sunset, as in a polar day, the themes switch at
;; `daylight-theme-fallback-sunrise' and `daylight-theme-fallback-sunset'.

;;; Code:

(require 'seq)
(require 'solar)
(require 'subr-x)

(defgroup daylight-theme nil
  "Load a light theme by day and a dark theme by night."
  :group 'faces)

(defcustom daylight-theme-light nil
  "Theme loaded from sunrise."
  :type 'symbol)

(defcustom daylight-theme-dark nil
  "Theme loaded from sunset."
  :type 'symbol)

(defcustom daylight-theme-fallback-sunrise 7.0
  "Hour of the day to load the light theme when sunrise is unknown."
  :type 'number)

(defcustom daylight-theme-fallback-sunset 19.0
  "Hour of the day to load the dark theme when sunset is unknown."
  :type 'number)

(defcustom daylight-theme-zone-tables
  '("/usr/share/zoneinfo/zone1970.tab" "/usr/share/zoneinfo/zone.tab")
  "Time zone tables to find the coordinates of a time zone in.
The first readable one is used."
  :type '(repeat file))

(defvar daylight-theme--timer nil
  "Timer for the next switch between the themes.")

(defun daylight-theme--time-zone ()
  "Return the system time zone name, like \"America/Los_Angeles\", or nil."
  (let ((tz (getenv "TZ"))
        (localtime (file-truename "/etc/localtime")))
    (cond
     ((and tz (string-match "\\`:?\\([^/]+/.+\\)\\'" tz))
      (match-string 1 tz))
     ((string-match "zoneinfo/\\(.+\\)\\'" localtime)
      (match-string 1 localtime))
     ((file-readable-p "/etc/timezone")
      (with-temp-buffer
        (insert-file-contents "/etc/timezone")
        (string-trim (buffer-string)))))))

(defun daylight-theme--iso6709-degrees (coordinate)
  "Convert COORDINATE like \"+3541\" or \"-1181434\" to decimal degrees."
  (let* ((sign (if (eq (aref coordinate 0) ?-) -1 1))
         (digits (substring coordinate 1))
         ;; Latitude has 2 digits of degrees and longitude 3, then 2 of
         ;; minutes and optionally 2 of seconds.
         (degree-length (if (memq (length digits) '(4 6)) 2 3))
         (degrees (string-to-number (substring digits 0 degree-length)))
         (minutes (string-to-number
                   (substring digits degree-length (+ degree-length 2))))
         (seconds (string-to-number (substring digits (+ degree-length 2)))))
    (* sign (+ degrees (/ minutes 60.0) (/ seconds 3600.0)))))

(defun daylight-theme--time-zone-coordinates (zone)
  "Return (LATITUDE . LONGITUDE) of the main city of ZONE, or nil."
  (let ((table (seq-find #'file-readable-p daylight-theme-zone-tables)))
    (when (and zone table)
      (with-temp-buffer
        (insert-file-contents table)
        (when (re-search-forward
               (concat "^[^#\t]*\t\\([+-][0-9]+\\)\\([+-][0-9]+\\)\t"
                       (regexp-quote zone) "\\(?:\t\\|$\\)")
               nil t)
          (cons (daylight-theme--iso6709-degrees (match-string 1))
                (daylight-theme--iso6709-degrees (match-string 2))))))))

(defun daylight-theme-location ()
  "Return (LATITUDE . LONGITUDE) used for sunrise and sunset, or nil."
  (if (and (numberp calendar-latitude) (numberp calendar-longitude))
      (cons calendar-latitude calendar-longitude)
    (daylight-theme--time-zone-coordinates (daylight-theme--time-zone))))

(defun daylight-theme--sun-times (date)
  "Return (SUNRISE . SUNSET) on DATE, a list (MONTH DAY YEAR).
Both are hours of the local day, like 6.5 for 6:30."
  (let* ((location (daylight-theme-location))
         (times (when location
                  (let ((calendar-latitude (car location))
                        (calendar-longitude (cdr location)))
                    (solar-sunrise-sunset date))))
         (sunrise (car (nth 0 times)))
         (sunset (car (nth 1 times))))
    (if (and sunrise sunset)
        (cons sunrise sunset)
      (cons daylight-theme-fallback-sunrise daylight-theme-fallback-sunset))))

(defun daylight-theme--load (theme)
  "Load THEME alone, unless it is already loaded."
  (unless (equal custom-enabled-themes (list theme))
    (mapc #'disable-theme custom-enabled-themes)
    (load-theme theme t)))

(defun daylight-theme--update ()
  "Load the theme for the current time and schedule the next switch."
  (when daylight-theme--timer
    (cancel-timer daylight-theme--timer))
  (let* ((now (decode-time))
         (today (list (decoded-time-month now)
                      (decoded-time-day now)
                      (decoded-time-year now)))
         (hour (+ (decoded-time-hour now)
                  (/ (decoded-time-minute now) 60.0)
                  (/ (decoded-time-second now) 3600.0)))
         (sun (daylight-theme--sun-times today))
         (next (cond
                ((< hour (car sun)) (car sun))
                ((< hour (cdr sun)) (cdr sun))
                (t (let ((tomorrow (calendar-gregorian-from-absolute
                                    (1+ (calendar-absolute-from-gregorian
                                         today)))))
                     (+ 24 (car (daylight-theme--sun-times tomorrow))))))))
    (daylight-theme--load (if (and (>= hour (car sun)) (< hour (cdr sun)))
                              daylight-theme-light
                            daylight-theme-dark))
    (setq daylight-theme--timer
          (run-at-time (* 3600 (- next hour)) nil #'daylight-theme--update))))

;;;###autoload
(define-minor-mode daylight-theme-mode
  "Load `daylight-theme-light' by day and `daylight-theme-dark' by night."
  :global t
  (cond
   ((not daylight-theme-mode)
    (when daylight-theme--timer
      (cancel-timer daylight-theme--timer)
      (setq daylight-theme--timer nil)))
   ((not (and daylight-theme-light daylight-theme-dark))
    (setq daylight-theme-mode nil)
    (user-error "Set `daylight-theme-light' and `daylight-theme-dark' first"))
   (t (daylight-theme--update))))

(provide 'daylight-theme)
;;; daylight-theme.el ends here
