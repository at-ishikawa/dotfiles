function __fish_prompt_kubernetes
    if not type -q kubectl
	return
    end

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
    if not test -f ~/.config/gcloud/active_config
	return
    end

    set -l gcp_project (cat ~/.config/gcloud/active_config)
    set -l prompt_message 'GCP '$gcp_project

    if contains $gcp_project $FISH_PROMPT_GCP_CONFIG_NAMES
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
