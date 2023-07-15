$ApiKey = 'sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
$Text = 'This is a test.'

$Headers = @{
    "Authorization" = "Bearer $ApiKey"
    "Content-Type" = "application/json"
}

$Body = ConvertTo-Json @{
    "model" = 'text-davinci-003'
    "prompt" = $Text
}

$Response = Invoke-WebRequest `
    -Uri "https://api.openai.com/v1/completions" `
    -Method POST `
    -Headers $Headers `
    -Body $Body

$Response
