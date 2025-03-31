if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

if uwsm check may-start && uwsm select; then
	exec uwsm start default
fi
