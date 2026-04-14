# Environment Strategy

## Objective

Design environments that balance cost efficiency, performance, and predictable system behavior while maintaining architectural consistency.

---

## Core Principle

All environments follow the same architectural pattern.

Differences between environments are introduced through:
- scaling behavior
- availability configuration
- observability levels
- failure tolerance

Auto Scaling Groups (ASG) are used in all environments for lifecycle consistency.

Scaling behavior is enabled only where required.

---

## Environments

### DEV (Development)

Purpose:
- support application development
- enable fast iteration and testing

Characteristics:
- single availability zone (acceptable)
- minimal infrastructure
- cost optimized
- focused on functional validation

Configuration:
- asg_min: 1
- asg_desired: 1
- asg_max: 1
- scaling disabled
- nat_per_az: false

Observability:
- minimal logging
- alerts are informational (used to detect saturation, not trigger action)

Trade-offs:
- downtime is acceptable
- no high availability
- scaling behavior is not validated

Notes:
- ASG is retained to ensure consistent deployment and instance lifecycle behavior across environments

---

### UAT (Infrastructure Validation)

Purpose:
- validate infrastructure behavior
- test failure handling and scaling

Characteristics:
- multi-AZ compute
- controlled cost
- intentional exposure to certain failure conditions

Configuration:
- asg_min: 2
- asg_desired: 2
- asg_max: 3
- scaling enabled
- nat_per_az: false (single NAT)

Observability:
- moderate logging
- alerts help understand system behavior under stress

Trade-offs:
- NAT is a single point of failure (intentional)
- cross-AZ traffic cost is acceptable due to low traffic
- environment focuses on learning system behavior rather than maximizing resilience

Validation scope:
- instance failure recovery (ASG)
- AZ failure impact on compute
- scaling behavior under load
- NAT dependency impact

---

### STAGING (Production Simulation)

Purpose:
- validate system behavior in conditions close to production

Characteristics:
- architecture aligned with production
- similar failure handling
- reduced scale, but realistic behavior

Configuration:
- asg_min: 2
- asg_desired: 2
- asg_max: 3 or higher
- scaling enabled
- nat_per_az: true

Observability:
- near-production level
- alerts are expected to be meaningful and actionable

Trade-offs:
- reduced scale compared to production
- cost is controlled while maintaining realistic system behavior

Validation scope:
- ALB routing and traffic distribution
- multi-AZ behavior
- failover handling
- observability validation
- scaling response

---

### PROD (Production)

Purpose:
- serve real user traffic reliably

Characteristics:
- multi-AZ architecture
- SLA-driven design
- balance between cost and reliability

Configuration:
- asg_min: 2 or 3 (based on SLA requirements)
- asg_desired: workload-dependent
- asg_max: capacity-driven
- scaling enabled
- nat_per_az: true (if justified)

Observability:
- comprehensive monitoring and alerting
- alerts are actionable and low-noise

Trade-offs:
- higher cost is justified by reliability needs
- redundancy is introduced only where it provides clear benefit

Key considerations:
- defined SLA (e.g., 99%, 99.9%)
- tolerance to instance, AZ, and dependency failures
- predictable scaling under load

---

## Cost Optimization Strategy

Primary cost drivers:
- NAT Gateway (fixed cost)
- EC2 instances (scaling-dependent)
- Load Balancer (baseline cost)
- logging and metrics (usage-based)

Guidelines:
- use a single NAT in DEV and UAT
- accept cross-AZ traffic in low-traffic environments
- keep ASG baseline capacity minimal
- reduce log retention outside production
- avoid unnecessary multi-AZ redundancy

---

## Design Guidelines

- Terraform modules remain environment-agnostic
- environment-specific behavior is controlled through variables and tfvars
- architecture remains consistent across environments
- systems are designed with failure scenarios in mind
- avoid introducing environment-specific logic in code

---

## Summary

DEV:
- minimal, cost-focused, no scaling

UAT:
- validates infrastructure behavior and failure scenarios

STAGING:
- simulates production behavior with realistic conditions

PROD:
- reliable, scalable, and SLA-driven

---

## Key Insight

Environments are not separate systems.

They represent different stages of confidence in the same system, operating under different constraints of cost, scale, and failure tolerance.

ASG ensures lifecycle consistency across environments.

Scaling is an environment-specific behavior, not a mandatory feature.
