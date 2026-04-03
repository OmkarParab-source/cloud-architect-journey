# Cloud Architect Journey — Terraform AWS Infrastructure

---

## Overview

This project is a hands-on cloud architecture journey focused on building production-grade AWS infrastructure using Terraform.

The emphasis is not just on provisioning resources, but on:

* Designing scalable and resilient systems
* Understanding failure behavior
* Implementing observability based on real system gaps
* Applying clean, modular Terraform practices

---

## Current Architecture (As of Day 13)

The system is a multi-AZ, load-balanced, auto-scaled web application with basic observability.

### Core Components

* VPC (Multi-AZ)
* Public and Private Subnets
* Internet Gateway and NAT Gateways (per AZ)
* Application Load Balancer (ALB)
* Auto Scaling Group (ASG) with Launch Template
* IAM Roles (SSM-based access, no SSH)
* CloudWatch Alarms (observability layer)

---

## Module Structure

```bash
terraform/
│
├── modules/
│   ├── vpc/
│   ├── networking/
│   ├── security/
│   ├── alb/
│   ├── compute/
│   └── observability/
│
├── main.tf
├── variables.tf
├── outputs.tf
├── locals.tf
└── provider.tf
```

---

## Module Responsibilities

| Module        | Responsibility                         |
| ------------- | -------------------------------------- |
| vpc           | Core network boundary                  |
| networking    | Subnets, routing, NAT                  |
| security      | Security groups                        |
| alb           | Load balancer and target group         |
| compute       | Launch template, ASG, scaling policies |
| observability | CloudWatch alarms                      |

---

## Features Implemented

### High Availability

* Multi-AZ deployment
* NAT Gateway per AZ (avoids single point of failure)
* Load-balanced architecture

---

### Auto Scaling

* ASG with launch template
* CPU-based scaling policy

---

### Secure Access

* No SSH access
* SSM-based instance access
* IAM roles attached to EC2

---

### Observability (Day 13)

* CPUUtilization alarm (compute-level signal)
* UnHealthyHostCount alarm (system-level signal)

---

## Failure Testing (Day 12)

Two failure scenarios were tested to validate system behavior.

### EC2 Instance Termination

* Observed partial availability degradation
* ASG replaced instance automatically
* System recovered without manual intervention

---

### Application Failure (nginx stopped)

* Observed approximately 50 percent request failure rate
* ALB continued routing to unhealthy instance until detection
* Highlighted delay in health check-based isolation

---

### Key Insight

```
System can be “available” while serving failed responses
```

---

## Observability Strategy

Observability is derived from real failure patterns.

| Signal             | Purpose                         |
| ------------------ | ------------------------------- |
| CPUUtilization     | Detect scaling pressure         |
| UnHealthyHostCount | Detect degraded system behavior |

---

## Key Design Decisions

### Modular Terraform Architecture

* Clear separation of concerns
* Each module represents a distinct infrastructure layer

---

### Minimal Root Outputs

* Only expose necessary external contract (alb_dns_name)
* Avoid leaking internal module details

---

### Hybrid Observability Design

* Compute metrics inside compute module
* System-level metrics in a separate observability module

---

### Health Check Trade-off

* Default configuration caused delayed failure detection
* Tuned to balance responsiveness and stability

---

## Security Considerations

* Instances deployed in private subnets
* No direct public access to compute layer
* Security groups restrict traffic between layers
* IAM roles follow least privilege principles

---

## What This Project Demonstrates

```
- Infrastructure design beyond basic provisioning  
- Failure analysis and system behavior understanding  
- Observability-driven improvements  
- Clean Terraform module architecture  
- Production-oriented thinking  
```

---

## Future Architecture

The system will evolve into a more production-grade setup.

Planned additions:

* Remote state (S3 + DynamoDB)
* RDS (data layer)
* Centralized logging (CloudWatch and ALB logs)
* SNS-based alerting
* IAM execution roles
* Cost optimization strategies

Refer to `architecture.yml` for the target architecture design.

---

## How to Use

### Initialize

```bash
terraform init
```

---

### Plan

```bash
terraform plan
```

---

### Apply

```bash
terraform apply
```

---

### Access Application

```bash
terraform output alb_dns_name
```

---

## Key Takeaways

```
Infrastructure that works is not enough

You must understand:
- How it fails
- How it recovers
- How you detect failure
```

---

## Author

Omkar Parab
