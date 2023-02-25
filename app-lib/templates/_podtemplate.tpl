{{/*
Pod template
*/}}
{{- define "app-lib.podTemplate" -}}
metadata:
  {{- with .Values.podAnnotations }}
  annotations:
    {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 4 }}
  {{- end }}
  labels:
    {{- include "app-lib.labels" . | nindent 4 }}
spec:
  {{- with .Values.imagePullSecrets }}
  imagePullSecrets:
    {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 4 }}
  {{- end }}
  {{- with (include "app-lib.serviceAccountName" .) }}
  serviceAccountName: {{ . }}
  {{- end }}
  {{- with .Values.podSecurityContext }}
  securityContext:
    {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 4 }}
  {{- end }}
  containers:
  - name: {{ .Chart.Name }}
    {{- with .Values.securityContext }}
    securityContext:
      {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 6 }}
    {{- end }}
    image: {{ include "app-lib.image" . | quote }}
    {{- $imagePullPolicy := "" }}
    {{- if .Values.global }}
    {{- with .Values.global.imagePullPolicy }}
    {{- $imagePullPolicy = . }}
    {{- end }}
    {{- end }}
    {{- with .Values.imagePullPolicy }}
    {{- $imagePullPolicy = . }}
    {{- end }}
    {{- with $imagePullPolicy }}
    imagePullPolicy: {{ . }}
    {{- end }}
    {{- with .Values.command }}
    command:
    {{- include "app-lib.renderedValue" (set $ "value" .) $ | nindent 4 }}
    {{- end }}
    {{- with .Values.args }}
    args:
    {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 4 }}
    {{- end }}
    {{- with .Values.containerPorts }}
    ports:
    {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 4 }}
    {{- end }}
    {{- with .Values.env }}
    env:
      {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 4 }}
      {{- with $.Values.extraEnv }}
      {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 4 }}
      {{- end }}
    {{- end }}
    {{- with .Values.livenessProbe }}
    livenessProbe:
      {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 6 }}
    {{- end }}
    {{- with .Values.startupProbe }}
    startupProbe:
      {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 6 }}
    {{- end }}
    {{- with .Values.readinessProbe }}
    readinessProbe:
      {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 6 }}
    {{- end }}
    {{- with .Values.resources }}
    resources:
      {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 6 }}
    {{- end }}
    {{- with .Values.volumeMounts }}
    volumeMounts:
      {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 4 }}
    {{- end }}
  {{- with .Values.nodeSelector }}
  nodeSelector:
    {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 4 }}
  {{- end }}
  {{- with .Values.affinity }}
  affinity:
    {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 4 }}
  {{- end }}
  {{- with .Values.tolerations }}
  tolerations:
    {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 4 }}
  {{- end }}
  {{- with .Values.volumes }}
  volumes:
    {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 2 }}
  {{- end }}
{{- end -}}
