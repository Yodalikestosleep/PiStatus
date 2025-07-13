# PiStatus

A simple Bash script that displays Raspberry Pi system status information.

+ Feature:
- CPU temperature
- NVMe temperatures 
- Memory usage 
- Disk usage
- Data Usage
- Uptime


+Requirements
- Need vcgencmd (included with Raspberry-pi os)
- Need nvme-cli 
- Need bc

You can also add it to alias in bashrc
1. go to ~/.bashrc
2. add alias pistatus='bash /path/to/pistatus.sh'
3. reload your shell or logout.
4. run with pistatus
