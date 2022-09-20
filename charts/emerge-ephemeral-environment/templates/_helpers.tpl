
{{- define "mssql.hostnames" -}}
{{- $EventFlow := "" -}}
{{- $Orleans := "" -}}
{{- $DataWarehouse := "" -}}
{{- $Market := "" -}}
{{- if (((.Values.vault).secrets).ConnectionStrings__EventFlow) -}}
{{ $EventFlow = (regexReplaceAll "=.*:(.*)," (regexFind "=.*:(.*)," ((.Values.vault).secrets.ConnectionStrings__EventFlow) ) "${1}" )}}
{{- end -}}
{{- if ((.Values.vault).secrets.Orleans__MembershipConnectionString) -}}
{{ $Orleans = (regexReplaceAll "=.*:(.*)," (regexFind "=.*:(.*)," ((.Values.vault).secrets.Orleans__MembershipConnectionString) ) "${1}" )}}
{{- end -}}
{{- if ((.Values.vault).secrets.ConnectionStrings__DataWarehouse) -}}
{{ $DataWarehouse = (regexReplaceAll "=.*:(.*)," (regexFind "=.*:(.*)," ((.Values.vault).secrets.ConnectionStrings__DataWarehouse) ) "${1}")}}
{{- end }}
{{- if ((.Values.vault).secrets.ConnectionStrings__Market) -}}
{{ $Market = (regexReplaceAll "=.*:(.*)," (regexFind "=.*:(.*)," ((.Values.vault).secrets.ConnectionStrings__Market) ) "${1}") }}
{{- end -}}
{{- list $EventFlow $Orleans $DataWarehouse $Market | compact | uniq | toYaml -}}
{{- end -}}

{{- define "mssql-latest.name" -}}
{{ list (include "helm.fullname" .) (.Values.global.environment.name) "mssql" | join "-" }}
{{- end }}
{{- define "mssql-latest.fullname" -}}
{{ include "mssql-latest.name"  .}}
{{- end }}
{{- define "mssql-latest.labels" -}}
helm.sh/chart: {{ include "mssql-latest.chart" . }}
{{ include "mssql-latest.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion  }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}

{{- end }}

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
{{ "mongodb-database" }}
{{- end }}

{{- define "mongodb.resource.name" -}}
{{ (list (.Values.mongodb.resource.name) (.Values.global.environment.name)) | join "-" }}
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

{{- define "mongodb.dbaddresses" -}}
{{- $thisrange := until (.Values.mongodb.resource.members | int) -}}
{{- $servicename := (include "mongodb.database.name" .) -}}
{{- $environmentname := .Values.global.environment.name -}}
{{- range $i, $e := $thisrange -}}
mongodb-database-{{ $e }}.{{ $servicename }}-svc.{{ $environmentname }}.svc.cluster.local:27017,
{{- end }}
{{- end }}

{{- define "mongodb.serviceaddress" -}}
{{- $servicename := (include "mongodb.database.name" .) -}}
{{- $environmentname := .Values.global.environment.name -}}
{{ $servicename }}-svc.{{ $environmentname }}.svc.cluster.local:27017
{{- end }}
