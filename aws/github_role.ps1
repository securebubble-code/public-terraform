$env:AWS_PROFILE="securebubble"
$roleARN = "arn:aws:iam::152857365275:role/Secure-Bubble-Sandbox-Organization-Account-Access-Role"
$result = (aws sts assume-role --role-arn $roleARN --role-session-name AWSCLI-Session | ConvertFrom-Json)
Write-Host "AWS_ACCESS_KEY_ID:     $($result.Credentials.AccessKeyId)"
Write-Host "AWS_SECRET_ACCESS_KEY: $($result.Credentials.SecretAccessKey)"
Write-Host "AWS_SESSION_TOKEN:     $($result.Credentials.SessionToken)"