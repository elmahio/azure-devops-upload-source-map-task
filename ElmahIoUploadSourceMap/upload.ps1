Trace-VstsEnteringInvocation $MyInvocation

$apiKey = Get-VstsInput -Name "apiKey" -Require
$logId = Get-VstsInput -Name "logId" -Require
$path = Get-VstsInput -Name "path" -Require
$sourceMap = Get-VstsInput -Name "sourceMap" -Require
$minifiedJavaScript = Get-VstsInput -Name "minifiedJavaScript" -Require

$boundary = [System.Guid]::NewGuid().ToString()

$mapFile = [System.IO.File]::ReadAllBytes($sourceMap)
$mapContent = [System.Text.Encoding]::UTF8.GetString($mapFile)
$mapFileName = Split-Path $sourceMap -leaf
$jsFile = [System.IO.File]::ReadAllBytes($minifiedJavaScript)
$jsContent = [System.Text.Encoding]::UTF8.GetString($jsFile)
$jsFileName = Split-Path $minifiedJavaScript -leaf

Write-Host "Uploading source map and minified JavaScript as $path"

$ProgressPreference = "SilentlyContinue"

$LF = "`r`n"
$bodyLines = (
    "--$boundary",
    "Content-Disposition: form-data; name=`"Path`"$LF",
    $path,
    "--$boundary",
    "Content-Disposition: form-data; name=`"SourceMap`"; filename=`"$mapFileName`"",
    "Content-Type: application/json$LF",
    $mapContent,
    "--$boundary",
    "Content-Disposition: form-data; name=`"MinifiedJavaScript`"; filename=`"$jsFileName`"",
    "Content-Type: text/javascript$LF",
    $jsContent,
    "--$boundary--$LF"
) -join $LF

Invoke-RestMethod "https://api.elmah.io/v3/sourcemaps/${logId}?api_key=${apiKey}" -Method POST -ContentType "multipart/form-data; boundary=`"$boundary`"" -Body $bodyLines