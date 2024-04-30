#!/bin/bash

# Predefined list of regions
regions=("us-east-1")

# Loop through each region and describe ElastiCache Reserved Instances
for region in ${regions[@]}
do
    echo "Region: $region"
    AWS_PAGER="" aws elasticache describe-reserved-cache-nodes --region $region --output table --query "ReservedCacheNodes[?State=='active'].[ReservedCacheNodeId,CacheNodeType,StartTime,Duration,CacheNodeCount,ProductDescription,OfferingType,State]"
done
