{{/* vim: set filetype=mustache: */}}

{{- define "karmada.name" -}}
{{- "karmada" | default .Release.Name -}}
{{- end -}}

{{- define "karmada.namespace" -}}
{{- .Values.namespace | default .Release.Namespace -}}
{{- end -}}

{{- define "karmada.apiserver.labels" -}}
{{- if .Values.apiServer.labels }}
{{- range $key, $value := .Values.apiServer.labels -}}
{{- $key }}: {{ $value | quote }}
{{- end }}
{{- else}}
app: "{{ include "karmada.name" .}}-apiserver"
{{- end }}
{{- end -}}

{{- define "karmada.apiserver.service.labels" -}}
labels:
{{- if .Values.apiServer.service.labels }}
{{- range $key, $value := .Values.apiServer.service.labels }}
  {{ $key }}: {{ $value | quote }}
{{- end }}
{{- else}}
  app: "{{- include "karmada.name" .}}-apiserver"
{{- end }}
{{- end -}}

{{- define "karmada.apiserver.service.annotations" -}}
{{- if .Values.apiServer.service.annotations -}}
annotations:
{{- range $key, $value := .Values.apiServer.service.annotations }}
  {{ $key }}: {{ $value | quote }}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "karmada.apiserver.podLabels" -}}
{{- if .Values.apiServer.podLabels }}
{{- range $key, $value := .Values.apiServer.podLabels}}
{{- $key }}: {{ $value | quote }}
{{- end }}
{{- end }}
{{- end -}}

{{- define "karmada.aggregatedApiserver.labels" -}}
{{- if .Values.aggregatedApiServer.labels }}
{{- range $key, $value := .Values.aggregatedApiServer.labels}}
{{- $key }}: {{ $value | quote }}
{{- end }}
{{- else}}
app: "{{- include "karmada.name" .}}-aggregated-apiserver"
{{- end }}
{{- end -}}

{{- define "karmada.aggregatedApiserver.podLabels" -}}
{{- if .Values.aggregatedApiServer.podLabels }}
{{- range $key, $value := .Values.aggregatedApiServer.podLabels}}
{{- $key }}: {{ $value | quote }}
{{- end }}
{{- end }}
{{- end -}}

{{- define "karmada.kube-cm.labels" -}}
{{- if .Values.kubeControllerManager.labels }}
{{- range $key, $value := .Values.kubeControllerManager.labels}}
{{- $key }}: {{ $value | quote }}
{{- end }}
{{- else}}
app: "{{- include "karmada.name" .}}-kube-controller-manager"
{{- end }}
{{- end -}}

{{- define "karmada.kube-cm.podLabels" -}}
{{- if .Values.kubeControllerManager.podLabels }}
{{- range $key, $value := .Values.kubeControllerManager.podLabels}}
{{- $key }}: {{ $value | quote }}
{{- end }}
{{- end }}
{{- end -}}

{{- define "karmada.kubeconfig.volume" -}}
{{- $name := include "karmada.name" . -}}
- name: kubeconfig-secret
  secret:
    secretName: {{ include "karmada.name" .}}-kubeconfig
{{- end -}}

{{- define "karmada.kubeconfig.volumeMount" -}}
{{- $name := include "karmada.name" . -}}
- name: kubeconfig-secret
  subPath: kubeconfig
  mountPath: /etc/kubeconfig
{{- end -}}

{{- define "karmada.cm.labels" -}}
{{- if .Values.controllerManager.labels -}}
{{- range $key, $value := .Values.controllerManager.labels}}
{{- $key }}: {{ $value | quote }}
{{- end -}}
{{- else -}}
app: "{{- include "karmada.name" .}}-controller-manager"
{{- end -}}
{{- end -}}

{{- define "karmada.cm.podLabels" -}}
{{- if .Values.controllerManager.podLabels }}
{{- range $key, $value := .Values.controllerManager.podLabels}}
{{- $key }}: {{ $value | quote}}
{{- end }}
{{- end }}
{{- end -}}


{{- define "karmada.scheduler.labels" -}}
{{- if .Values.scheduler.labels -}}
{{- range $key, $value := .Values.scheduler.labels}}
{{- $key }}: {{ $value | quote }}
{{- end -}}
{{- else -}}
app: "{{- include "karmada.name" .}}-scheduler"
{{- end -}}
{{- end -}}

{{- define "karmada.scheduler.podLabels" -}}
{{- if .Values.scheduler.podLabels }}
{{- range $key, $value := .Values.scheduler.podLabels}}
{{- $key }}: {{ $value | quote }}
{{- end }}
{{- end }}
{{- end -}}


{{- define "karmada.descheduler.labels" -}}
{{- if .Values.descheduler.labels -}}
{{- range $key, $value := .Values.descheduler.labels}}
{{- $key }}: {{ $value | quote }}
{{- end -}}
{{- else -}}
app: "{{- include "karmada.name" .}}"
{{- end -}}
{{- end -}}

{{- define "karmada.descheduler.podLabels" -}}
{{- if .Values.descheduler.podLabels }}
{{- range $key, $value := .Values.descheduler.podLabels}}
{{- $key }}: {{ $value | quote }}
{{- end }}
{{- end }}
{{- end -}}

{{- define "karmada.descheduler.kubeconfig.volume" -}}
- name: kubeconfig-secret
  secret:
    secretName: karmada-kubeconfig
{{- end -}}


{{- define "karmada.webhook.labels" -}}
{{- if .Values.webhook.labels }}
{{- range $key, $value := .Values.webhook.labels}}
{{- $key }}: {{ $value | quote }}
{{- end }}
{{- else}}
app: "{{- include "karmada.name" .}}-webhook"
{{- end }}
{{- end -}}

{{- define "karmada.webhook.podLabels" -}}
{{- if .Values.webhook.podLabels }}
{{- range $key, $value := .Values.webhook.podLabels}}
{{- $key }}: {{ $value | quote }}
{{- end }}
{{- end }}
{{- end -}}


{{- define "karmada.agent.labels" -}}
{{- if .Values.agent.labels }}
{{- range $key, $value := .Values.agent.labels}}
{{- $key }}: {{ $value | quote }}
{{- end }}
{{- else}}
app: "{{- include "karmada.name" .}}"
{{- end }}
{{- end -}}

{{- define "karmada.agent.podLabels" -}}
{{- if .Values.agent.podLabels }}
{{- range $key, $value := .Values.agent.podLabels }}
{{- $key }}: {{ $value | quote }}
{{- end }}
{{- end }}
{{- end -}}

{{- define "karmada.webhook.caBundle" -}}
{{- if eq .Values.certs.mode "auto" }}
caBundle: {{ print "{{ ca_crt }}" }}
{{- end }}
{{- if eq .Values.certs.mode "custom" }}
caBundle: {{ b64enc .Values.certs.custom.caCrt }}
{{- end }}
{{- end -}}

{{- define "karmada.schedulerEstimator.podLabels" -}}
{{- if .Values.schedulerEstimator.podLabels }}
{{- range $key, $value := .Values.schedulerEstimator.podLabels}}
{{- $key }}: {{ $value | quote }}
{{- end }}
{{- end }}
{{- end -}}

{{- define "karmada.schedulerEstimator.labels" -}}
{{- if .Values.schedulerEstimator.labels }}
{{- range $key, $value := .Values.schedulerEstimator.labels}}
{{- $key }}: {{ $value | quote }}
{{- end }}
{{- end }}
{{- end -}}

{{- define "karmada.search.labels" -}}
{{- if .Values.search.labels -}}
{{ range $key, $value := .Values.search.labels }}
{{ $key }}: {{ $value | quote }}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "karmada.search.podLabels" -}}
{{- if .Values.search.podLabels }}
{{- range $key, $value := .Values.search.podLabels}}
{{- $key }}: {{ $value | quote }}
{{- end }}
{{- end }}
{{- end -}}
