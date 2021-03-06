
function New-RandomUser {
    <#
        .SYNOPSIS
            Generate random user data 
            from Https://randomuser.me/.
        .DESCRIPTION
            This function uses the free API for generating random user data from https://randomuser.me/
        .EXAMPLE
            Get-RandomUser 10
        .EXAMPLE
            Get-RandomUser -Amount 25 -Nationality us,gb 
        .LINK
            https://randomuser.me/
    #>
    [CmdletBinding()]
    param (
        [Parameter(Position = 0)]
        [ValidateRange(1,500)]
        [int] $Amount,

        [Parameter()]
        [ValidateSet('Male','Female')]
        [string] $Gender,

        # Supported nationalities: AU, BR, CA, CH, DE, DK, ES, FI, FR, GB, IE, IR, NL, NZ, TR, US
        [Parameter()]
        [string[]] $Nationality,

        [Parameter()]
        [ValidateSet('json','csv','xml')]
        [string] $Format = 'json',

        # Fields to include in the results.
        # Supported values: gender, name, location, email, login, registered, dob, phone, cell, id, picture, nat
        [Parameter()]
        [string[]] $IncludeFields,

        # Fields to exclude from the the results.
        # Supported values: gender, name, location, email, login, registered, dob, phone, cell, id, picture, nat
        [Parameter()]
        [string[]] $ExcludeFields
    )

    $rootUrl = "http://api.randomuser.me/?format=$($Format)"

    if ($Amount) {
        $rootUrl += "&results=$($Amount)"
    }

    if ($Gender) {
        $rootUrl += "&gender=$($Gender)"
    }

    if ($Nationality) {
        $rootUrl += "&nat=$($Nationality -join ',')"
    }

    if ($IncludeFields) {
        $rootUrl += "&inc=$($IncludeFields -join ',')"
    }

    if ($ExcludeFields) {
        $rootUrl += "&exc=$($ExcludeFields -join ',')"
    }
    Invoke-RestMethod -Uri $rootUrl
}

$usr = New-RandomUser -Amount 10 -Nationality ch,de -Format csv 





$user = ConvertFrom-csv -Delimiter "," -InputObject $usr
foreach ($newuser in $user){
    $displayname = ($newuser.'name.first'+" "+$newuser.'name.last') 
    $upn = $newuser.email -replace "example.com", "M365x268284.OnMicrosoft.com"
    $alias = $newuser.'login.username'
    $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
    $PasswordProfile.Password = "Welcome2021**"
    New-AzureADUser -DisplayName $displayname -PasswordProfile $PasswordProfile -UserPrincipalName $upn -MailNickName $alias -AccountEnabled $true 
}
