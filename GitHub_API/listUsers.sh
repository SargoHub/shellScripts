#!/bin/bash

########
# About : This script is used to list GitHub repo collaborators using the GitHub API
# Source : Abhishek Veeramala
# Run this script on an EC2 cloning the script on it
# Export the username as needed by the script before executing the script
# Export the access token as well before executing the script
# Install jq as well for the script
###########

# GitHub API URL
API_URL="https://api.github.com"

# GitHub username and personal access token has to be exported before running the script
USERNAME=$username
TOKEN=$token

# Organisation and Repository information have to be added as the cmd arguments
# 1st argument = github organisation name
# 2nd argument = repository name in the org.
REPO_OWNER=$1
REPO_NAME=$2

# Function to make a GET request to the GitHub API
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"

    # Send a GET request to the GitHub API with authentication
    curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

# Function to list users with read access to the repository
function list_users_with_read_access {
    local endpoint="repos/${REPO_OWNER}/${REPO_NAME}/collaborators"

    # Fetch the list of collaborators on the repository
    collaborators="$(github_api_get "$endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"

    # Display the list of collaborators with read access
    if [[ -z "$collaborators" ]]; then
        echo "No users with read access found for ${REPO_OWNER}/${REPO_NAME}."
    else
        echo "Users with read access to ${REPO_OWNER}/${REPO_NAME}:"
        echo "$collaborators"
    fi
}

function helper {
    expected_cmd_args=2
    if [ $# -ne $expected_cmd_args]; then
        echo "please enter the req. number of cmd args"
    fi
}

helper $#

# Main script
echo "Listing users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_users_with_read_access
