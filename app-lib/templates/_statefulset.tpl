{{- define "app-lib.statefulset" -}}
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: {{ include "app-lib.fullname" . }}
  labels:
    {{- include "app-lib.labels" . | nindent 4 }}
spec:
  serviceName: {{ include "app-lib.fullname" . }}
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
