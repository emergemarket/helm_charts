{{- define "terraform.tplvalues.render" -}}
    {{- if typeIs "string" .value }}
        {{- tpl .value .context | indent 1}}
    {{- else }}
        {{- tpl (.value | toYaml) .context | nindent .indent }}
    {{- end }}
{{- end -}}
