# AWS Ghost Blog

Business Case
The customer Drone Shuttles Ltd. is currently running their website on an outdated platform hosted in their own datacenter. They are about to launch a new product that will revolutionize the market and want to increase their social media presence with a blogging platform. During their ongoing modernization process, they decided they want to use the Ghost Blog platform for their marketing efforts.

They do not know what kind of traffic to expect so the solution should be able to adapt to traffic spikes. It is expected that during the new product launch or marketing campaigns there could be increases of up to 4 times the typical load. It is crucial that the platform remains online even in case of a significant geographical failure. The customer is also interested in disaster recovery capabilities in case of a region failure.

&nbsp;
&nbsp;
&nbsp;

## Architecture design

![https://aws.amazon.com/pt/blogs/architecture/implementing-multi-region-disaster-recovery-using-event-driven-architecture/](https://nord-cloud-penguin.s3.amazonaws.com/aws_gthost_blog.jpeg)

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


## Acceptance Criteria Comments

### Scaling (Implemented)

Dynamic scaling in ASG creates target tracking scaling policies for the resources. These scaling policies adjust resource capacity in response to live changes in resource utilization. The intention is to provide enough capacity to maintain utilization at the target value specified by the scaling strategy.

### Security (Implemented)

#### Certificate

DNS provider maintains a database containing records that define our domain. On DNS validation, ACM provides a CNAME record that were added to the database. This record contain a unique key-value pair that serves as proof that you control the domain.

#### AWS Parameter Store

Our MySQL Ghost DB password is encrypted and stored in AWS Parameter Store, a capability of AWS Systems Manager, which provides secure, hierarchical storage for configuration data management and secrets management. 

### Consistency (Implemented)

Elastic Load Balancing (ELB) performs health checks and automatically distributes incoming application traffic across multiple EC2 instances.

### Resilience (Implemented)

EC2 instances can be launched in multiple AZs, which are engineered to be insulated from failures in other AZs.

### Observability (Not implemented)

With [CloudWatch Embedded Metric Format](https://aws.amazon.com/pt/blogs/mt/enhancing-workload-observability-using-amazon-cloudwatch-embedded-metric-format/)
, builders gain access to comprehensive real-time metrics for their workloads. Since every event is captured in the log, no fidelity is lost—even brief but important events can be investigated. Every event can be enriched with high-cardinality properties.

### Automation (Implemented)

Terraform gives developers and systems administrators an easy way to create a collection of related AWS resources and provision them in an orderly and predictable fashion.

### Disaster recovery (Not implemented)

In order to replicate our Ghost database in other region, we’ll create an RDS database in the primary Region and enable backup replication in the configuration. In case of a DR event, you can choose to restore the replicated backup on the Amazon RDS instance in the destination Region.

In this solution we are using Amazon Route 53 which is a highly available and scalable DNS web service includes a number of global load-balancing capabilities that can be effective when dealing with DR scenarios for e.g. DNS endpoint health checks and the ability to failover between multiple endpoints.

I would adopt the [multi-Region active-passive strategy](https://aws.amazon.com/pt/blogs/architecture/implementing-multi-region-disaster-recovery-using-event-driven-architecture/)
which switches request traffic from primary to secondary Region via DNS records via Amazon Route 53 routing policies. 


### Multiple separated environments (Not implemented)

[AWS says ](https://aws.amazon.com/pt/organizations/getting-started/best-practices/) that "While you may begin your AWS journey with a single account, AWS recommends that you set up multiple accounts as your workloads grow in size and complexity. Using a multi-account environment is an AWS best practice that offers several benefits"...

That said, I suggest to create one different account for each environment. The basis of a well-architected multi-account AWS environment is AWS Organizations, an AWS service that enables you to centrally manage and govern multiple accounts.

&nbsp;
&nbsp;
&nbsp;

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
