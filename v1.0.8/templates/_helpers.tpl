{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "zdmp-data-harmonisation-runtime-idp.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "zdmp-data-harmonisation-runtime-idp.fullname" -}}
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
Create chart name and version as used by the chart label.
*/}}
{{- define "zdmp-data-harmonisation-runtime-idp.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "zdmp-data-harmonisation-runtime-idp.labels" -}}
helm.sh/chart: {{ include "zdmp-data-harmonisation-runtime-idp.chart" . }}
{{ include "zdmp-data-harmonisation-runtime-idp.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "zdmp-data-harmonisation-runtime-idp.selectorLabels" -}}
app.kubernetes.io/name: {{ include "zdmp-data-harmonisation-runtime-idp.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "zdmp-data-harmonisation-runtime-idp.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "zdmp-data-harmonisation-runtime-idp.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

#Added to create a secret
#{{- define "secret" }}
#{{- printf "{\"auths\": {\"%s\": {\"auth\": \"%s\"}}}" .Values.privateRegistry.registryUrl (printf "%s:%s" .Values.privateRegistry.registryUser .Values.privateRegistry.registryPasswd | b64enc) | b64enc }}
#{{- end }}
