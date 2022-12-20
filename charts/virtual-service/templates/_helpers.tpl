{{- define "labels" -}}
labels:
{{- if .Values.metadata.labels -}}
{{- range $key, $value := .Values.metadata.labels -}}
  {{ $key }}: {{ $value | quote -}}
{{- end -}}
{{- else}}
  app: {{ .Values.metadata.name }}
{{- end }}
{{- end -}}

{{- define "annotations" -}}
annotations:
{{- if .Values.metadata.annotations -}}
{{- range $key, $value := .Values.metadata.annotations }}
  {{ $key }}: {{ $value | quote }}
{{- end -}}
{{- else}}
  app: {{ .Values.metadata.name }}
{{- end -}}
{{- end -}}