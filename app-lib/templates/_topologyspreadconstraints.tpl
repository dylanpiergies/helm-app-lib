{{- define "app-lib.simpleHighAvailTopologySpreadConstraints" -}}
- labelSelector:
    matchLabels:
      {{- include "app-lib.selectorLabels" . | nindent 6 }}
  topologyKey: topology.kubernetes.io/region
  whenUnsatisfiable: {{ .Values.topologySpread.whenRegionUnsatisfiable | default "ScheduleAnyway" }}
- labelSelector:
    matchLabels:
      {{- include "app-lib.selectorLabels" . | nindent 6 }}
  topologyKey: topology.kubernetes.io/zone
  whenUnsatisfiable: {{ .Values.topologySpread.whenZoneUnsatisfiable | default "ScheduleAnyway" }}
- labelSelector:
    matchLabels:
      {{- include "app-lib.selectorLabels" . | nindent 6 }}
  topologyKey: kubernetes.io/hostname
  whenUnsatisfiable: {{ .Values.topologySpread.whenHostnameUnsatisfiable | default "DoNotSchedule" }}
{{- end }}
