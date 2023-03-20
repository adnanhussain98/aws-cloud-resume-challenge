# AWS Cloud Resume Challenge

[Click here](adnanhussain.co.uk) to access my website.

At face value, the website doesn't seem like much other than an online CV/Resume. The interesting bit is what's happening in the background and how I've utilised various cloud technologies to serve my website globally. It might be a bit overkill for a simple online CV/Resume but the same principals can be applied to other projects. Feel free to take a look at my own interpretation on the cloud resume challenge.

Check out the official cloud resume challenge website for more context: https://cloudresumechallenge.dev/docs/the-challenge/aws/

## 1. HTML & CSS

I have used a website template which consists of HTML & CSS. I've opted to do this rather than creating a website from scratch as the main aim of this project for me is to gain some solid experience using AWS and related DevOps tooling.

## 2. S3

I've created an S3 Bucket with static website hosting enabled to to store my website files. Public access to it is blocked and I will be allowing resources such as CloudFront to access it via bucket policies. For now, I've uploaded a simple HTML website file named "index.html". I've also specified this as the name for the Index document.

## 3. CloudFront

I have created a distruibtion within CloudFront to serve my website globally. Once the distruibution was created, a bucket policy for S3 was generated which I've copied into my S3 bucket. This will allow CloudFront to access the S3 objects for my website.   
Currently, I'm using the CloudFront URL to access my website but I will be changing this to use my own domain using Route53. See steps 3 & 4.

Update: Now that the certificates have been issued to me in AWS Certificate Manager, I can edit the CloudFront distribution and add in my domain name and SSL certificate

![Screenshot 2023-03-19 at 9 59 46 pm](https://user-images.githubusercontent.com/24739598/226212396-5b57dd81-709f-4219-bfcf-693e46dca11f.jpg)


## 4. Route 53

I have created a public hosted zone for my domain, adnanhussain.co.uk. This will generate some nameservers which I can use to point my domain name to.

![Screenshot 2023-03-19 at 5 38 59 pm](https://user-images.githubusercontent.com/24739598/226206090-6bac13a5-9ac5-4987-aea7-063d48df3157.jpg)

I have bought my domain from 123 Reg so in my case, I just need to log into my 123 Reg account and find the Nameserver management section. As you can see in the screenshot, I have copied in the 4 nameservers given to me by Route53.    

![Screenshot 2023-03-19 at 5 42 59 pm](https://user-images.githubusercontent.com/24739598/226206319-3ab21b5b-cfbd-41e4-9e14-ce09f7d1b9e0.jpg)

Update: Now that I've updated my CloudFront distribution with my domain name and SSL certificate, I have created a record within the hosted zone I created earlier so that my domain, adnanhussain.co.uk, points to the CloudFront distribution. The record will look something like this:

![image](https://user-images.githubusercontent.com/24739598/226212677-b2a1a09c-55e8-4748-aa1a-34ffe67bb1e5.png)

## 5. AWS Certificate Manager

I have requested a public certificate for the following domains I own:   
- adnanhussain.co.uk      
- *.adnanhussain.co.uk (the wildcard * is used to allow all the subdomains)    

This will generate some SSL certificates which I will be using in my CloudFront distribution.    
Update: As all my resources are in the London region (eu-west-2), I originally requested a certificate in that region but AWS requires you to have your certificates in N. Virginia (us-east-1) if you want to attach it to your CloudFront distribution. You won't be able to export the exisiting certificate but you will be fine to request a certificate in us-east-1 for the same domain name.

## 6. DynamoDB

As part of the AWS Cloud Resume Challenge, one of the requirements is to use IaC (Infrastructure as Code). We can use AWS' CloudFormation service but I have opted to use Terraform. It works well and the documentation is easy to follow.

In this repo, you will see a folder named "dynamodb". This consists of Terraform code used to create a DynamoDB table and add an item into it. This setup is required as I will be creating a Lambda which will be updating the DynamoDB item each time a vistor views my website.
![tf-image](https://user-images.githubusercontent.com/24739598/226211233-45197937-d5cd-4ce1-8af4-c752b0b4ed42.png)

