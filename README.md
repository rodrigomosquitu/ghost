# AWS Ghost Blog

Business Case
The customer Drone Shuttles Ltd. is currently running their website on an outdated platform hosted in their own datacenter. They are about to launch a new product that will revolutionize the market and want to increase their social media presence with a blogging platform. During their ongoing modernization process, they decided they want to use the Ghost Blog platform for their marketing efforts.

They do not know what kind of traffic to expect so the solution should be able to adapt to traffic spikes. It is expected that during the new product launch or marketing campaigns there could be increases of up to 4 times the typical load. It is crucial that the platform remains online even in case of a significant geographical failure. The customer is also interested in disaster recovery capabilities in case of a region failure.

&nbsp;
&nbsp;
&nbsp;

## Architecture design

![](https://nord-cloud-penguin.s3.amazonaws.com/aws_gthost_blog.jpeg)

## Configuration

Ghost Blog App uses Terraform in order to build and manage cloud services. 

### Mysql password

Open "AWS Systems Manager Parameter Store" and add a parameter called "ghostdbpw" with your DB password.

### Terraform relevant variables

Update following variables from file /terraform/variables.tf:

- asg_min_size; Ghost blog minumum instance count 
- asg_max_size: Ghost blog maximum instance count 
- website_url: Your ghost website URL, has to match the origin
- alb_ssl_policy: ELB listener name of the SSL Policy 
- alb_certificate_arn: ARN of the default SSL server certificate
- r53_zone_name: Name of the hosted zone
- r53_zone_id: ID of the hosted zone 

&nbsp;
&nbsp;
&nbsp;

## Installation

To install and use AWS Ghost Blog you need to commit code into Git repository ("main" branch) in order to start the Codepipeline in AWS account.

After that, wait until the Codepipeline finishes and the EC2 instances with Ghost blog is started.

Then access <https://www.rodmosq.link> to open Ghost Blog. 

VOILLAAA!

&nbsp;
&nbsp;
&nbsp;

## Git repository

<https://github.com/rodrigomosquitu/ghost>


## Additional services used

+ AWS
    * Cloud 9
    * CodeBuild
    * CodePipeline
	* AWS Systems Manager Parameter Store
	* AWS Systems Manager Session Manager
	* AWS Cost Explorer
	* Certificate manager
	* Route 53
	* Lightsail
	* S3

+ IaC
    * [Terraformer](https://github.com/GoogleCloudPlatform/terraformer) - A CLI tool that generates tf/json and tfstate files based on existing infrastructure (reverse Terraform).
    * Terraform

+ Architecture design
    * Lucid Chart

## Links

[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/rodrigo-oliveira-assis/)
