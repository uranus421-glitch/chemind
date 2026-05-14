<#
.SYNOPSIS
    Web article fetcher - converts web pages to Markdown via defuddle CLI

.DESCRIPTION
    Fetches a URL and converts it to Markdown using defuddle.
    Supports direct connection (default) and VPN SOCKS5 proxy mode.

.PARAMETER Url
    URL to fetch (required)

.PARAMETER OutFile
    Optional output file path. Defaults to StdOut.

.PARAMETER Proxy
    Use SOCKS5 proxy at 127.0.0.1:10808 (for VPN access to blocked sites).

.EXAMPLE
    .\fetch_article.ps1 "https://chemnews.com/article/123"

.EXAMPLE
    .\fetch_article.ps1 "https://en.wikipedia.org/wiki/Biomanufacturing" -Proxy

.EXAMPLE
    .\fetch_article.ps1 "https://scip.gov.cn/notice/456" -OutFile "result.md"

.NOTES
    Requires: defuddle CLI (npm install -g defuddle)
    Proxy: SOCKS5 127.0.0.1:10808
    Author: Claudian AI Assistant
    Created: 2026-05-11
#>

param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$Url,

    [Parameter(Mandatory=$false)]
    [string]$OutFile,

    [Parameter(Mandatory=$false)]
    [switch]$Proxy
)

$PROXY_ADDR = "socks5h://127.0.0.1:10808"

# ---- Pre-flight checks ----
$defuddle = Get-Command defuddle -ErrorAction SilentlyContinue
$curl = Get-Command curl -ErrorAction SilentlyContinue

if (-not $defuddle) {
    Write-Error "defuddle not installed. Run: npm install -g defuddle"
    exit 1
}
if ($Proxy -and -not $curl) {
    Write-Error "curl not found. Proxy mode requires curl."
    exit 1
}

# ---- Validate URL ----
if ($Url -notmatch '^https?://') {
    Write-Error "Invalid URL: $Url (must start with http:// or https://)"
    exit 1
}

# ---- Fetch ----
if ($Proxy) {
    # === Proxy mode: curl through VPN -> defuddle parse local file ===
    Write-Host "Fetching via proxy: $Url" -ForegroundColor Cyan

    $tempHtml = [System.IO.Path]::GetTempFileName() + ".html"

    try {
        $curlResult = & curl.exe --proxy $PROXY_ADDR -sL -o $tempHtml -w "%{http_code}" $Url 2>&1
        $httpCode = ($curlResult -join '').Trim()

        if ($httpCode -eq '000' -or $httpCode -eq '') {
            Write-Error "Connection failed. Check VPN is running on port 10808."
            Remove-Item $tempHtml -Force -ErrorAction SilentlyContinue
            exit 1
        }
        if ([int]$httpCode -ge 400) {
            Write-Error "HTTP error $httpCode from server."
            Remove-Item $tempHtml -Force -ErrorAction SilentlyContinue
            if ($httpCode -eq '403') {
                Write-Host "Tip: This site blocks VPN exit IP (e.g. Google Scholar). Use WebSearch summary instead." -ForegroundColor Yellow
            }
            exit 1
        }

        $result = & defuddle parse $tempHtml --md 2>&1

        if ($LASTEXITCODE -ne 0) {
            Write-Error "defuddle parse failed: $result"
            Remove-Item $tempHtml -Force -ErrorAction SilentlyContinue
            exit 1
        }

        $output = $result -join "`n"
        if ([string]::IsNullOrWhiteSpace($output)) {
            Write-Error "defuddle returned empty content."
            Remove-Item $tempHtml -Force -ErrorAction SilentlyContinue
            exit 1
        }

        if ($OutFile) {
            $output | Out-File -FilePath $OutFile -Encoding utf8
            $lineCount = $output.Split("`n").Count
            Write-Host "Saved to: $OutFile ($lineCount lines)" -ForegroundColor Green
        } else {
            Write-Output $output
        }

        Remove-Item $tempHtml -Force -ErrorAction SilentlyContinue
    }
    catch {
        Write-Error "Proxy fetch exception: $($_.Exception.Message)"
        Remove-Item $tempHtml -Force -ErrorAction SilentlyContinue
        exit 1
    }
}
else {
    # === Direct mode: defuddle fetches URL directly ===
    Write-Host "Fetching: $Url" -ForegroundColor Cyan

    try {
        $result = & defuddle parse $Url --md 2>&1

        if ($LASTEXITCODE -ne 0) {
            Write-Error "defuddle failed (exit code $LASTEXITCODE): $result"
            Write-Host ""
            Write-Host "Suggestions:" -ForegroundColor Yellow
            Write-Host "  1. Open URL in browser to verify it is accessible" -ForegroundColor Yellow
            Write-Host "  2. Try with curl: curl -sL '$Url'" -ForegroundColor Yellow
            Write-Host "  3. Use WebSearch for summary instead" -ForegroundColor Yellow
            exit 1
        }

        $output = $result -join "`n"
        if ([string]::IsNullOrWhiteSpace($output)) {
            Write-Error "defuddle returned empty content (SPA or login wall?)"
            Write-Host ""
            Write-Host "Suggestions:" -ForegroundColor Yellow
            Write-Host "  1. Use WebSearch for summary instead" -ForegroundColor Yellow
            Write-Host "  2. Check if URL requires login" -ForegroundColor Yellow
            exit 1
        }

        if ($OutFile) {
            $output | Out-File -FilePath $OutFile -Encoding utf8
            $lineCount = $output.Split("`n").Count
            Write-Host "Saved to: $OutFile ($lineCount lines)" -ForegroundColor Green
        } else {
            Write-Output $output
        }
    }
    catch {
        Write-Error "Fetch exception: $($_.Exception.Message)"
        Write-Host ""
        Write-Host "Suggestions:" -ForegroundColor Yellow
        Write-Host "  1. Verify defuddle is installed: defuddle --version" -ForegroundColor Yellow
        Write-Host "  2. Manually open URL in browser and copy key content" -ForegroundColor Yellow
        Write-Host "  3. Use WebSearch for summary instead" -ForegroundColor Yellow
        exit 1
    }
}
