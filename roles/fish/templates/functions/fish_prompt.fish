function __aws_prompt
    set --local profile $AWS_PROFILE
    if test -z $profile
        set profile default
    end

    set --local region $AWS_DEFAULT_REGION
    if test -z $region
        set region default
    end

    set --local profile_color yellow
    set --local region_color yellow
    echo -n -s "[AWS:" (set_color $profile_color) "$profile" (set_color normal) "|" (set_color $region_color) "$region" (set_color normal) "]"
end

function fish_prompt
    if set -q __fish_minimum_prompt_enabled
        echo -e '> '
        return
    end

    set --local messages

    # Check if aws cli is installed. If not, skip the AWS prompt.
    if type -q aws
        set --append messages (__aws_prompt)
    end

    set --append messages \
        (prompt_pwd) \
        (__fish_vcs_prompt)
    echo -n -e "$messages"
    echo
    echo -e '> '
end
