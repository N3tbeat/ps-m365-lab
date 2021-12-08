# azure ad
#admin@M365x268284.onmicrosoft.com
#Qr60W8uoWX

#git config --global user.email "bschmidlin@baggenstos.ch"
#git config --global user.name "n3tbeat"

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
$all |Where-Object{$PSItem.department -ne $null -and $_.country -like "Unit**"}

get-azureaduser -Filter "country eq 'United States'"

