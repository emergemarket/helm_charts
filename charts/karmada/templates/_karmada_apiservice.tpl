{{- define "karmada.apiservice" -}}
{{- $name := include "karmada.name" . -}}
---
apiVersion: apiregistration.k8s.io/v1
kind: APIService
metadata:
  name: v1alpha1.cluster.karmada.io
  labels:
    app: {{ include "karmada.name" .}}-aggregated-apiserver
    apiserver: "true"
spec:
  insecureSkipTLSVerify: true
  group: cluster.karmada.io
  groupPriorityMinimum: 2000
  service:
    name: {{ include "karmada.name" .}}-aggregated-apiserver
    namespace: {{ include "karmada.namespace" . }}
  version: v1alpha1
  versionPriority: 10
---
apiVersion: v1
kind: Service
metadata:
  name: {{ include "karmada.name" .}}-aggregated-apiserver
  namespace: {{ include "karmada.namespace" . }}
spec:
  type: ExternalName
  externalName: {{ include "karmada.name" .}}-aggregated-apiserver.{{ include "karmada.namespace" . }}.svc.{{ .Values.clusterDomain }}
---
apiVersion: apiregistration.k8s.io/v1
kind: APIService
metadata:
  name: v1alpha1.search.karmada.io
  labels:
    app: {{ include "karmada.name" .}}-search
    apiserver: "true"
spec:
  insecureSkipTLSVerify: true
  group: search.karmada.io
  groupPriorityMinimum: 2000
  service:
    name: {{ include "karmada.name" .}}-search
    namespace: {{ include "karmada.namespace" . }}
  version: v1alpha1
  versionPriority: 10
---
apiVersion: v1
kind: Service
metadata:
  name: {{ include "karmada.name" .}}-search
  namespace: {{ include "karmada.namespace" . }}
spec:
  type: ExternalName
  externalName: {{ include "karmada.name" .}}-search.{{ include "karmada.namespace" . }}.svc.{{ .Values.clusterDomain }}
{{- end -}}
