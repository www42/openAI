function Test-Prime($number) {
    if ($number -le 1) {
        return $false
    }
    for ($i = 2; $i -lt $number; $i++) {
        if ($number % $i -eq 0) {
            return $false
        }
    }
    return $true
}

$primeNumbers = @()
for ($num = 2; $num -le 100; $num++) {
    if (Test-Prime $num) {
        $primeNumbers += $num
    }
}

Write-Host "Prime numbers up to 100:" $primeNumbers
