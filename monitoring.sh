#!/bin/bash

echo " Système:"
echo "Architecture: $(uname -m)"
echo "Noyau: $(uname -r)"
echo "Processeur physiques: $(nproc --all)"
echo "processeur virtuels: $(nproc)"



echo "Mémoire vive dispo et taux d'utilisation"
free -m | awk '/Mem:/ {printf "Mémoire dispo: %s / %s (%.2f%% utilisée)\n", $7, $2, ($3/$2)*100}'


echo "Mémoire dispo et taux d'utilisation:"
df -h --total | grep 'total' | awk '{printf "Espace disque disponible: %s / %s (%.2f%% utilisée)\n", $4, $2, 100*$3/$2}'


echo  "Utilisation du CPU:"
mpstat | grep 'all' | awk '{printf "%.2f%%\n", 100 - $12}'


echo " Date et heure du dernier redémarrage "
who -b



 if [[ -x /sbin/lvs ]]; then
echo "LVM ACTIF"
else
echo "LVM INACTIF"
fi



echo "Nombre de connexions actives:"
ss -tun | grep 'ESTAB' | wc -l


 
echo "Nombre d'utilisateurs actuellement connectés:"
who | wc -l


 
echo "Adresse IPv4 et MAC:"
ip a show | awk '/inet / {print "IPv4: " $2}' | grep -v '127.0.0.1'
ip link show | awk '/ether/ {print "MAC: " $2}'


 

echo "Nombre de commandes exécutées avec sudo:"
grep -a 'COMMAND' /var/log/auth.log | wc -l


echo "Fin des informations système."
