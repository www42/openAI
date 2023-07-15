# PowerShell Function to Call OpenAI API

This is a PowerShell function to call the OpenAI API. It is a wrapper around Invoke-RestMethod. It will handle the authentication and JSON conversion.

## Prerequisites

- PowerShell 7 or Windows PowerShell 5.1
- A code editor such as Visual Studio Code or PowerShell ISE
- An OpenAI API account (create a new account [here](https://platform.openai.com/signup?launch))
- An OpenAI API key (go to [api-keys](https://platform.openai.com/account/api-keys) to get one)

## Stage 0 - One liner with `Invoke-WebRequest`, request header , and body


```powershell
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
```



## Stage 1 - Function with a single parameter

Mind the `global:` scope of the variable `Response`.

```powershell
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
```



## Stage 2 - Add more params, make the output more concrete, add comment based help

```powershell
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
```

