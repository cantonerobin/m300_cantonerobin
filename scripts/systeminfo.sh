#!/bin/bash

# Standardausgabe auf Datei umleiten
date_hms=$(date +"%Y-%m-%d_%H-%M-%S")
output_file="${date_hms}systeminfo.txt"
# Funktion zum Schreiben einer Zeile in die Textdatei
write_to_file() {
    echo "$1" >> "$output_file"
}

# Funktion zum Anzeigen einer Zeile auf dem Terminal
display_output() {
    echo "$1"
}

# Überprüfe die Befehlszeilenoptionen
while getopts "f" option; do
    case "$option" in
        f) output_file=""
           ;;
        *) echo "Ungültige Option: -$OPTARG" >&2
           exit 1
           ;;
    esac
done

# Hostname des Systems
hostname=$(hostname)
if [ -z "$output_file" ]; then
    display_output "Hostname: $hostname"
else
    write_to_file "Hostname: $hostname"
fi

# Betriebssystemversion
os_version=$(cat /etc/os-release | grep "PRETTY_NAME" | cut -d "=" -f 2)
if [ -z "$output_file" ]; then
    display_output "Betriebssystemversion: $os_version"
else
    write_to_file "Betriebssystemversion: $os_version"
fi

# Modellname der CPU
cpu_model=$(lscpu | grep "Model name" | cut -d ":" -f 2 | sed 's/^[[:space:]]*//')
if [ -z "$output_file" ]; then
    display_output "CPU-Modell: $cpu_model"
else
    write_to_file "CPU-Modell: $cpu_model"
fi

# Anzahl der CPU-Cores
cpu_cores=$(lscpu --parse=core | grep -v '#' | sort -u | wc -l)
if [ -z "$output_file" ]; then
    display_output "Anzahl CPU-Cores: $cpu_cores"
else
    write_to_file "Anzahl CPU-Cores: $cpu_cores"
fi

# Gesamter und genutzter Arbeitsspeicher
memory_total=$(free -h | grep "Mem:" | awk '{print $2}')
memory_used=$(free -h | grep "Mem:" | awk '{print $3}')
if [ -z "$output_file" ]; then
    display_output "Gesamter Arbeitsspeicher: $memory_total"
    display_output "Genutzter Arbeitsspeicher: $memory_used"
else
    write_to_file "Gesamter Arbeitsspeicher: $memory_total"
    write_to_file "Genutzter Arbeitsspeicher: $memory_used"
fi


# Gesamtgröße des Dateisystems
filesystem_size=$(df -h --output=size / | awk 'NR==2')
if [ -z "$output_file" ]; then
    display_output "Gesamtgröße des Dateisystems: $filesystem_size"

else
    write_to_file "Gesamtgröße des Dateisystems: $filesystem_size"
fi

# Belegter Speicher auf dem Dateisystem
used_space=$(df -h --output=used / | awk 'NR==2')
if [ -z "$output_file" ]; then
    display_output "Belegter Speicher auf dem Dateisystem: $used_space"

else
    write_to_file "Belegter Speicher auf dem Dateisystem: $used_space"
fi


# Freier Speicher auf dem Dateisystem
free_space=$(df -h --output=avail / | awk 'NR==2')
if [ -z "$output_file" ]; then
    display_output "Freier Speicher auf dem Dateisystem: $free_space"

else
    write_to_file "Freier Speicher auf dem Dateisystem: $free_space"
fi


# Aktuelle Systemlaufzeit
uptime=$(uptime -p)
if [ -z "$output_file" ]; then
    display_output "Aktuelle Systemlaufzeit: $uptime"

else
    write_to_file "Aktuelle Systemlaufzeit: $uptime"
fi


# Aktuelle Systemzeit
current_time=$(date +"%T")
if [ -z "$output_file" ]; then
    display_output "Aktuelle Systemzeit: $current_time"

else
    write_to_file "Aktuelle Systemzeit: $current_time"
fi

# Send Mail 
mail_recipient="juliatifner@gmail.com"
mail_subject="Warnung der Systeminformationen"

if [[ "$free_space" =~ ^([0-9]+)G$ ]]; then
   echo "Mail will be sent"
   mail_message=$(cat << EOF
   Guten Tag

   Die Systemdaten von $hostname sind nicht gut. Hier sind die Daten:


   Hostname: $hostname
   Betriebssystemversion: $os_version
   CPU-Modell: $cpu_model
   Anzahl CPU-Cores: $cpu_cores
   Gesamter Arbeitsspeicher: $memory_total
   Gesamtgröße des Dateisystems: $filesystem_size
   Belegter Speicher auf dem Dateisystem: $used_space
   Freier Speicher auf dem Dateisystem: $free_space
   Aktuelle Systemlaufzeit: $uptime
   Aktuelle Systemzeit: $current_time


   Bei Fragen kontaktiere bitte julia.tifner@edu.tbz.ch

   Gruss Julia Tifner
EOF
)
   mutt -s $mail_subject -- $mail_recipient <<< $mail_message
else
   echo "No mail was sent"
fi
