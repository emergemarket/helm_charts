{{- define "helm.fullname" -}}
{{- default .Chart.Name (.Values.nameOverride) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "mongodb.name" -}}
{{ (list (include "helm.fullname" .) (.Values.global.environment.name) "mongodb") | join "-" }}
{{- end }}

{{- define "mongodb.operator.name" -}}
{{ (list (include "helm.fullname" .) "operator") | join "-" }}
{{- end }}

{{- define "mongodb.database.name" -}}
{{ .Values.database.name }}
{{- end }}

{{- define "mongodb.resource.name" -}}
{{ (list (.Values.resource.name) (.Values.global.environment.name)) | join "-" }}
{{- end }}

{{- define "mongodb.podAnnotations" -}}
vault.security.banzaicloud.io/vault-addr: "https://vault.infra:8200"
vault.security.banzaicloud.io/vault-skip-verify: "true"
vault.security.banzaicloud.io/vault-env-daemon: "true"
vault.security.banzaicloud.io/enable-json-log: "true"
vault.security.banzaicloud.io/mutate-configmap: "true"
vault.security.banzaicloud.io/vault-max-retries: "10"
vault.security.banzaicloud.io/vault-client-timeout: 2m
vault.security.banzaicloud.io/vault-role: application
{{- end }}
