#!/bin/bash

# Predefined list of regions
regions=("us-east-1")

echo "Listing all ElastiCache clusters and node counts in specified regions..."

# Loop through each region and describe ElastiCache clusters
for region in ${regions[@]}
do
    echo "Region: $region"
    # Set AWS_PAGER to empty and fetch all cache clusters in the region
    results=$(AWS_PAGER="" aws elasticache describe-cache-clusters --region $region --show-cache-node-info --query "CacheClusters[*].[CacheClusterId,Engine,CacheNodeType,NumCacheNodes]" --output text)

    # Check if results were returned
    if [ -z "$results" ]; then
        echo "No ElastiCache clusters found in $region."
    else
        # Print the results in a tabulated format
        echo "$results" | while read -r cacheClusterId engine cacheNodeType numCacheNodes; do
            echo -e "$cacheClusterId\t$engine\t$cacheNodeType\t$numCacheNodes"
        done | column -t -s$'\t'
    fi
done
