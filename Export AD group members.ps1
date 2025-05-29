$date = Get-Date -Format yyyy-MM-dd

$outputLocation = "C:\Users\skane\Desktop\pwrshell-cmd\exports\exportUsersPerADGroup-$date.csv"

$groupList = Get-ADGroup -Filter * | Sort-Object Name | Select-Object Name

foreach ($group in $groupList) {
	$memberList = Get-ADGroupMember -Identity $group.Name | Select-Object SamAccountName

	#output
	$output = "$($group.Name), "
	foreach ($member in $memberList) {
		$output += "$($member.SamAccountName), "
	}
	Add-Content -Path $outputLocation -Value $output
}