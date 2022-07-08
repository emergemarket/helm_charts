{{/*
Expand the name of the chart.
*/}}
{{- define "helm.fullname" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "mssql-latest.name" -}}
{{ (list (include "helm.fullname" .) .Values.globalEnv.env "mssql" | join "-") }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mssql-latest.fullname" -}}
{{ include "mssql-latest.name"  .}}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "mssql-latest.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mssql-latest.labels" -}}
helm.sh/chart: {{ include "mssql-latest.chart" . }}
{{ include "mssql-latest.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "mssql-latest.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mssql-latest.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "mssql-latest.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "mssql-latest.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
Create the name for the SA password secret key.
*/}}
{{- define "mssql.sapassword" -}}
  sa_password
{{- end -}}
