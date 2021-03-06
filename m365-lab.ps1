# azure ad
#admin@M365x268284.onmicrosoft.com
#Qr60W8uoWX


#cd C:\Program Files\git\bin
#git config --global user.email "bschmidlin@baggenstos.ch"
#git config --global user.name "n3tbeat"

install-module microsoft.graph.users,microsoft.graph.authentication -Scope CurrentUser -force
import-module azuread

connect-azuread 

#count all user accounts

get-commmand -module azuread -noun user
get-azureaduser -all $true |Measure-Object

$all = get-azureaduser -all $true
$all | get-member
$all.count
$all.city

#list all departments

$all = get-azureaduser -all $true | Select-Object department -unique
$all.department | select-object -Unique
$all | group-object department

#user without department

$all |Group-Object department
$all | Group-Object department | select -ExpandProperty Group -First 3

$all | Where-Object {$_.department -eq $null}

$all |Where-Object{$PSItem.department -notlike ""}
$all |Where-Object{$PSItem.department -ne $null -and $_.country -like "Unit*"}

get-azureaduser -Filter "country eq 'United States'"
get-azureaduser -filter "startswith(country, 'unit')"


$alias = $all.userprincipalname -replace ("PattiF@M365x268284.OnMicrosoft.com","")

#split
$all.userprincipalname -split "@"


#generate SMTP Address

$all = get-azureaduser -all $true
$all |ForEach-Object{
        $pre = "SMTP:" + "$.DISPLAYNAME" -replace (" ",".")
        $pre + "@" +(get-azureADDomain).Name
    }


#set country = usagelocation

#invite guest account

New-AzureADMSInvitation -InvitedUserDisplayName "Beat Schmidlin (Baggenstos)" -InvitedUserEmailAddress bschmidlin@baggenstos.ch -InviteRedirectURL https://myapps.microsoft.com -SendInvitationMessage $true



#list all guest accounts
Get-AzureADUser -All $true | Where-Object {$_.UserType -eq 'Guest'}
get-azureaduser -all $true -filter "usertype eq 'Guest'"


#give GA to given UPN
$userName="bschmidlin_baggenstos.ch#EXT#@M365x268284.onmicrosoft.com"
$roleName="Global Administrator"
$role = Get-AzureADDirectoryRole | Where {$_.displayName -eq $roleName}
if ($role -eq $null) {
$roleTemplate = Get-AzureADDirectoryRoleTemplate | Where {$_.displayName -eq $roleName}
Enable-AzureADDirectoryRole -RoleTemplateId $roleTemplate.ObjectId
$role = Get-AzureADDirectoryRole | Where {$_.displayName -eq $roleName}
}
Add-AzureADDirectoryRoleMember -ObjectId $role.ObjectId -RefObjectId (Get-AzureADUser | Where {$_.UserPrincipalName -eq $userName}).ObjectID


Get-AzureADDirectoryRole


#list all GA's
$roleName="Global Administrator"
Get-AzureADDirectoryRole | Where { $_.DisplayName -eq $roleName } | Get-AzureADDirectoryRoleMember | Ft DisplayName



#objects
(get-date).ToUniversalTime()
 $d = New-Object -TypeName System.DateTime
([System.DateTime])::UtcNow

$employee = New-Object -TypeName PSCustomObject -Property @{
    Name = "SLU"
    Title = "Consultant"
}

#Azure Invite & Filter Guests
Get-Command *invit* -Module AzureAD
New-AzureADMSInvitation -InvitedUserDisplayName "SLU (Baggenstos)" -SendInvitationMessage $true -InvitedUserEmailAddress slueders@baggenstos -InviteRedirectUrl https://myapps.microsoft.com ???Verbose
Get-AzureADUser -All $True -Filter "usertype eq 'Guest'"
Get-AzureADUser -All $True | Where-Object {$_.UserType -ne 'Member???}

Get-AzureADDirectoryRole
Add-AzureADDirectoryRoleMember -ObjectId a9fa5605-f7fe-4449-ba13-2867284c521c -RefObjectId 22035296-2a44-4671-90c4-7b1a7ceba2dd
Get-AzureADDirectoryRoleMember -ObjectId a9fa5605-f7fe-4449-ba13-2867284c521c
Get-AzureADDirectoryRoleMember -ObjectId a9fa5605-f7fe-4449-ba13-2867284c521c |Where-Object{$_.displayname -notlike "mod*" -and $_.displayname -notlike "micro*" -and $_.displayname -notlike "slu*"} | ForEach-Object{Remove-AzureADDirectoryRoleMember -ObjectId  a9fa5605-f7fe-4449-ba13-2867284c521c -MemberId $_.objectid -Verbose}


