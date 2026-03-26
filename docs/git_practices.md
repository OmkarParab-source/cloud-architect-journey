# Git Practices & Contribution Guidelines

---

## 📌 Overview

This document defines the Git workflow, commit conventions, and collaboration standards for this repository.

The goal is to ensure:

* Clean and readable commit history
* Consistent development practices
* Production-grade version control discipline
* Ease of collaboration and future scalability

---

## 🧠 Core Principles

* **Atomic commits** — each commit represents a single logical change
* **Clarity over speed** — commit messages must be meaningful
* **Traceability** — every change should be explainable from history
* **Stability** — `main` branch must always be deployable
* **Security-first** — never commit secrets or state files

---

## 🏷️ Commit Message Convention

We follow a structured commit format inspired by  *Conventional Commits* :

```text
<type>: <concise description>
```

---

### ✅ Allowed Types

| Type         | Description                                         |
| ------------ | --------------------------------------------------- |
| `feat`     | New feature or capability                           |
| `fix`      | Bug fix                                             |
| `infra`    | Infrastructure changes (Terraform, AWS resources)   |
| `refactor` | Code restructuring without functional change        |
| `docs`     | Documentation updates                               |
| `chore`    | Non-functional changes (naming, formatting, config) |
| `test`     | Test-related changes                                |

---

### 📌 Examples

```text
feat: add VPC resource
infra: implement auto scaling group
fix: correct route table association
refactor: split networking into separate modules
docs: add scaling behavior explanation
chore: rename infra.yml to architecture.yaml
```

---

### ❌ Anti-Patterns

Avoid vague or non-informative messages:

```text
update
changes
final
misc fixes
```

---

## 📦 Commit Guidelines

A good commit should:

* Address a **single concern**
* Be **self-contained and reversible**
* Be understandable **without external context**

---

### ✅ Good Practice

* One resource addition per commit
* Separate commits for refactor vs feature
* Clear intent in message

---

### ❌ Bad Practice

* Large, mixed changes in a single commit
* Combining feature + fix + refactor
* Committing without review

---

## 🔄 Development Workflow

---

### Standard Workflow

```bash
git status
git add .
git commit -m "feat: add VPC resource"
git push
```

---

### Pre-Commit Checklist

* Is the change logically scoped?
* Is the commit message clear?
* Are any secrets or state files included?
* Does the change keep the system in a valid state?

---

## 🌿 Branching Strategy

---

### Main Branch

```text
main → stable, production-ready branch
```

* Always deployable
* No direct experimental changes

---

### Feature Branch Naming

```text
feature/<short-description>
```

#### Examples:

```text
feature/vpc-setup
feature/alb-implementation
feature/auto-scaling
```

---

### Fix Branch Naming

```text
fix/<short-description>
```

---

## 🔀 Pull Request (PR) Guidelines

---

### 1. Create Feature Branch

```bash
git checkout -b feature/<name>
```

---

### 2. Commit Changes

```bash
git add .
git commit -m "feat: add VPC resource"
```

---

### 3. Push Branch

```bash
git push origin feature/<name>
```

---

### 4. Create Pull Request

#### PR Title

```text
feat: add VPC infrastructure
```

---

#### PR Description

```text
## Summary
Implemented VPC with CIDR 10.0.0.0/16

## Changes
- Added VPC resource
- Configured tags

## Notes
Forms the base networking layer for future resources
```

---

### 5. Merge Strategy

Use:

```text
✔ Squash and merge
```

This ensures:

* Clean history
* One commit per logical change

---

## 🧹 Repository Hygiene

---

### ❌ Never Commit

```text
.terraform/
*.tfstate
*.tfstate.*
*.tfvars
.env
```

---

### If accidentally committed

```bash
git rm -r --cached .terraform
```

---

## 📈 Commit Frequency Strategy

Commit when:

* A resource is added
* A configuration is updated
* A bug is fixed
* A learning milestone is completed

---

### Example Progression

```text
feat: add VPC and subnets
feat: add internet gateway and routing
feat: add application load balancer
infra: implement auto scaling group
infra: add target tracking scaling policy
```

---

## 🏷️ Version Tagging (Optional)

Use tags to mark milestones:

```bash
git tag v1.0-networking
git tag v2.0-scaling
git push origin --tags
```

---

## 🧠 Mental Model

```text
Git = history of decisions
Commits = intent
Branches = experimentation
Main = source of truth
```

---

## 🎯 Key Insight

> A well-structured Git history is a long-term engineering asset.
> It reflects not only *what* was built, but *how and why* it evolved.

---

## 🚀 Future Enhancements

* Pre-commit hooks (Terraform fmt, validate)
* CI/CD integration (GitHub Actions)
* Branch protection rules
* Automated checks

---

## 📘 Final Principle

> If someone unfamiliar with the project reads your commit history,
> they should understand the system without additional explanation.

---
