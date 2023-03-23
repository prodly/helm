{{/*
Expand the name of the chart.
*/}}
{{- define "kubernetes-service.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kubernetes-service.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kubernetes-service.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kubernetes-service.labels" -}}
helm.sh/chart: {{ include "kubernetes-service.chart" . }}
{{ include "kubernetes-service.selectorLabels" . }}
{{- if .Values.appVersion }}
app.kubernetes.io/version: {{ .Values.appVersion | quote }}
{{- end }}
{{- if .Values.partOf }}
app.kubernetes.io/part-of: {{ .Values.partOf | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
tags.datadoghq.com/env: {{ .Release.Namespace }}
tags.datadoghq.com/service: {{ .Release.Name }}
tags.datadoghq.com/version: {{ .Values.appVersion }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kubernetes-service.selectorLabels" -}}
app.kubernetes.io/name: {{ .Release.Name }}
app.kubernetes.io/instance: {{ include "kubernetes-service.name" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "kubernetes-service.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "kubernetes-service.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
