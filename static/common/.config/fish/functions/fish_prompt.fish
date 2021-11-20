<<<<<<< Updated upstream
function fish_prompt
    echo '> '
end

function fish_right_prompt
    set -x envs
    if type -q kubectl
	set -l current_k8s_context (kubectl config current-context 2>/dev/null)
	if contains "$current_k8s_context" $FISH_PROMPT_K8S_CONTEXT_NAMES
            set envs $envs (printf '⎈ %s' $current_k8s_context)
	end
    end
    if test -f ~/.config/gcloud/active_config
	set -l gcp_project (cat ~/.config/gcloud/active_config)
	if contains $gcp_project $FISH_PROMPT_GCP_CONFIG_NAMES
            set envs $envs (printf 'GCP:%s' $gcp_project)
	end
    end

    if [ (count $envs) -gt 0 ]
        echo '['
=======
function __fish_prompt_kubernetes
    set -l current_k8s_context (kubectl config current-context)
    set -l prompt_message '⎈ '$current_k8s_context

    if contains $current_k8s_context $FISH_PROMPT_K8S_CONTEXT_NAMES
        set_color red
        echo -n $prompt_message
        set_color normal
    else
        echo -n $prompt_message
    end
end

function __fish_prompt_gcp
    set -l gcp_project (cat ~/.config/gcloud/active_config)
    set -l prompt_message 'GCP '$gcp_project

    if contains $gcp_project $FISH_PROMPT_GCP_CONFIG_NAMES
>>>>>>> Stashed changes
        set_color red
        echo -n $prompt_message
        set_color normal
    else
        echo -n $prompt_message
    end
end

function __fish_prompt_status
    set -l display_status $argv[1]
    set -l prompt_message (printf 'status: %s' $display_status)

    if [ $display_status != 0 ]
        set_color $fish_color_error
        echo -n $prompt_message
        set_color normal
    else
        echo -n $prompt_message
    end
end

function fish_prompt
    set -l display_status $status

    echo
    string join ' ' \
        (printf '(%s)' $PWD) \
        (printf '(%s)' (__fish_prompt_kubernetes)) \
        (printf '(%s)' (__fish_prompt_gcp)) \
#         (prompt_pwd) \
        (__fish_git_prompt) \
        (printf '(%s)' (__fish_prompt_status $display_status)) \

    echo '> '
end
