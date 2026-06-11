# API Key and Server URL

$apiKey = ''
$serverUrl = 'https://api.pagerduty.com/services'

# Header object and auth

$header = @{
    "Authorization" = "Token token=$apiKey"
    "Accept" = "application/vnd.pagerduty+json;version=2"
    "Content-Type" = "application/json"
}

# List of Service Names

$services = @(
    "CheckOut - App",
    "CheckOut - Network",
    "CheckOut - Database",
    "CheckOut - Infra"
)

# List of Required Escalation Policy Id's
# you will need at least one per service you are going to create

$escalationPolicyIds = @(
 
)

# Function to Create a Service
function New-Service {
    param (
        [string]$serviceName,
        [string]$description,
        [string]$escalationPolicyId
    )

    # Define the Service Body
    
    $serviceBody = @{
        "service" = @{
            "name"                  = $serviceName
            "description"           = $description
            "auto_resolve_timeout"  = 14400  # 4 hours (in seconds)
            "acknowledgement_timeout" = 600  # 10 minutes (in seconds)
            "status"                = "active"
            "escalation_policy"     = @{
                "id"   = $escalationPolicyId 
                "type" = "escalation_policy_reference"
            }
            "incident_urgency_rule" = @{
                "type" = "use_support_hours"
                "during_support_hours" = @{
                    "type"    = "constant"
                    "urgency" = "high"
                }
                "outside_support_hours" = @{
                    "type"    = "constant"
                    "urgency" = "low"
                }
            }
            "support_hours" = @{
                "type"            = "fixed_time_per_day"
                "time_zone"       = "America/New_York"
                "start_time"      = "09:00:00"
                "end_time"        = "17:00:00"
                "days_of_week"    = @(1, 2, 3, 4, 5)  # Monday to Friday
            }
            "alert_creation" = "create_alerts_and_incidents"
            "auto_pause_notifications_parameters" = @{
                "enabled" = $true
                "timeout" = 300  # 5 minutes
            }
            "scheduled_actions" = @(
                @{
                    "type"      = "urgency_change"
                    "at"        = @{
                        "type" = "named_time"
                        "name" = "support_hours_start"
                    }
                    "to_urgency" = "high"
                }
            )
        }
    }

    # Convert the body to JSON
    $bodyJson = $serviceBody | ConvertTo-Json -Depth 5

    # Make the API Request to Create the Service
    $response = Invoke-RestMethod -Uri "$serverUrl" -Method Post -Headers $header -Body $bodyJson

    # Check if the service creation was successful
    if ($response.service) {
        Write-Host "Service '$serviceName' created successfully."
    } else {
        Write-Host "Failed to create service '$serviceName'. Response: $($response | ConvertTo-Json)"
    }
}

# Iterate over the services and create each one with the corresponding escalation policy
for ($i = 0; $i -lt $services.Count; $i++) {
    $service = $services[$i]
    $description = "$service service for monitoring and testing"
    $escalationPolicyId = $escalationPolicyIds[$i]  # Match the escalation policy with the service
    
    New-Service -serviceName $service -description $description -escalationPolicyId $escalationPolicyId
}
