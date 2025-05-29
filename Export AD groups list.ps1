$date = Get-Date -Format yyyy-MM-dd

$outputLocation = "C:\Users\skane\Desktop\pwrshell-cmd\exports\exportADGroupList-$date.csv"

Get-ADGroup -Filter * -Properties CN, CanonicalName, Created, Description, GroupCategory, GroupScope, isCriticalSystemObject, Modified, objectSID | Sort-Object -Property CN | export-csv -Path $outputLocation