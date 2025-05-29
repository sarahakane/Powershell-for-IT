#
# This should be checking all children of the rootFolder for any instances of ad hoc permissions (inherited eq false), and reports which folder, who the person is, type of access
#

$date = Get-Date -Format yyyy-MM-dd

$outputLocation = "C:\Users\skane\Desktop\pwrshell-cmd\exports\GetFolderACLs-$date.csv"


Import-Module ActiveDirectory

# Get all groups
$groups = "NT AUTHORITY\SYSTEM", "BUILTIN\Administrators"

# Specify the root folder
$rootFolder = "\\server02\Shared\DocControlAndCompliance\CDC\*"

# This script block will get executed for each subfolder
$scriptBlock = {
    param($folder)
    Get-Acl -Path $folder.FullName | ForEach-Object {
        $_.Access | ForEach-Object {
            # Check if the IdentityReference is a user
            if ($_.IsInherited -like "False" -and $_.IdentityReference -notin $groups) {
        	[PSCustomObject]@{
                	Folder = $folder.FullName
                	IdentityReference = $_.IdentityReference
                	AccessControlType = $_.AccessControlType
                	FileSystemRights = $_.FileSystemRights
			IsInherited = $_.IsInherited
		}
            }
        }
    }
}

# Get all subfolders
$folders = Get-ChildItem -Path $rootFolder 

# Execute the script block for each subfolder and export the results to a CSV file
$folders | ForEach-Object { & $scriptBlock $_ } | Export-Csv -Path $outputLocation -NoTypeInformation
