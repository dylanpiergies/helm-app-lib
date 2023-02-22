{{- define "app-lib.service" -}}
{{- if .Values.service -}}
---
apiVersion: v1
kind: Service
metadata:
  name: {{ include "app-lib.fullname" . }}
  labels:
    {{- include "app-lib.labels" . | nindent 4 }}
spec:
  type: {{ required "service.type is required if service present" .Values.service.type }}
  {{- with .Values.service.ports }}
  ports:
  {{- include "app-lib.renderedValue" (set $ "value" .) | nindent 2 }}
  {{- end }}
  selector:
    {{- include "app-lib.selectorLabels" . | nindent 4 }}
{{- end -}}
{{- end -}}
