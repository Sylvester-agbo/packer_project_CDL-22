#!/bin/bash

# Define the AMI name you want to check
ami_name="bootcamp32-packer-ubuntu-ami-2"

# Define the AWS region
region="us-west-1"

# Use the AWS CLI to describe AMIs with the specified name and region
result=$(aws ec2 describe-images \
  --filters "Name=name,Values=$ami_name" \
  --region $region 2>&1)

# Check the exit code of the AWS CLI command
if [ $? -eq 0 ]; then
  # Check if any images were found
  if [ "$(echo $result | jq '.Images | length')" -gt 0 ]; then
    echo "AMI '$ami_name' exists in region '$region'."
  else
    echo "AMI '$ami_name' does not exist in region '$region'."
  fi
else
  # An error occurred while running the AWS CLI command
  echo "Error: $result"
fi

if [ $? -eq 0 ]; then
 terraform init
 terraform fmt
 terraform validate
 terraform plan
 terraform apply -auto-approve
else
 echo "error"
fi