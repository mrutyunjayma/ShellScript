# ShellScript Repository

This repository contains shell scripts to monitor **system health** and automate system checks on Linux.

---

## 📂 Folder Contents

- `system_health_check.sh` – Main script to check CPU, memory, disk usage, and more.
- `.gitignore` – Ignores log files (`*.log`) so they are not pushed to GitHub.
- `README.md` – Project documentation.

---

## 🖥️ Usage

### 1. Make the script executable
```bash
chmod +x system_health_check.sh
```
2. Run the script manually
bash
Copy code
```
./system_health_check.sh

```
By default, the script attempts to save logs to /var/log/, which requires root.

To avoid permission issues, modify the script to save logs to your home directory:

bash
Copy code

````
LOGFILE="$HOME/system_health_$(date +%F).log"

````
⏰ Scheduling with Cron
You can schedule this script to run automatically at specific times using cron jobs.

1. Edit your crontab
bash
Copy code
```
crontab -e
```
If asked to select an editor, choose nano (option 1) for simplicity.

3. Example: Run daily at 8:30 PM
cron
Copy code
```
30 20 * * * /home/mj/ShellScript/system_health_check.sh >> /home/mj/system_health_$(date +\%F).log 2>&1

```
5. Example: Run every Thursday at 8:30 PM
cron
Copy code
```
30 20 * * 4 /home/mj/ShellScript/system_health_check.sh >> /home/mj/system_health_$(date +\%F).log 2>&1
```
Cron Format
scss
Copy code

```

  *     *     *     *     *  command
  │     │     │     │     └─ Day of week (0-6) (0=Sunday)
  │     │     │     └─────── Month (1-12)
  │     │     └──────────── Day of month (1-31)
  │     └───────────────── Hour (0-23)
  └─────────────────────── Minute (0-59)


```


4. Stop a cron job
Open crontab:

bash
Copy code
```
crontab -e
```
Delete or comment the line with # and save.
