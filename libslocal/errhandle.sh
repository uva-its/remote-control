# errhandle.sh - trivial helper functions for dealing with errors

# Trap errors and spit out a useful error - this happens only
# when errors aren't explicitly checked for.
error_handler(){
    echo "$0 exiting on error: \"$1\" at line $2, exit code $3." >&2
}
errtrap(){
	trap 'error_handler "${BASH_COMMAND}" $LINENO $?' ERR
}

func_error_handler(){
	echo "$0 exiting on error in function $1: \"$2\" at line $3, exit code $4." >&2
}
functrap(){
	trap 'func_error_handler "${FUNCNAME[0]}" "${BASH_COMMAND}" $LINENO $?' ERR
}

# Since jobs are cat'ed to /bin/bash, we want useful error messages
job_error_handler(){
	echo "$0 exiting on error in job $1: \"$2\" at line $3, exit code $4." >&2
}
jobtrap(){
	trap 'job_error_handler "${RCJOBSCRIPT}" "${BASH_COMMAND}" $((LINENO - RCFIRSTLINE)) $?' ERR
}

# Print error to stderr and exit, for checked errors
errorout(){
	echo "Exiting on error: $1" >&2
	exit 1
}

# Print error to stderr for functions, which should return non-zero
errormsg(){
	echo "Error: $1" >&2
}
