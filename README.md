# multi-tier-architecture-using-terraform

### Objective :

Deploy a scalable and secure web application on AWS using Terraform. The application will consist of:

A public-facing Load Balancer.

Web servers in private subnets.

A secure MySQL database in isolated subnets.

### Architecture Goals :

1.High Availability: Deployed across 2 Availability Zones.

2.Security: Use of NAT Gateways, private and isolated subnets.

3.Scalability: Application tier designed to scale (with count or ASG-ready).

4.Modular Design: Infrastructure components clearly separated.

### How deploy the project :
### Step1:

VPC is created with 3 layers of subnets across 2 AZs:

1.public-subnets: For ALB and NAT Gateways.

2.private-subnets: For EC2 application servers.

3.db-subnets: For RDS MySQL, completely isolated.

### Step2:
Routing Tables ensure:

1.Public subnets have direct internet access.

2.Private subnets route through NAT Gateways.

3.DB subnets have no route to internet at all.

### Step3:
Security Groups:

1.Allow public HTTP(S) to ALB.

2.ALB forwards only to EC2 instances.

3.Only EC2 can talk to RDS.

### Step4:

Application Load Balancer (ALB) is created with:

1.HTTP listener.

2.Target group registering EC2 instances by private IP.

### Step5:
EC2 Instances are created with:

1.Private IPs only.

2.Attached security group allowing only ALB traffic.

3.Optional user-data script to install Node.js app.

### Step 6:
RDS MySQL Instance is launched:

1.In db-subnets.

2.No public access.

3.Only accessible from App SG.
