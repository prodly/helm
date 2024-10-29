{{/*
Expand the name of the chart.
*/}}
{{- define "kubernetes-service-daemonset.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "kubernetes-service-daemonset.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kubernetes-service-daemonset.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kubernetes-service-daemonset.labels" -}}
helm.sh/chart: {{ include "kubernetes-service-daemonset.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.appVersion }}
app.kubernetes.io/version: {{ .Values.appVersion | quote }}
tags.datadoghq.com/version: {{ .Values.appVersion | quote }}
{{- end }}
{{ include "kubernetes-service-daemonset.selectorLabels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kubernetes-service-daemonset.selectorLabels" -}}
app.kubernetes.io/name: {{ .Release.Name }}
app.kubernetes.io/instance: {{ include "kubernetes-service-daemonset.name" . }}
tags.datadoghq.com/env: {{ .Release.Namespace | quote }}
tags.datadoghq.com/service: {{ .Release.Name | quote }}
{{- if .Values.partOf }}
app.kubernetes.io/part-of: {{ .Values.partOf | quote }}
{{- end }}
{{- end }}

{{/*
Version labels
*/}}
{{- define "kubernetes-service-daemonset.versionLabels" -}}
{{- if .Values.appVersion }}
app.kubernetes.io/version: {{ .Values.appVersion | quote }}
tags.datadoghq.com/version: {{ .Values.appVersion | quote }}
{{- end }}
{{- end }}
{{/*
Create the name of the service account to use
*/}}
{{- define "kubernetes-service-daemonset.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "kubernetes-service-daemonset.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Trim -background from service name if required ie: metadata-background-service
*/}}
{{- define "kubernetes-service-daemonset.trimSuffixBackground" -}}
{{- $name := . -}}
{{- if hasSuffix "-background" $name -}}
{{- $name | trimSuffix "-background" -}}
{{- else -}}
{{- $name -}}
{{- end -}}
{{- end -}}
