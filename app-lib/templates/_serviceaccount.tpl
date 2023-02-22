{{- define "app-lib.serviceaccount" -}}
{{- if .Values.serviceAccount -}}
{{- if .Values.serviceAccount.create -}}
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: {{ include "app-lib.serviceAccountName" . }}
  labels:
    {{- include "app-lib.labels" . | nindent 4 }}
  {{- with .Values.serviceAccount.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end }}
{{- end -}}
{{- end -}}
