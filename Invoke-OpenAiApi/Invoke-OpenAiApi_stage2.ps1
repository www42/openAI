function Invoke-OpenAiApi {
<#
.SYNOPSIS
    Invoke-OpenAiApi is a function that will invoke the OpenAI API and return the response.
.DESCRIPTION
    Invoke-OpenAiApi is a function that will invoke the OpenAI API and return the response.
.PARAMETER Text
    The text to be sent to the API.
.PARAMETER MaxTokens
    The maximum number of tokens to be returned.
.PARAMETER Temperature
    The temperature of the response.    
.EXAMPLE
    Invoke-OpenAiApi -Text 'This is a test.'
.EXAMPLE
    Invoke-OpenAiApi -Text 'Was ist der Sinn des Labens?' -MaxTokens 50 -Temperature .3
#>

    param(
        [Parameter(Mandatory = $true)]
        [string]$Text,

        [int]$MaxTokens = 500,

        [int]$Temperature = 0.7
    )

    $ApiKey = 'sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'

    $Headers = @{
        "Authorization" = "Bearer $ApiKey"
        "Content-Type" = "application/json"
    }
    
    $Body = ConvertTo-Json @{
        "model" = 'text-davinci-003'
        "prompt" = $Text
        "max_tokens" = $MaxTokens
        "temperature" = $Temperature
    }
    
    $Response = Invoke-WebRequest `
        -Uri "https://api.openai.com/v1/completions" `
        -Method POST `
        -Headers $Headers `
        -Body $Body

    ($Response.Content | ConvertFrom-Json -Depth 3).choices.text.trim() 

}


Invoke-OpenAiApi -Text 'This is a test.'
Invoke-OpenAiApi -Text 'Was ist der Sinn des Labens?' -MaxTokens 700

Get-Help Invoke-OpenAiApi -Full
