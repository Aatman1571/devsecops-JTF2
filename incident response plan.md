# Incident Response Plan

This plan defines the steps to be taken when alerts or failures are detected during pipeline execution or monitoring.

## 🔔 Triggering Conditions

- **Security Scan Failure**: `security_scan_status{status="failure"}`
- **CI/CD Failure**: `ci_pipeline_status{status="failure"}`
- **IaC Provisioning Error**
- **App Deployment Unreachable via Ngrok**

## 🛠️ Response Workflow

| Step | Action |
|------|--------|
| 1. Detect | Prometheus will collect metric values indicating a `failure` status. Alerts can be set on these metrics. |
| 2. Identify | Review GitHub Actions logs for the failed stage (e.g., `dast-scan`, `iac-provision`). |
| 3. Triage | Determine whether the issue is due to code (vulnerability), infrastructure (Terraform), or pipeline misconfiguration. |
| 4. Mitigation | - Re-run pipeline if transient.<br>- Fix vulnerability or misconfiguration.<br>- Roll back if deployment caused an issue. |
| 5. Communication | Inform the team via Slack/email with the pipeline run URL and status. |
| 6. Post-Mortem | Document root cause and update codebase, Terraform config, or pipeline as needed to prevent recurrence. |

## 🔧 Sample Prometheus Alert Rule (for future setup)

```yaml
groups:
- name: devsecops-alerts
  rules:
  - alert: SecurityScanFailed
    expr: security_scan_status{status="failure"} == 1
    for: 1m
    labels:
      severity: high
    annotations:
      summary: "Security scan failed"
      description: "Check Dependency or DAST scan stage in GitHub Actions"
