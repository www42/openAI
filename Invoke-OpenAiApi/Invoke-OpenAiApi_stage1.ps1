function Invoke-OpenAiApi {

    param(
        [Parameter(Mandatory = $true)]
        [string]$Text
    )

    $ApiKey = 'sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'

    $Headers = @{
        "Authorization" = "Bearer $ApiKey"
        "Content-Type" = "application/json"
    }
    
    $Body = ConvertTo-Json @{
        "model" = 'text-davinci-003'
        "prompt" = $Text
    }
    
    $global:Response = Invoke-WebRequest `
        -Uri "https://api.openai.com/v1/completions" `
        -Method POST `
        -Headers $Headers `
        -Body $Body

    $Response

}


Invoke-OpenAiApi -Text 'This is a test.'
Invoke-OpenAiApi -Text 'Was ist der tiefere Sinn des Labenz?'

