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

<img width="703" height="286" alt="image" src="https://github.com/user-attachments/assets/2a9f3ad3-21a3-499b-be0c-ec14531ae43a" />

On Red Hat Enterprise Linux (RHEL), which is relevant to RHCSA, the service is generally named crond.

**2. Cron syntax — the most important part**

A standard user's crontab entry has five time fields followed by a command.

<img width="1350" height="536" alt="image" src="https://github.com/user-attachments/assets/ceef01e2-6031-4af1-b3f0-7d78ff626272" />

<img width="734" height="290" alt="image" src="https://github.com/user-attachments/assets/d7335405-b8b9-45eb-917c-bcac3befcc11" />

  
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

<img width="593" height="505" alt="image" src="https://github.com/user-attachments/assets/aa63c573-014a-40a8-a335-afb54741f51e" />

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

<img width="585" height="209" alt="image" src="https://github.com/user-attachments/assets/b927ca47-b16e-4ba6-b891-e1cec22e3866" />

Warning: crontab -r deletes the entire crontab for that user. Always list and back up the entries before removing them.

For a safe backup:

    **crontab -l > ~/crontab-backup.txt**
