$headers=@{}
$headers.Add("Accept", "application/json")
$headers.Add("Content-Type", "application/json")
$headers.Add("Authorization", "Token token=")
$response = Invoke-RestMethod -Uri 'https://api.pagerduty.com/users' -Method GET -Headers $headers  
  
# Store each user's JSON object in a variable array 
$users = $response.users  
  
# Extract the 'name' property from each user  
$userNames = $users | ForEach-Object { $_.name }

$OutputFilePath = "C:\Users\$env:UserName\Desktop\users.txt"

# New instead of Create for verb due to name checking warning during debugging.
function New-UsersContactFile {  
    [CmdletBinding()]  
    param(  
        [Parameter(Mandatory = $true)]  
        [array]$users,  
        [Parameter(Mandatory = $true)]  
        [string]$OutputFilePath  
    )  
  
    # Initialize an array to hold the processed user objects.  
    $usersContact = @()  
  
    foreach ($user in $users) {  
  
        # Check if user has at least one team and get the first team object.  
        $firstTeam = $null  
        if ($user.teams -and $user.teams.Count -gt 0) {  
            $firstTeam = $user.teams[0]  
        }  
  
        # Create a new PSObject with the required key:value pairs.  
        $entry = [PSCustomObject]@{  
            id            = $user.id  
            name          = $user.name  
            email         = $user.email  
            countryCode   = if ($user.PSObject.Properties.Match("countryCode")) { $user.countryCode } else { "" }  
            mobilePhone   = if ($user.PSObject.Properties.Match("mobilePhone")) { $user.mobilePhone } else { "" }  
            sms           = if ($user.PSObject.Properties.Match("sms")) { $user.sms } else { "" }  
            job_title     = $user.job_title  
            description   = $user.description  
            time_zone     = $user.time_zone  
            role          = $user.role  
            "team.0.name" = if ($firstTeam) { $firstTeam.summary } else { "" }  
            "teams.0.id"  = if ($firstTeam) { $firstTeam.id } else { "" }  
            "teams.0.role"= if ($firstTeam -and $firstTeam.PSObject.Properties.Match("role")) { $firstTeam.role } else { "" }  
        }  
  
        $usersContact += $entry  
    }  
  
    # Convert the usersContact array to JSON format.  
    $jsonOutput = $usersContact | ConvertTo-Json -Depth 4  
  
    # Output the JSON to the specified text file.  
    $jsonOutput | Out-File -FilePath $OutputFilePath -Encoding utf8  
  
    return $usersContact  
}  
  
# Example usage:  
# Assume $users is already populated from the API response  
$output = New-UsersContactFile -users $users -OutputFilePath $OutputFilePath
$output