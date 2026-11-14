**Server Health Monitoring using Bash Script, Cron Job, and SMTP**

Project Overview

This project automates server health monitoring on a CentOS Linux virtual machine.

The solution uses:

  - Bash Scripting to collect server health information
  - Postfix SMTP to send emails
  - Gmail SMTP Relay for email delivery
  - Cron Jobs for automation

The script gathers server health details such as:

Date & Time
Hostname
Uptime
Memory Usage
Disk Usage
CPU Load

and sends the report to a configured email address automatically.

Architecture

Plain Text

Bash Script
|
v

Collect System Health Data
|
v

Postfix SMTP Client
|
v

Gmail SMTP Server
|
v

Email Notification
|
v

Recipient Inbox

Command-by-Command Explanation


date

Purpose: Displays the current system date and time.

Output Example:

Plain Text
Thu Jul 17 14:10:23 UTC 2025
Check Cron Service Status
Shell
systemctl status crond

Purpose: Verifies whether the cron daemon is running.

Cron is responsible for executing scheduled jobs automatically.

Print Current Working Directory
Shell
pwd

Purpose: Shows the current directory location.

Example:

Plain Text
/root
Create/Edit Bash Script
Shell
vim healthcheck.sh

Purpose: Creates or edits the health monitoring script.

Verify Script Creation
Shell
ls -l

Purpose: Lists files and their permissions.

Make Script Executable
Shell
chmod +x /root/healthcheck.sh

Purpose: Adds execute permissions to the script.

Before:

Plain Text
-rw-r--r--

After:

Plain Text
-rwxr-xr-x
Execute Script Manually
Shell
sudo /root/healthcheck.sh

Purpose: Runs the script manually to verify functionality.

Postfix Installation and Configuration
Install Postfix Mail Server
Shell
sudo yum install postfix -y

Purpose: Installs the Postfix SMTP server package.

Enable Postfix at Boot
Shell
sudo systemctl enable postfix

Purpose: Starts Postfix automatically whenever the server reboots.

Start Postfix Service
Shell
sudo systemctl start postfix

Purpose: Launches the Postfix mail service.

Verify Postfix Status
Shell
systemctl status postfix

Purpose: Checks whether Postfix is running successfully.

SASL Authentication Setup
Install SASL Authentication Package
Shell
sudo yum install cyrus-sasl-plain -y

Purpose: Allows Postfix to authenticate with Gmail SMTP.

Edit Script Again
Shell
vim healthcheck.sh

Purpose: Modify email functionality or add health checks.

Create SMTP Credentials File
Shell
vim /etc/postfix/sasl_passwd

Purpose: Stores Gmail authentication credentials.

Example:

Shell
[smtp.gmail.com]:587 username@gmail.com:app_password
Secure Credentials File
Shell
chmod 600 /etc/postfix/sasl_passwd

Purpose: Restricts access to the file.

Permissions:

Plain Text
rw-------
Generate Postfix Database
Shell
postmap /etc/postfix/sasl_passwd

Purpose: Creates a hashed database for Postfix authentication.

Creates:

Plain Text
/etc/postfix/sasl_passwd.db
Configure Gmail Relay
Set Gmail SMTP Host
Shell
postconf -e "relayhost = [smtp.gmail.com]:587"

Purpose: Routes outgoing mail through Gmail.

Enable TLS
Shell
postconf -e "smtp_use_tls = yes"

Purpose: Encrypts SMTP traffic.

Enforce Encryption
Shell
postconf -e "smtp_tls_security_level = encrypt"

Purpose: Requires encrypted communication.

Enable SMTP Authentication
Shell
postconf -e "smtp_sasl_auth_enable = yes"

Purpose: Allows Gmail authentication.

Disable Anonymous Authentication
Shell
postconf -e "smtp_sasl_security_options = noanonymous"

Purpose: Allows only authenticated users.

Specify CA Certificates
Shell
postconf -e "smtp_tls_CAfile = /etc/pki/tls/certs/ca-bundle.crt"

Purpose: Provides trusted SSL certificates.

Restart Postfix
Shell
systemctl restart postfix

Purpose: Applies configuration changes.

Verify Postfix Again
Shell
systemctl status postfix

Purpose: Confirms successful restart.

SMTP Testing
Send Test Email
Shell
echo "This is a test email from my CentOS VM" | mail -s "CentOS SMTP Test" aieraversion@gmail.com

Purpose: Tests email delivery through Gmail SMTP.

Execute Monitoring Script
Shell
/root/healthcheck.sh

Purpose: Runs the actual health-check script.

Check Mail Logs
Shell
tail -50 /var/log/maillog

Purpose: Shows the latest mail processing logs.

Useful for troubleshooting delivery issues.

Troubleshooting Steps
Check CentOS Version
Shell
cat /etc/centos-release

Purpose: Displays operating system version.

Check Installed Postfix Packages
Shell
rpm -qa | grep postfix

Purpose: Lists installed Postfix-related packages.

Install LMDB Support Package
Shell
sudo dnf install postfix-hash -y

Purpose: Provides database map support required by newer Postfix versions.

Display Supported Postfix Database Types
Shell
postconf -m

Purpose: Lists all map types supported by Postfix.

Example:

Plain Text
hash
lmdb
btree
Create LMDB Database
Shell
postmap lmdb:/etc/postfix/sasl_passwd

Purpose: Creates LMDB formatted credential database.

Update Postfix Authentication Mapping
Shell
postconf -e "smtp_sasl_password_maps = lmdb:/etc/postfix/sasl_passwd"

Purpose: Instructs Postfix to use LMDB authentication files.

Verify Credential Files
Shell
ls -l /etc/postfix/sasl_passwd*

Purpose: Confirms database files were generated.

Re-Edit Credentials
Shell
vim /etc/postfix/sasl_passwd

Purpose: Correct Gmail credentials if needed.

Force IPv4 Usage
Shell
sudo postconf -e "inet_protocols = ipv4"

Purpose: Avoids IPv6 connectivity issues with Gmail SMTP.

Restart and Verify
Shell
systemctl restart postfix
systemctl status postfix

Purpose: Applies configurations and validates service health.

Network Connectivity Test
Install Netcat
Shell
sudo dnf install nmap-ncat -y

Purpose: Installs network testing tools.

Test Gmail SMTP Port
Shell
nc -4 -vz smtp.gmail.com 587

Purpose: Verifies connectivity to Gmail SMTP server.

Successful Output:

Plain Text
Connection to smtp.gmail.com 587 port [tcp/submission] succeeded!
Final SMTP Verification
Shell
echo "CentOS SMTP test successful" | mail -s "SMTP Test" aieraversion@gmail.com

Purpose: Final end-to-end validation of email delivery.

Sample Cron Job

Open cron table:

Shell
crontab -e

Add:

Shell
0 * * * * /root/healthcheck.sh

Explanation:

Plain Text
0 = Minute
* = Every Hour
* = Every Day
* = Every Month
* = Every Weekday

This runs the script every hour.
