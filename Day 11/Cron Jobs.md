1. What is a cron job?

A cron job is a command or script that Linux runs automatically at a scheduled time or on a recurring interval.

For example, imagine you are managing a production server. You want to:
  - Back up important files every day at midnight.
  - Check disk usage every 30 minutes.
  - Delete old temporary files every Sunday.
  - Generate a system health report every morning.
  - Run a script that checks whether an application is responding.
You don't want to log in and run these commands manually every time. You schedule them using cron.

1. Schedule
  - You define when a command should run.

2. Cron daemon (crond)
  - The background service checks scheduled tasks.

3. Execute
  - At the scheduled time, cron starts the configured command or script.

Important terminology

Term	            Meaning
cron	           The time-based job scheduling system
crontab	         A file or command used to configure cron schedules
crond	           The background cron daemon on many Linux distributions
Cron job	       The scheduled command or script
Daemon	         A background process that provides a service

On Red Hat Enterprise Linux (RHEL), which is relevant to RHCSA, the service is generally named crond.

<img width="1350" height="536" alt="image" src="https://github.com/user-attachments/assets/ceef01e2-6031-4af1-b3f0-7d78ff626272" />

Field	          Allowed values	      Example
Minute	          0–59	                30
Hour	            0–23	                 8
Day of month	    1–31	                15
Month	            1–12	                 6
Day of week	      0–7	                 1 for Monday on common Linux cron implementations

- The asterisk * means every permitted value for that field.
  
- Runs the date every minute.
  * * * * * date

- Runs at the beginning of every hour.
  0 * * * * date

- Runs every day at midnight.
  0 0 * * * date

Remember: Standard cron uses 24-hour time. 18 means 6 PM, not 18 minutes.

3. Understand cron scheduling symbols

There are five especially important scheduling symbols and operators.

* Asterisk — every value
      * * * * * command
      Runs every minute.

, Comma — specific values
      0 9,12,18 * * * command
      Runs at 9 AM, 12 PM, and 6 PM every day.

- Hyphen — a range
      0 9-17 * * * command
      Runs at the beginning of every hour from 9 AM through 5 PM.

*/ Step — every specified interval
      */15 * * * * command
      Runs every 15 minutes: at minutes 0, 15, 30, and 45.

/ Step within a range
      0 8-18/2 * * * command
      Runs every two hours from 8 AM through 6 PM, including both endpoints.
