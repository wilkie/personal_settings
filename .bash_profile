. $HOME/.bashrc
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

if [ "$HOSTNAME" = "thot.cs.pitt.edu" ]; then
	source /opt/set_specific_profile.sh;
fi
