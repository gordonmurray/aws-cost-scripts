#!/bin/bash

# Predefined list of regionsregions=("us-east-1")

echo "Listing all OpenSearch domains and their node configurations in specified regions..."

# Loop through each region and describe OpenSearch domains
for region in ${regions[@]}
do
    echo "Region: $region"
    # Retrieve all domain names in the current region
    domainNames=$(aws opensearch list-domain-names --region $region --query 'DomainNames[*].DomainName' --output text)

    # Check if any domains are present
    if [ -z "$domainNames" ]; then
        echo "No domains found in $region."
    else
        # Loop through each domain name to get details
        for domainName in $domainNames
        do
            echo "Domain: $domainName"
            # Get detailed information about each domain
            domainDetails=$(aws opensearch describe-domain --domain-name $domainName --region $region --query 'DomainStatus')
            instanceType=$(echo $domainDetails | jq -r '.ClusterConfig.InstanceType')
            instanceCount=$(echo $domainDetails | jq -r '.ClusterConfig.InstanceCount')
            masterType=$(echo $domainDetails | jq -r '.ClusterConfig.DedicatedMasterType')
            masterCount=$(echo $domainDetails | jq -r '.ClusterConfig.DedicatedMasterCount')
            echo "  Data Nodes - Instance Type: $instanceType, Instance Count: $instanceCount"
            echo "  Master Nodes - Instance Type: $masterType, Instance Count: $masterCount"
        done
    fi
done
