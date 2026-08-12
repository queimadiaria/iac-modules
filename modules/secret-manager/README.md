# secret-manager

Cria um secret no AWS Secrets Manager com versão inicial opcional.

## Inputs

- `name`: nome do secret.
- `secret_string`: valor simples do secret.
- `secret_json`: mapa convertido para JSON e gravado como string.
- `kms_key_id`: KMS opcional.
- `recovery_window_in_days`: janela de recuperação ao destruir.
- `tags`: tags do recurso.

## Outputs

- `secret_arn`: ARN para consumo em ECS.
- `secret_name`: nome final do secret.
- `secret_id`: ID do recurso.
- `secret_version_id`: versão inicial, quando criada.
- `secret_value_from`: alias do ARN para encaixar direto em `secrets.valueFrom`.

## ECS usage

Quando o secret for armazenado como JSON, o ECS pode consumir chaves específicas com o formato:

```hcl
"${module.app_secret.secret_arn}:username::"
"${module.app_secret.secret_arn}:password::"
```

Se o módulo ECS já aceitar uma lista `secrets`, basta passar o ARN ou o `valueFrom` no formato acima.