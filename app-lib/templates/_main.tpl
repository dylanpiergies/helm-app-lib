{{- define "app-lib.main" -}}
{{ $controllerKind := .Values.controllerKind | default "Deployment" }}
{{- if eq $controllerKind "Deployment" }}
{{ include "app-lib.deployment" . }}
{{- else if eq $controllerKind "StatefulSet" }}
{{ include "app-lib.statefulset" . }}
{{- else }}
  {{ fail "Unknown controller type." }}
{{- end }}
{{ include "app-lib.service" . }}
{{ include "app-lib.hpa" . }}
{{ include "app-lib.serviceaccount" . }}
{{- end -}}
