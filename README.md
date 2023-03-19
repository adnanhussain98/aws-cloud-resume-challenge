# AWS Cloud Resume Challenge
Cool way to show off my CV/Resume online utilising multiple AWS services and Terraform.
Check out the official cloud resume challenge website for more context: https://cloudresumechallenge.dev/docs/the-challenge/aws/

## 1. S3

I've created an S3 Bucket with static website hosting enabled to to store my website files. Public access to it is blocked and I will be allowing resources such as CloudFront to access it via bucket policies. For now, I've uploaded a simple HTML website file named "index.html". I've also specified this as the name for the Index document.

## 2. CloudFront

I have created a distruibtion within CloudFront to serve my website globally. Currently, I'm using the CloudFront URL to access my website but I will be changing this to use my own domain using Route53. Once the distruibution was created, a bucket policy for S3 was generated which I've copied into my S3 bucket. This will allow CloudFront to access the S3 objects for my website.

## 3. Route 53

WIP

## 4. AWS Certificate Manager

WIP

## DynamoDB

The folder "dynamodb" consists of the Terraform code used to create a DynamoDB table and add an item into it. This setup is required as I will be creating a Lambda which will be updating the DynamoDB item each time a vistor views my website
