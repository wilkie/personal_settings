
# Check for an interactive session
[ -z "$PS1" ] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export PATH=$PATH:~/fake-local/bin

# Define a few colors for later use. The escaped brackets tell bash that they
# are non-printable and keep word-wrapping sane.

TXT_RED='\['`tput setaf 1`'\]'
TXT_GREEN='\['`tput setaf 2`'\]'
TXT_RESET='\['`tput sgr0`'\]'

# Build a prompt decorator if we're in a git repo. The branch name is included
# in green if the branch is master, red otherwise. An asterisk appears if the
# working directory is not clean.

function parse_git_branch {
	status="$(git status 2> /dev/null)"
	pattern="^# On branch ([^${IFS}]*)"
	git_prompt_decorator=""

	if [[ ${status} =~ ${pattern} ]]; then
		branch_name=${BASH_REMATCH[1]}
		dirty=""
		color=${TXT_RED}

		if [[ ! ${status} =~ "working directory clean" ]]; then
			dirty="*"
		fi
		if [[ ${branch_name} == "master" ]]; then
			color=${TXT_GREEN}
		fi
		git_prompt_decorator=":${color}${branch_name}${TXT_RESET}${dirty}"
	fi
}

# Set up a function that is run every time the shell prompt is generated.

function set_shell_prompt {
	parse_git_branch
	PS1="[\u@\h \W"${git_prompt_decorator}"]\$ "
}

export PROMPT_COMMAND=set_shell_prompt
