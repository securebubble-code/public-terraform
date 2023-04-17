$env:AWS_PROFILE="securebubble"
$roleARN = "arn:aws:iam::152857365275:role/Secure-Bubble-Sandbox-Organization-Account-Access-Role"
$result = (aws sts assume-role --role-arn $roleARN --role-session-name AWSCLI-Session | ConvertFrom-Json)
$env:AWS_ACCESS_KEY_ID = $result.Credentials.AccessKeyId
$env:AWS_SECRET_ACCESS_KEY = $result.Credentials.SecretAccessKey
$env:AWS_SESSION_TOKEN = $result.Credentials.SessionToken