# API Key and Server URL
$apiKey = ''
$serverUrl = 'https://api.pagerduty.com/users'

# Header object and auth
$header = @{
    "Authorization" = "Token token=$apiKey"
    "Accept"        = "application/vnd.pagerduty+json;version=2"
    "Content-Type"  = "application/json"
}
# User Names
$userNames = @(

);

# Team array
# First user's team. And use a comma to add another to this list. A user can also have multiple teams. Which would all be in one line.
$userTeams = @(
    @(@{ "type" = "team_reference"; "id" = "enter id"; }) 
);

# Roles
$userRoles = @(

);

# User job titles
$userJobTitles = @(

);

# Function to Create a User  
function CreateUsers {  
    param (  
        [string]$userName,  
        [string]$userEmail,  
        [string]$userRole,  
        [string]$userJobTitle  
    )  
  
    # Create User Body  
    $userBody = @{  
        "user" = @{  
            "type"        = "user"  # Required field  
            "name"        = $userName  
            "email"       = $userEmail  
            "time_zone"   = "America/New_York"  
            "color"       = "green"  # Example color  
            "role"        = $userRole  
            "job_title"   = $userJobTitle  
            "description" = "Created via API"  
        }  
    }  
  
    # Convert the body to JSON  
    $bodyJson = $userBody | ConvertTo-Json -Depth 5  
  
    # Make the API Request to Create the User  
    try {  
        $response = Invoke-RestMethod -Uri $serverUrl -Method Post -Headers $header -Body $bodyJson  
        Write-Host "User '$userName' created successfully. Response: $($response | ConvertTo-Json -Depth 5)"  
    } catch {  
        Write-Host "Failed to create user '$userName'. Error: $_"  
    }  
}  
  
# Loop through the user data and call the function  
for ($i = 0; $i -lt $userNames.Count; $i++) {  
    CreateUsers -userName $userNames[$i] -userEmail $userEmails[$i] -userRole $userRoles[$i] -userJobTitle $userJobTitles[$i]  
}