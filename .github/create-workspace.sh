#!/usr/bin/bash

ALL_WORKSPACES=$(curl --location --request GET "https://app.terraform.io/api/v2/organizations/$ORGANIZATION_NAME/workspaces" \
        --header "Authorization: Bearer $TF_API_TOKEN") 
 
echo $ALL_WORKSPACES | jq '.data[] | .attributes.name' | grep -wq "$WORKSPACE_NAME"

WORKSPACE_EXISTS=$?

if [ $WORKSPACE_EXISTS -eq 1 ]; then
    printf "\n\n============== CREATING WORKSPACE =================\n\n" && \
    curl --location --request POST "https://app.terraform.io/api/v2/organizations/$ORGANIZATION_NAME/workspaces" \
    --header 'Content-Type: application/vnd.api+json' \
    --header "Authorization: Bearer $TF_API_TOKEN" \
    --data-raw "{ 
        \"data\": { 
        \"attributes\": { 
            \"name\": \"$WORKSPACE_NAME\",
            \"working-directory\": \"test\"
        }, 
        \"type\": \"workspaces\" 
        } 
    }" \
    && printf "\n\n============== WORKSPACE CREATED! =================\n\n" 
fi 
