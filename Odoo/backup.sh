# Database name
db_name=instancia12_20_10_2019

# Backup storage directory 
backupfolder=/backups_odoo/instancia
filestorefolder=/odoo/.local/share/Odoo/filestore
# remotefolder
remote_backupfolder=backups:backups_instancia
# Notification email address 
recipient_email=luis.homobono@ciencias.unam.mx

# Number of days to store the backup 
keep_day=7

sqlfile=$backupfolder/$db_name-$(date +%d-%m-%Y_%H-%M-%S).sql
zipfile=$backupfolder/$db_name-$(date +%d-%m-%Y_%H-%M-%S).zip

#create backup folder
mkdir -p $backupfolder
#Remove old files
echo "Removing backups older than $keep_day......"
find $backupfolder -type f -mtime +$keep_day -name '*.zip' -execdir rm -- '{}' \;
echo "End Removing"
# Create a backup 
#sudo -u postgres -H sh -c "pg_dump $db_name"
if sudo -u postgres -H sh -c "pg_dump $db_name" > $sqlfile; then
    echo 'Sql dump created'
    #create filestore folder
    if cp -rp $filestorefolder/$db_name $backupfolder; then
        echo 'Filestore copied'
    else
        echo 'No se pudo copiar el filestore' | mailx -s 'Cant copy filestore!' $recipient_email
    fi

else
   echo 'Error dumping backup' | mailx -s 'Backup was not created!' $recipient_email
   exit
fi
# Compress backup 
if zip -r $zipfile $sqlfile $backupfolder/$db_name; then
   echo 'The backup was successfully compressed'| mailx -s 'Backup created!' $recipient_email
   if rclone copy $zipfile $remote_backupfolder; then
       echo "The backup of $db_name was successfully copied to drive"| mailx -s 'Backup on cloud!' $recipient_email
   else
       echo 'Error copying backup' | mailx -s 'Backup is not on cloud!' $recipient_email
   fi
else
   echo 'Error compressing backup' | mailx -s 'Backup was not created!' $recipient_email
   exit
fi

rm $sqlfile
rm -rf $backupfolder/$db_name