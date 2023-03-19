# AWS Cloud Resume Challenge
Cool way to show off my CV/Resume online utilising multiple AWS services and Terraform.
Check out the official cloud resume challenge website for more context: https://cloudresumechallenge.dev/docs/the-challenge/aws/

## 1. S3

I've created an S3 Bucket with static website hosting enabled to to store my website files. Public access to it is blocked and I will be allowing resources such as CloudFront to access it via bucket policies. For now, I've uploaded a simple HTML website file named "index.html". I've also specified this as the name for the Index document.

## 2. CloudFront

I have created a distruibtion within CloudFront to serve my website globally. Currently, I'm using the CloudFront URL to access my website but I will be changing this to use my own domain using Route53. Once the distruibution was created, a bucket policy for S3 was generated which I've copied into my S3 bucket. This will allow CloudFront to access the S3 objects for my website.

## 3. Route 53

I have created a public hosted zone for my domain, adnanhussain.co.uk. This will generate some nameservers which I can use to point my domain name to.     ![Screenshot 2023-03-19 at 5 38 59 pm](https://user-images.githubusercontent.com/24739598/226206090-6bac13a5-9ac5-4987-aea7-063d48df3157.jpg)
I have bought my domain from 123 Reg so in my case, I just need to log into my 123 Reg account and find the Nameserver management section. As you can see in the screenshot, I have copied in the 4 nameservers given to me by Route53.    
![Screenshot 2023-03-19 at 5 42 59 pm](https://user-images.githubusercontent.com/24739598/226206319-3ab21b5b-cfbd-41e4-9e14-ce09f7d1b9e0.jpg)


## 4. AWS Certificate Manager

I have requested a public certificate for the following domains I own:   
adnanhussain.co.uk      
*.adnanhussain.co.uk (the wildcard * is used to allow all the subdomains)

## 5. DynamoDB

As part of the AWS Cloud Resume Challenge, one of the requirements for this is to use IaC (Infrastructure as Code). We can use AWS' CloudFormation service but I have opted to use Terraform. It works well and the documentation is easy to follow. 
In this repo, you will see a folder named "dynamodb". This consists of Terraform code used to create a DynamoDB table and add an item into it. This setup is required as I will be creating a Lambda which will be updating the DynamoDB item each time a vistor views my website.
