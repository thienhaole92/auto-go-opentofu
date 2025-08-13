#!/bin/bash
set -e

############################################################
# Help                                                     #
############################################################
Help() {
  # Display Help
  echo "Usage: sh apply.sh -e <environment> -c <command>"
  echo
  echo "options:"
  echo "h     Show this help output, or the help for a specified subcommand."
  echo "e     Choose environment to execute a command."
  echo "c     Command to execute"
  echo
}

############################################################
############################################################
# Main program                                             #
############################################################
############################################################

# Set variables
env=""
cmd=""

############################################################
# Process the input options. Add options as needed.        #
############################################################
# Get the options
while getopts ":h:e:c:" opt; do
  case $opt in
  h) # display Help
    Help
    exit
    ;;
  e) # Enter an environment
    env=$OPTARG ;;
  c) # Enter a command
    cmd=$OPTARG ;;
  \?) # Invalid option
    echo "Error: Invalid option"
    exit
    ;;
  esac
done

if [ -z "$env" ] || [ -z "$cmd" ] ; then
  echo "Error: -e and -c must be settled"
  exit
fi

echo "Selected environment: $env"
cd environments/"$env" || exit
echo "Executing command: terragrunt run-all $cmd"
terragrunt run-all "$cmd"
