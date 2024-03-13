{{/*
Expand the name of the chart.
*/}}

{{- define "appname" -}}
{{- printf "%s" .Values.application.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{- define "image" -}}
{{-  default (default .Values.global.image.repository) .Values.application.repository -}}
{{- end -}}

{{- define "tag" -}}
{{-  default (default .Chart.Version .Values.global.image.tag) .Values.application.imageTag -}}
{{- end -}}


{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "base.fullname" -}}
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


{{- define "chartname" -}}
{{- .Chart.Name | trimSuffix "-app" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "base.labels" -}}
helm.sh/chart: {{ include "base.chart" . }}
{{ include "base.selectorLabels" . }}

app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "base.selectorLabels" -}}
app.kubernetes.io/name: {{ include "appname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}






{{- define "serviceAccountName" -}}
  {{ default (include "appname" .) .Values.serviceAccount.name }}
{{- end -}}



