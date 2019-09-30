function fish_prompt
    set -l current_k8s_context (kubectl config current-context)
    set -l gcp_project (cat ~/.config/gcloud/active_config)
    #    set -l gcp_project (cat ~/.config/gcloud/configurations/config_(cat ~/.config/gcloud/active_config) | grep project | cut -f 3 -d " ")

    set -x envs
    if contains $current_k8s_context $FISH_PROMPT_K8S_CONTEXT_NAMES
        set envs $envs (printf '⎈ %s' $current_k8s_context)
    end
    if contains $gcp_project $FISH_PROMPT_GCP_CONFIG_NAMES
        set envs $envs (printf 'GCP:%s' $gcp_project)
    end
    if [ (count $envs) -gt 0 ]
        set_color red
        printf '%s ' (string join ',' $envs)
        set_color normal
    end
    printf '> '
end
