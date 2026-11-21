# Linux Server Health Monitoring & Email Alert Automation

## Project Overview

This project demonstrates Linux server health monitoring and email notification automation using Bash scripting and Postfix.

A Bash script (`healthcheck.sh`) is created to automate server health checks and generate a health-check report. Postfix is configured as the mail transfer agent (MTA) to send the generated reports through Gmail SMTP.

The objective is to monitor a Linux server, automate health-check reporting, and receive email notifications without manually checking the server every time.

## Project Objectives

- Create a Bash script for Linux server health monitoring.
- Automate health-check report generation.
- Install and configure Postfix as the mail transfer agent.
- Configure Gmail SMTP relay for outgoing email notifications.
- Configure SASL authentication for secure SMTP communication.
- Enable and manage Linux services using systemctl.
- Verify email delivery and troubleshoot mail logs.
- Prepare the environment for scheduled health-check execution using Cron.

## Technologies & Tools Used

| Technology | Purpose |
|---|---|
| Linux (CentOS/RHEL) | Operating system |
| Bash Shell Scripting | Health-check automation |
| Postfix | Mail Transfer Agent |
| Gmail SMTP | Email delivery |
| Cyrus SASL | SMTP authentication |
| Cron / Crond | Scheduled task management |
| Mailx | Sending email from the terminal |
| Nmap-Ncat | Network connectivity testing |
| systemctl | Service management |

## Project Architecture
             Linux Server (CentOS/RHEL)
                        |
                        |
                healthcheck.sh
                        |
                        |
              Generate Health Report
                        |
                        |
                  Postfix MTA
                        |
                        |
                SASL Authentication
                        |
                        |
                Gmail SMTP Relay
                 smtp.gmail.com:587
                        |
                        |
                 Email Notification
                        |
                        |
             aieraversion@gmail.com
```

## Implementation Steps

### Step 1: Verify the Linux Environment

Check the existing files and directories.

```bash
ls -l
ll
```

### Step 2: Create the Health Check Script

Create or edit the Bash health-check script.

```bash
vim healthcheck.sh
```

The script is responsible for performing server health checks and generating a report.

The script can be extended to monitor:

- CPU utilization
- Memory utilization
- Disk space utilization
- Filesystem status
- Running services
- Server uptime
- Network connectivity


### Step 3: Install Postfix

Install Postfix using the package manager.

```bash
sudo yum install postfix -y
```

Enable and start the Postfix service.

```bash
sudo systemctl enable postfix
sudo systemctl start postfix
```

Verify the service status.

```bash
systemctl status postfix
```

### Step 4: Install SMTP Authentication Packages

Install Cyrus SASL authentication support.

```bash
sudo yum install cyrus-sasl-plain -y
```

### Step 5: Install Cron, Mailx and Network Utilities

Install the required packages.

```bash
dnf install -y cronie mailx
```

Enable and start the Cron service.

```bash
systemctl enable --now crond
```

Install Nmap-Ncat.

```bash
dnf install -y nmap-ncat
```

### Step 6: Configure Gmail SMTP Authentication

Open the Postfix SASL password configuration file.

```bash
vim /etc/postfix/sasl_passwd
```

Add the Gmail SMTP authentication entry using your Gmail address and a Gmail App Password.

```text
[smtp.gmail.com]:587 YOUR_GMAIL_ADDRESS:YOUR_GMAIL_APP_PASSWORD
```

**Important:** Never upload your actual Gmail App Password or SMTP credentials to GitHub.

Set secure file permissions.

```bash
chmod 600 /etc/postfix/sasl_passwd
```

Generate the Postfix lookup database.

```bash
postmap /etc/postfix/sasl_passwd
```

### Step 7: Configure Postfix Gmail SMTP Relay

Configure Postfix to use Gmail as the outgoing SMTP relay.

```bash
postconf -e "relayhost = [smtp.gmail.com]:587"

postconf -e "smtp_use_tls = yes"

postconf -e "smtp_tls_security_level = encrypt"

postconf -e "smtp_sasl_auth_enable = yes"

postconf -e "smtp_sasl_password_maps = lmdb:/etc/postfix/sasl_passwd"

postconf -e "smtp_sasl_security_options = noanonymous"

postconf -e "smtp_tls_CAfile = /etc/pki/tls/certs/ca-bundle.crt"
```

Restart Postfix to apply the configuration.

```bash
systemctl restart postfix
```

Verify Postfix.

```bash
systemctl status postfix
```

### Step 8: Test Email Delivery

Send a test email from the Linux server.

```bash
echo "This is a test email from my CentOS VM" | mail -s "CentOS SMTP Test" aieraversion@gmail.com
```

This verifies that the server can submit an email through the configured mail system.

### Step 9: Execute the Health Check Script

Execute the Bash health-check script.

```bash
sudo /root/healthcheck.sh
```

The script should generate the health-check report and send the notification using the configured email mechanism.

### Step 10: Monitor Mail Logs

Check the Postfix mail logs to verify email processing and identify possible delivery errors.

```bash
tail -50 /var/log/maillog
```

## Configuration Verification Commands

Check the Postfix configuration:

```bash
postconf -n
```

Check available Postfix lookup database types:

```bash
postconf -m
```

Check the Postfix service:

```bash
systemctl status postfix
```

Check the Cron service:

```bash
systemctl status crond
```

Check mail logs:

```bash
tail -50 /var/log/maillog
```

## Security Considerations

- Never commit Gmail App Passwords or authentication credentials to GitHub.
- Restrict access to SMTP authentication files using appropriate Linux permissions.
- Use TLS encryption for SMTP communication.
- Avoid storing passwords directly inside Bash scripts.
- Use environment variables or secure credential storage where appropriate.
- Review mail logs regularly to identify delivery failures.

## Expected Outcome

After completing the configuration:

1. The Linux server can execute the health-check Bash script.
2. The script can generate a server health report.
3. Postfix handles outgoing email communication.
4. Gmail SMTP relay provides external email delivery.
5. Health-check notifications can be delivered to the configured recipient.
6. Mail logs can be used to troubleshoot email delivery issues.

## Skills Demonstrated

- Linux System Administration
- Bash Shell Scripting
- Linux Service Management
- SMTP Configuration
- Postfix Administration
- Gmail SMTP Integration
- SASL Authentication
- Linux Package Management
- Cron Job Management
- Troubleshooting and Log Analysis

---

**Project:** Linux Server Health Monitoring & Email Alert Automation

**Category:** Linux Administration / Automation / DevOps

**Author:** Dharshika

**Email Notification Recipient:** aieraversion@gmail.com
