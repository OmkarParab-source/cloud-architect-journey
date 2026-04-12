# Terraform Tagging Policy

---

## Global Tags (applied via provider)

```hcl
global_tags = {
  Service     = "<system-name>"
  Environment = "<dev | staging | prod | shared>"
  Owner       = "omkar"
  ManagedBy   = "terraform"
}
```

## Resource Tags (per resource)

```hcl
tags = {
  Name  = "<service>-<env>-<resource>"
  Layer = "<networking | compute | platform | observability>"
}
```

## Naming Convention

```
<service>-<environment>-<resource>
```

## Examples

### terraform-state-backend

```hcl
global_tags = {
  Service     = "terraform-backend"
  Environment = "shared"
  Owner       = "omkar"
  ManagedBy   = "terraform"
  Layer       = "platform"
}
```

```
Name = "terraform-backend-shared-s3"
Name = "terraform-backend-shared-lock"
```

### cloud-architect-journey (dev)

```hcl
global_tags = {
  Service     = "cloud-arch"
  Environment = "dev"
  Owner       = "omkar"
  ManagedBy   = "terraform"
}
```

```
Name  = "cloud-arch-dev-vpc"
Layer = "networking"
```

```
Name  = "cloud-arch-dev-asg"
Layer = "application"
```
