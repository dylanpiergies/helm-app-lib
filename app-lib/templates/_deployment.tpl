{{- define "app-lib.deployment" -}}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "app-lib.fullname" . }}
  labels:
    {{- include "app-lib.labels" . | nindent 4 }}
spec:
  {{- $autoscalingEnabled := false }}
  {{- if .Values.autoscaling }}
  {{- if .Values.autoscaling.enabled }}
  {{- $autoscalingEnabled = true }}
  {{- end }}
  {{- end }}
  {{- if not $autoscalingEnabled }}
  replicas: {{ .Values.replicaCount }}
  {{- end }}
  selector:
    matchLabels:
      {{- include "app-lib.selectorLabels" . | nindent 6 }}
  template:
    {{- include "app-lib.podTemplate" . | nindent 4 }}
{{- end -}}
