# vibecheck quick setup - Windows PowerShell
# Run: irm https://raw.githubusercontent.com/willsigmon/vibecheck/main/extras/quick-setup.ps1 | iex

$ErrorActionPreference = "Stop"

Write-Host "🎯 vibecheck quick setup (Windows)" -ForegroundColor Cyan
Write-Host "===================================" -ForegroundColor Cyan

# Check for n8n
$n8nExists = Get-Command n8n -ErrorAction SilentlyContinue

if (-not $n8nExists) {
    Write-Host ""
    Write-Host "n8n not found. Attempting install..." -ForegroundColor Yellow
    
    # Try Docker first
    $dockerExists = Get-Command docker -ErrorAction SilentlyContinue
    if ($dockerExists) {
        Write-Host "Using Docker..."
        try {
            docker run -d --name n8n -p 5678:5678 -v n8n_data:/home/node/.n8n n8nio/n8n 2>$null
        } catch {
            docker start n8n 2>$null
        }
        Write-Host "✓ n8n container ready at http://localhost:5678" -ForegroundColor Green
    }
    # Try npm
    elseif (Get-Command npm -ErrorAction SilentlyContinue) {
        Write-Host "Using npm..."
        npm install -g n8n
        Write-Host "✓ n8n installed. Run 'n8n start' to launch." -ForegroundColor Green
    }
    # Try winget
    elseif (Get-Command winget -ErrorAction SilentlyContinue) {
        Write-Host "Using winget..."
        winget install -e --id OpenJS.NodeJS
        npm install -g n8n
        Write-Host "✓ n8n installed. Run 'n8n start' to launch." -ForegroundColor Green
    }
    else {
        Write-Host "❌ No package manager found. Install Docker or Node.js first." -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "✓ n8n found" -ForegroundColor Green
}

# Create workflows directory
$WorkflowsDir = "$env:USERPROFILE\.n8n\workflows"
if (-not (Test-Path $WorkflowsDir)) {
    New-Item -ItemType Directory -Path $WorkflowsDir -Force | Out-Null
}

Write-Host ""
Write-Host "Downloading workflows..."

$Repo = "https://raw.githubusercontent.com/willsigmon/vibecheck/main/workflows"
$Workflows = @("vibecheck-claude", "vibecheck-gemini", "vibecheck-openai", "vibecheck-cursor", "vibecheck-copilot")

foreach ($workflow in $Workflows) {
    Invoke-WebRequest -Uri "$Repo/$workflow.json" -OutFile "$WorkflowsDir\$workflow.json"
    Write-Host "  ✓ $workflow.json" -ForegroundColor Green
}

Invoke-WebRequest -Uri "$Repo/knowledge-base.template.json" -OutFile "$WorkflowsDir\knowledge-base.json"
Write-Host "  ✓ knowledge-base.json" -ForegroundColor Green

Write-Host ""
Write-Host "===================================" -ForegroundColor Cyan
Write-Host "✓ Setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. Start n8n: docker start n8n OR n8n start"
Write-Host "  2. Open http://localhost:5678"
Write-Host "  3. Workflows → Import → Pick your JSON from:"
Write-Host "     $WorkflowsDir" -ForegroundColor Yellow
Write-Host "  4. Add your API credentials"
Write-Host "  5. Activate!"
Write-Host ""
Write-Host "Workflows:"
Write-Host "  • vibecheck-claude.json  (Anthropic API)"
Write-Host "  • vibecheck-gemini.json  (Google AI - FREE)"
Write-Host "  • vibecheck-openai.json  (OpenAI API)"
Write-Host "  • vibecheck-cursor.json  (OpenAI API)"
Write-Host "  • vibecheck-copilot.json (OpenAI API)"
