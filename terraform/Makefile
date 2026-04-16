PLAN_DIR = plans

ENV ?= dev

PLAN_FILE = $(PLAN_DIR)/$(ENV).tfplan
DESTROY_PLAN = $(PLAN_DIR)/$(ENV)-destroy.tfplan

TFVARS = envs/$(ENV).tfvars


$(PLAN_DIR):
	@if not exist $(PLAN_DIR) mkdir $(PLAN_DIR)


.PHONY: init
init:
	terraform init


.PHONY: fmt
fmt:
	terraform fmt -recursive


.PHONY: validate
validate:
	terraform validate


.PHONY: plan
plan: $(PLAN_DIR)
	terraform plan -var-file=$(TFVARS) -out=$(PLAN_FILE)


.PHONY: check
check: fmt validate plan


.PHONY: apply
apply:
	terraform apply $(PLAN_FILE)


.PHONY: deploy
deploy: check
	@echo Environment: $(ENV)
	@echo About to apply Terraform plan: $(PLAN_FILE)
	@set /p confirm="Proceed? (yes/no): " && \
	if /I "%confirm%"=="yes" ( \
		terraform apply $(PLAN_FILE) \
	) else ( \
		echo Aborted. \
	)


.PHONY: destroy-plan
destroy-plan: $(PLAN_DIR)
	terraform plan -destroy -var-file=$(TFVARS) -out=$(DESTROY_PLAN)


.PHONY: destroy
destroy:
	terraform apply $(DESTROY_PLAN)


.PHONY: clean
clean:
	@if exist $(PLAN_DIR) rmdir /s /q $(PLAN_DIR)
