
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