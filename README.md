# Linux-Safe-Delete
This shell scripts provides a command able to safely delete files from your OS. Deleted files are compressed and moved into ~/TRASH directory.

The script first look for the directory, delete the items removed from the past 48 hours. It can be added to a cron job.
For deleting, it creates a zip file from the original file and moves to ~/TRASH
