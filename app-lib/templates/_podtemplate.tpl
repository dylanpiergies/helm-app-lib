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
  {{- with .Values.activeDeadlineSeconds }}
  activeDeadlineSeconds: {{ . }}
  {{- end }}
  {{- with .Values.affinity }}
  affinity:
    {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 4 }}
  {{- end }}
  {{- with .Values.automountServiceAccountToken }}
  automountServiceAccountToken: {{ . }}
  {{- end }}
  containers:
  - name: {{ .Chart.Name }}
    {{- with .Values.args }}
    args:
    {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 4 }}
    {{- end }}
    {{- with .Values.command }}
    command:
    {{- include "app-lib.renderedValue" (set $ "value" .) $ | nindent 4 }}
    {{- end }}
    {{- with .Values.env }}
    env:
      {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 4 }}
      {{- with $.Values.extraEnv }}
      {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 4 }}
      {{- end }}
    {{- end }}
    {{- with .Values.envFrom }}
    envFrom:
      {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 4 }}
      {{- with $.Values.extraEnvFrom }}
      {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 4 }}
      {{- end }}
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
    {{- with .Values.lifecycle }}
    lifecycle:
      {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 6 }}
    {{- end }}
    {{- with .Values.livenessProbe }}
    livenessProbe:
      {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 6 }}
    {{- end }}
    {{- with .Values.containerPorts }}
    ports:
    {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 4 }}
    {{- end }}
    {{- with .Values.readinessProbe }}
    readinessProbe:
      {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 6 }}
    {{- end }}
    {{- with .Values.resources }}
    resources:
      {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 6 }}
    {{- end }}
    {{- with .Values.securityContext }}
    securityContext:
      {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 6 }}
    {{- end }}
    {{- with .Values.startupProbe }}
    startupProbe:
      {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 6 }}
    {{- end }}
    {{- with .Values.stdin }}
    stdin: {{ . }}
    {{- end }}
    {{- with .Values.stdinOnce }}
    stdinOnce: {{ . }}
    {{- end }}
    {{- with .Values.terminationMessagePath }}
    terminationMessagePath: {{ . }}
    {{- end }}
    {{- with .Values.terminationMessagePolicy }}
    terminationMessagePolicy: {{ . }}
    {{- end }}
    {{- with .Values.tty }}
    tty: {{ . }}
    {{- end }}
    {{- with .Values.volumeDevices }}
    volumeDevices:
      {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 4 }}
    {{- end }}
    {{- with .Values.volumeMounts }}
    volumeMounts:
      {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 4 }}
    {{- end }}
    {{- with .Values.workingDir }}
    workingDir: {{ . }}
    {{- end }}
  {{- with .Values.dnsConfig }}
  dnsConfig:
    {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 4 }}
  {{- end }}
  {{- with .Values.dnsPolicy }}
  dnsPolicy: {{ . }}
  {{- end }}
  {{- with .Values.enableServiceLinks }}
  enableServiceLinks: {{ . }}
  {{- end }}
  {{- with .Values.ephemeralContainers }}
  ephemeralContainers:
  {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 2 }}
  {{- end }}
  {{- with .Values.hostAliases }}
  hostAliases:
  {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 2 }}
  {{- end }}
  {{- with .Values.hostIPC }}
  hostIPC: {{ . }}
  {{- end }}
  {{- with .Values.hostNetwork }}
  hostNetwork: {{ . }}
  {{- end }}
  {{- with .Values.hostPID }}
  hostPID: {{ . }}
  {{- end }}
  {{- with .Values.hostUsers }}
  hostUsers: {{ . }}
  {{- end }}
  {{- with .Values.hostname }}
  hostname: {{ . }}
  {{- end }}
  {{- with .Values.imagePullSecrets }}
  imagePullSecrets:
  {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 2 }}
  {{- end }}
  {{- with .Values.initContainers }}
  initContainers:
  {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 2 }}
  {{- end }}
  {{- with .Values.nodeName }}
  nodeName: {{ . }}
  {{- end }}
  {{- with .Values.nodeSelector }}
  nodeSelector:
    {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 4 }}
  {{- end }}
  {{- with .Values.os }}
  os:
    {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 4 }}
  {{- end }}
  {{- with .Values.overhead }}
  overhead:
    {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 4 }}
  {{- end }}
  {{- with .Values.preemptionPolicy }}
  preemptionPolicy: {{ . }}
  {{- end }}
  {{- with .Values.priority }}
  priority: {{ . }}
  {{- end }}
  {{- with .Values.priorityClassName }}
  priorityClassName: {{ . }}
  {{- end }}
  {{- with .Values.readinessGates }}
  readinessGates:
  {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 2 }}
  {{- end }}
  {{- with .Values.resourceClaims }}
  resourceClaims:
  {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 2 }}
  {{- end }}
  {{- with .Values.restartPolicy }}
  restartPolicy: {{ . }}
  {{- end }}
  {{- with .Values.runtimeClassName }}
  runtimeClassName: {{ . }}
  {{- end }}
  {{- with .Values.schedulerName }}
  schedulerName: {{ . }}
  {{- end }}
  {{- with .Values.schedulingGates }}
  schedulingGates:
  {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 2 }}
  {{- end }}
  {{- with .Values.podSecurityContext }}
  securityContext:
    {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 4 }}
  {{- end }}
  {{- with (include "app-lib.serviceAccountName" .) }}
  serviceAccountName: {{ . }}
  {{- end }}
  {{- with .Values.setHostnameAsFQDN }}
  setHostnameAsFQDN: {{ . }}
  {{- end }}
  {{- with .Values.shareProcessNamespace }}
  shareProcessNamespace: {{ . }}
  {{- end }}
  {{- with .Values.subdomain }}
  subdomain: {{ . }}
  {{- end }}
  {{- with .Values.terminationGracePeriodSeconds }}
  terminationGracePeriodSeconds: {{ . }}
  {{- end }}
  {{- with .Values.tolerations }}
  tolerations:
  {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 2 }}
  {{- end }}
  {{- with .Values.topologySpreadConstraints }}
  topologySpreadConstraints:
  {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 2 }}
  {{- end }}
  {{- with .Values.volumes }}
  volumes:
  {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 2 }}
  {{- end }}
{{- end -}}
