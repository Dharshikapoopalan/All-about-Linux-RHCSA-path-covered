**1. What is a cron job?**

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

**2. Cron syntax — the most important part**

A standard user's crontab entry has five time fields followed by a command.

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

**2. Understand cron scheduling symbols**

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

**3. Practical cron examples**

These examples use the standard five-field cron format.

Requirement	                  Cron expression

Every minute	                            * * * * *
Every 5 minutes	                          */5 * * * *
Every 15 minutes	                        */15 * * * *
Every 30 minutes	                        */30 * * * *
Every hour	                              0 * * * *
Every day at 12 AM	                      0 0 * * *
Every day at 6 AM	                        0 6 * * *
Every day at 11:30 PM	                    30 23 * * *
Every Monday at 9 AM	                    0 9 * * 1
Every Friday at 5:30 PM	                  30 17 * * 5
First day of each month at midnight	      0 0 1 * *
Every three months, on the first day	    0 0 1 */3 *
Every day at 8 AM and 8 PM	              0 8,20 * * *
Monday–Friday at 8 AM	                    0 8 * * 1-5
Every Sunday at 2 AM	                    0 2 * * 0

**4. How to create a cron job**

The most common way to create a personal cron job is with 
    
    **crontab -e**

Step 1: Check your existing cron jobs
    
    **crontab -l**

- crontab manages scheduled jobs for a user.
- -l means list the jobs.

If you have no jobs configured, the system may report that there is no crontab for your user.

Step 2: Open the crontab editor
    
    **crontab -e**

This opens your user's crontab in the configured text editor.

Add this line:
        
        44 15 * * * echo "This is a cron test file" > /home/student/testfile.txt

Save and exit the editor.

This job runs at 3.44 PM every day, every week, every month.

Step 3: Verify the job
      
      **crontab -l**

You should see the new entry.

Step 4: Wait and check the output
    
    cat /home/student/testfile.txt

If it has run successfully, you'll see timestamps in the file.

Other useful crontab commands

Command	                      Purpose
crontab -e	                   Edit your user's jobs
crontab -l	                   List your user's jobs
crontab -r	                   Remove all of your user's cron jobs
crontab -u alice -l	           List Alice's jobs as an authorized administrator
crontab -u alice -e	           Edit Alice's jobs as an authorized administrator

Warning: crontab -r deletes the entire crontab for that user. Always list and back up the entries before removing them.

For a safe backup:
    **crontab -l > ~/crontab-backup.txt**
