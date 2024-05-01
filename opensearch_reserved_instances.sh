#!/bin/bash

# Predefined list of regions
regions=("us-east-1")

echo "Listing Active OpenSearch Reserved Instances in all specified regions..."

# Loop through each region and describe OpenSearch Reserved Instances
for region in ${regions[@]}
do
    echo "Region: $region"
    # Set AWS_PAGER to empty and run the AWS CLI command for OpenSearch Service
    AWS_PAGER="" aws opensearch describe-reserved-instances --region $region --output table \
        --query "ReservedInstances[?State=='active'].[ReservedInstanceId,ReservationName,InstanceType,InstanceCount,State,StartTime,Duration,FixedPrice,UsagePrice]"
done
