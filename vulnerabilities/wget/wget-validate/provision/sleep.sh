# wait 5 seeconds, giving time for camflow to finish capturing data
sleep 5
# disable camflow to disregard uneccessary provenance data
sudo camflow -e false
# give camflow some time to write to audit.log
sleep 30