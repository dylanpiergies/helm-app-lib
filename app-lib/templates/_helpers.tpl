{{/*
Expand the name of the chart.
*/}}
{{- define "app-lib.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "app-lib.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Build the default fully qualified app name for, e.g. a sibling chart.
This applies the same trimming logic as app-lib.fullname. This won't work if the related chart has its name or
fullname overridden.
*/}}
{{- define "app-lib.relativeFullname" -}}
{{- $name := .relativeName }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "app-lib.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "app-lib.labels" -}}
app: {{ include "app-lib.fullname" . }}
helm.sh/chart: {{ include "app-lib.chart" . }}
{{ include "app-lib.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "app-lib.selectorLabels" -}}
app.kubernetes.io/name: {{ include "app-lib.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "app-lib.serviceAccountName" -}}
{{- if .Values.serviceAccount }}
{{- if .Values.serviceAccount.create }}
{{- default (include "app-lib.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Dump an object to YAML or render a string as template code.
*/}}
{{- define "app-lib.renderedValue" -}}
{{- if kindIs "string" .value }}
{{- tpl .value . }}
{{- else }}
{{- toYaml .value }}
{{- end }}
{{- end }}

{{/*
Build the image reference.
*/}}
{{- define "app-lib.image" -}}
{{- $image := "" -}}
{{- if kindIs "map" .Values.image -}}
{{- if .Values.image.registry -}}
{{- $image = printf "%s/" .Values.image.registry -}}
{{- else if .Values.global -}}
{{- if .Values.global.containerRegistry -}}
{{- $image = printf "%s/" .Values.global.containerRegistry -}}
{{- end -}}
{{- end -}}
{{- if .Values.image.repository -}}
{{- $image = printf "%s%s" $image .Values.image.repository -}}
{{- end -}}
{{- if .Values.image.digest -}}
{{- $image = printf "%s@%s" $image .Values.image.digest -}}
{{- else if .Values.image.tag -}}
{{- $image = printf "%s:%s" $image .Values.image.tag -}}
{{- else if .Chart.AppVersion -}}
{{- $image = printf "%s:%s" $image .Chart.AppVersion -}}
{{- end -}}
{{- else if kindIs "string" .Values.image -}}
{{- $image = .Values.image -}}
{{- end -}}
{{- tpl $image . -}}
{{- end }}
