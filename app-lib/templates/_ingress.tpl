{{- define "app-lib.ingress" -}}
{{- if .Values.ingress }}
{{- if .Values.ingress.enabled -}}
{{- $fullName := include "app-lib.fullname" . -}}
{{- $svcPort := .Values.ingress.servicePort -}}
{{- if and .Values.ingress.className (not (semverCompare ">=1.18-0" .Capabilities.KubeVersion.GitVersion)) }}
  {{- if not (hasKey .Values.ingress.annotations "kubernetes.io/ingress.class") }}
  {{- $_ := set .Values.ingress.annotations "kubernetes.io/ingress.class" .Values.ingress.className}}
  {{- end }}
{{- end }}
{{- $hosts := default (list) .Values.ingress.hosts }}
---
{{- if semverCompare ">=1.19-0" .Capabilities.KubeVersion.GitVersion -}}
apiVersion: networking.k8s.io/v1
{{- else if semverCompare ">=1.14-0" .Capabilities.KubeVersion.GitVersion -}}
apiVersion: networking.k8s.io/v1beta1
{{- else -}}
apiVersion: extensions/v1beta1
{{- end }}
kind: Ingress
metadata:
  name: {{ $fullName }}
  labels:
    {{- include "app-lib.labels" . | nindent 4 }}
  {{- with .Values.ingress.annotations }}
  annotations:
    {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 4 }}
  {{- end }}
spec:
  {{- if and .Values.ingress.className (semverCompare ">=1.18-0" .Capabilities.KubeVersion.GitVersion) }}
  ingressClassName: {{ .Values.ingress.className }}
  {{- end }}
  {{- if .Values.ingress.tls }}
  tls:
    {{- range .Values.ingress.tls }}
    - hosts:
        {{- range .hosts }}
        - {{ tpl . $ | quote }}
        {{- end }}
      secretName: {{ tpl .secretName $ }}
    {{- end }}
  {{- end }}
  rules:
    {{- range default (list) .Values.ingress.hosts }}
    - host: {{ tpl .host $ | quote }}
      http:
        paths:
          {{- range .paths }}
          - path: {{ .path }}
            {{- if and .pathType (semverCompare ">=1.18-0" $.Capabilities.KubeVersion.GitVersion) }}
            pathType: {{ .pathType }}
            {{- end }}
            backend:
              {{- if semverCompare ">=1.19-0" $.Capabilities.KubeVersion.GitVersion }}
              service:
                name: {{ $fullName }}
                port:
                  {{- if kindIs "string" $svcPort }}
                  name: {{ $svcPort | quote }}
                  {{- else }}
                  number: {{ $svcPort }}
                  {{- end }}
              {{- else }}
              serviceName: {{ $fullName }}
              servicePort: {{ $svcPort }}
              {{- end }}
          {{- end }}
    {{- end }}
{{- end }}
{{- end -}}
{{- end -}}
