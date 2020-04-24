all: assemble-dev assemble-prod

assemble-prod:
	helm install acceleration-calc -f prod.values.yaml

assemble-dev:
	helm install acceleration-calc -f dev.values.yaml

.PHONY: assemble-prod assemble-dev all
