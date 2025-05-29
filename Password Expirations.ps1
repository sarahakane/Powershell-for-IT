$date = Get-Date -Format yyyy-MM-dd

$outputLocation = "C:\Users\skane\Desktop\pwrshell-cmd\exports\pwdlastset-$date.csv"

Get-ADUser -Filter * -Properties PasswordLastSet, passwordneverexpires, passwordexpired | Sort-Object -Property PasswordLastSet, passwordneverexpires  | Select-Object Name, PasswordLastSet, passwordneverexpires, passwordexpired | export-csv -path $outputLocation
