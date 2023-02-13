function __fish_prompt_kubernetes_caution
    if not type -q kubectl
	    return 1
    end
    if test -z "$FISH_PROMPT_K8S_CONTEXT_NAMES"
        return 1
    end

    set -l current_k8s_context (kubectl config current-context)
    return (contains $current_k8s_context $FISH_PROMPT_K8S_CONTEXT_NAMES)
end

function __fish_prompt_kubernetes
    if not type -q kubectl
	    return
    end

    set -l current_k8s_context (kubectl config current-context)
    set -l prompt_message '⎈ '$current_k8s_context

    if __fish_prompt_kubernetes_caution
        set_color red
        echo -n $prompt_message
        set_color normal
    else
        echo -n $prompt_message
    end
end

function __fish_prompt_gcp_caution
    if test -z "$FISH_PROMPT_GCP_CONFIG_NAMES"
        return 1
    end
    if not test -f ~/.config/gcloud/active_config
        return 1
    end

    set -l gcp_project (cat ~/.config/gcloud/active_config)
    return (contains $gcp_project $FISH_PROMPT_GCP_CONFIG_NAMES)
end

function __fish_prompt_gcp
    if not test -f ~/.config/gcloud/active_config
    	return
    end

    set -l gcp_project (cat ~/.config/gcloud/active_config)
    set -l prompt_message 'GCP '$gcp_project

    if __fish_prompt_gcp_caution
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

    if __fish_prompt_kubernetes_caution; or __fish_prompt_gcp_caution;
        echo
        string join ' ' \
            (prompt_pwd) \
            (printf '(%s)' (__fish_prompt_kubernetes)) \
            (printf '(%s)' (__fish_prompt_gcp)) \
            (__fish_git_prompt) \
            (printf '(%s)' (__fish_prompt_status $display_status))
    end

    echo '> '
end
