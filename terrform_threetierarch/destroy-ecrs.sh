#!/bin/bash

delete_repo() {
    local repo_name="$1"
    aws ecr delete-repository --repository-name "$repo_name" 2>/dev/null
    if [ $? -ne 0 ]; then
        if aws ecr describe-repositories --repository-names "$repo_name" 2>&1 | grep -q "RepositoryNotFoundException"; then
            echo "Repository '$repo_name' not found, skipping."
        else
            echo "Error deleting '$repo_name':"
            aws ecr delete-repository --repository-name "$repo_name" # Show original error
        fi
    fi
}

delete_repo "ha-app-application-tier"
delete_repo "ha-app-presentation-tier"