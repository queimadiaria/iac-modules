# iac-modules

Reusable Terraform modules for AWS infrastructure and services.

## Modules

- `modules/secret-manager`: cria segredos no AWS Secrets Manager com versão inicial opcional.

## ECS integration

O módulo de Secret Manager expõe `secret_arn` e `secret_name`, que podem ser usados diretamente no módulo ECS existente na propriedade `secrets` do `container_definitions`.

Exemplo de consumo:

```hcl
module "app_secret" {
	source = "./modules/secret-manager"

	name         = "my-app/db"
	secret_json  = {
		username = "appuser"
		password = "changeme"
	}
	tags = {
		service = "my-app"
	}
}

module "ecs" {
	source = "../your-existing-ecs-module"

	# ...outros inputs do seu módulo ECS

	secrets = [
		{
			name      = "DB_USERNAME"
			valueFrom = "${module.app_secret.secret_arn}:username::"
		},
		{
			name      = "DB_PASSWORD"
			valueFrom = "${module.app_secret.secret_arn}:password::"
		}
	]
}
```
