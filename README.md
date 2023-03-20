Readme

# AWS Cloud Resume Challenge

[Click here](https://adnanhussain.co.uk) to access my website.

At face value, the website doesn't seem like much other than an online CV/Resume. The interesting bit is what's happening in the background and how I've utilised various cloud technologies to serve my website globally. It might be a bit overkill for a simple online CV/Resume but the same principals can be applied to other projects. Feel free to take a look at my own interpretation on the cloud resume challenge.

Check out the official cloud resume challenge website for more context: https://cloudresumechallenge.dev/docs/the-challenge/aws/

## 1. HTML & CSS

I have used a website template which consists of HTML & CSS. I've opted to do this rather than creating a website from scratch as the main aim of this project for me is to gain some solid experience using AWS and related DevOps tooling.

## 2. S3

I've created an S3 Bucket with static website hosting enabled to to store my website files. Public access to it is blocked and I will be allowing resources such as CloudFront to access it via bucket policies. For now, I've uploaded a simple HTML website file named "index.html". I've also specified this as the name for the Index document.

## 3. CloudFront

I have created a distribution within CloudFront to serve my website globally. Once the distribution was created, a bucket policy for S3 was generated which I've copied into my S3 bucket. This will allow CloudFront to access the S3 objects for my website.   
Currently, I'm using the CloudFront URL to access my website but I will be changing this to use my own domain using Route53. See steps 3 & 4.

Update: Now that the certificates have been issued to me in AWS Certificate Manager, I can edit the CloudFront distribution and add in my domain name and SSL certificate

![Screenshot 2023-03-19 at 9 59 46 pm](https://user-images.githubusercontent.com/24739598/226212396-5b57dd81-709f-4219-bfcf-693e46dca11f.jpg)

Update 2: For now, any changes made to my website will require me to create an invalidation in CloudFront so that the cached version of my website files in various edge locations are updated. Is is NOT recommended to replace the updated files with the same name. Instead, it's best to use versioned file names such as index-v2.html. I will be addressing this later when I set up CI/CD pipelines for changes to my website files.


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
Update: As all my resources are in the London region (eu-west-2), I originally requested a certificate in that region but AWS requires you to have your certificates in N. Virginia (us-east-1) if you want to attach it to your CloudFront distribution. You won't be able to export the existing certificate but you will be fine to request a certificate in us-east-1 for the same domain name.

## 6. DynamoDB

As part of the AWS Cloud Resume Challenge, one of the requirements is to use IaC (Infrastructure as Code). We can use AWS' CloudFormation service but I have opted to use Terraform. It works well and the documentation is easy to follow.

In this repo, you will see a folder named "dynamodb". This consists of Terraform code used to create a DynamoDB table and add an item into it. This setup is required as I will be creating a Lambda which will be updating the DynamoDB item each time a visitor views my website.
![tf-image](https://user-images.githubusercontent.com/24739598/226211233-45197937-d5cd-4ce1-8af4-c752b0b4ed42.png)

## 7. JavaScript

WIP - I will be adding in a visitor counter to my website. This will retrieve and update the view count on the website via a Lambda function.

## 8. Lambda

WIP - I will be creating a Lambda function in Python which will update the view count value in the DynamoDB table item I created earlier. The JavaScript function will call the Lambda function URL which will then trigger it to do the update and retrieve the latest value.

## 9. CI/CD

WIP - I will be creating CI/CD pipelines for the back end (Lambda function) and for the front end (website code).
Example: When I push updates for my website, I want the S3 bucket to be updated with the new files and the CloudFront cache to be invalidated so that the updated web pages are available immediately for everyone.

I am using AWS CodeCommit and CodePipeline for CI/CD. I have created a repository within AWS CodeCommit to store my website files. Depending on your IAM permissions, you may need to give yourself permissions to configure and access CodeCommit. I've already configured permissions in IAM for my user to have admin access so this wasn't necessary. I have also generated AWS CodeCommit credentials (This is found under Security credentials in IAM).

Once that was done, I cloned the repo to my local machine as instructed in the AWS console. As you can see in the screenshot below, I cloned an empty repo and then proceeded to add my website files into that folder. I then added them into git, commit with a message and then pushed the changes successfully.

![image](https://user-images.githubusercontent.com/24739598/226234080-3ee5198e-8920-40a8-9552-f20165626885.png)

