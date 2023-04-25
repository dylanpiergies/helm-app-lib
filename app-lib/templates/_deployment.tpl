{{- define "app-lib.deployment" -}}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "app-lib.fullname" . }}
  labels:
    {{- include "app-lib.labels" . | nindent 4 }}
spec:
  {{- with .Values.minReadySeconds }}
  minReadySeconds: {{ . }}
  {{- end }}
  {{- with .Values.progressDeadlineSeconds }}
  progressDeadlineSeconds: {{ . }}
  {{- end }}
  {{- $autoscalingEnabled := false }}
  {{- if .Values.autoscaling }}
  {{- if .Values.autoscaling.enabled }}
  {{- $autoscalingEnabled = true }}
  {{- end }}
  {{- end }}
  {{- if not $autoscalingEnabled }}
  replicas: {{ .Values.replicaCount | default 1 }}
  {{- end }}
  {{- with .Values.revisionHistoryLimit }}
  revisionHistoryLimit: {{ . }}
  {{- end }}
  selector:
    matchLabels:
      {{- include "app-lib.selectorLabels" . | nindent 6 }}
  {{- with .Values.deploymentStrategy }}
  strategy:
    {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 4 }}
  {{- end }}
  template:
    {{- include "app-lib.podTemplate" . | nindent 4 }}
{{- end -}}
