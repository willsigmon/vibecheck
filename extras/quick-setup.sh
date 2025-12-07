#!/usr/bin/env bash
# vibecheck quick setup - Linux/macOS
# Run: curl -fsSL https://raw.githubusercontent.com/willsigmon/vibecheck/main/extras/quick-setup.sh | bash

set -e

echo "🎯 vibecheck quick setup (Unix)"
echo "================================"

# Detect OS
OS="$(uname -s)"
case "$OS" in
    Linux*)  PLATFORM="linux";;
    Darwin*) PLATFORM="macos";;
    *)       PLATFORM="unknown";;
esac
echo "Detected: $PLATFORM"

# Check for n8n
if ! command -v n8n &> /dev/null; then
    echo ""
    echo "n8n not found. Attempting install..."
    
    if command -v docker &> /dev/null; then
        echo "Using Docker..."
        docker run -d --name n8n -p 5678:5678 -v n8n_data:/home/node/.n8n n8nio/n8n 2>/dev/null || \
            docker start n8n 2>/dev/null || true
        echo "✓ n8n container ready at http://localhost:5678"
    elif [ "$PLATFORM" = "macos" ] && command -v brew &> /dev/null; then
        echo "Using Homebrew..."
        brew install n8n
        echo "✓ n8n installed. Run 'n8n start' to launch."
    elif command -v npm &> /dev/null; then
        echo "Using npm..."
        npm install -g n8n
        echo "✓ n8n installed. Run 'n8n start' to launch."
    else
        echo "❌ No package manager found. Install Docker, Homebrew, or npm first."
        exit 1
    fi
else
    echo "✓ n8n found"
fi

# Create workflows directory (works on both Linux and macOS)
WORKFLOWS_DIR="$HOME/.n8n/workflows"
mkdir -p "$WORKFLOWS_DIR"

# Download workflows
echo ""
echo "Downloading workflows..."

REPO="https://raw.githubusercontent.com/willsigmon/vibecheck/main/workflows"

# Use curl (available on both platforms)
for workflow in vibecheck-claude vibecheck-gemini vibecheck-openai vibecheck-cursor vibecheck-copilot; do
    curl -fsSL "$REPO/${workflow}.json" -o "$WORKFLOWS_DIR/${workflow}.json"
    echo "  ✓ ${workflow}.json"
done

curl -fsSL "$REPO/knowledge-base.template.json" -o "$WORKFLOWS_DIR/knowledge-base.json"
echo "  ✓ knowledge-base.json"

echo ""
echo "================================"
echo "✓ Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Start n8n: docker start n8n OR n8n start"
echo "  2. Open http://localhost:5678"
echo "  3. Workflows → Import → Pick your JSON from:"
echo "     $WORKFLOWS_DIR"
echo "  4. Add your API credentials"
echo "  5. Activate!"
echo ""
echo "Workflows:"
echo "  • vibecheck-claude.json  (Anthropic API)"
echo "  • vibecheck-gemini.json  (Google AI - FREE)"
echo "  • vibecheck-openai.json  (OpenAI API)"
echo "  • vibecheck-cursor.json  (OpenAI API)"
echo "  • vibecheck-copilot.json (OpenAI API)"
