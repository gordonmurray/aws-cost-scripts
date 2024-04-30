#!/bin/bash

# Predefined list of regions
regions=("us-west-2" "eu-west-1" "us-east-1" "eu-central-1" "us-west-1" "ap-southeast-2" "ca-central-1" "ap-southeast-1" "ap-south-1" "eu-west-2" "us-east-2")

# Loop through each region and describe ElastiCache Reserved Instances
for region in ${regions[@]}
do
    echo "Region: $region"
    AWS_PAGER="" aws elasticache describe-reserved-cache-nodes --region $region --output table --query "ReservedCacheNodes[?State=='active'].[ReservedCacheNodeId,CacheNodeType,StartTime,Duration,CacheNodeCount,ProductDescription,OfferingType,State]"
done
