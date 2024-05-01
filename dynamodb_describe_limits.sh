#!/bin/bash

# List of AWS regions
regions=("us-east-1")

echo "Describing DynamoDB Limits across specified regions..."

# Loop through each region
for region in ${regions[@]}
do
    echo "Region: $region"
    # Run the AWS CLI command to describe DynamoDB limits
    AWS_PAGER="" aws dynamodb describe-limits --region $region --output table
done
