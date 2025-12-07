#!/usr/bin/env python3
"""
vibecheck quick setup - Universal (Python)
Works on: Linux, macOS, Windows

Run:
  python3 -c "import urllib.request; exec(urllib.request.urlopen('https://raw.githubusercontent.com/willsigmon/vibecheck/main/extras/quick-setup.py').read())"

Or download and run:
  curl -O https://raw.githubusercontent.com/willsigmon/vibecheck/main/extras/quick-setup.py
  python3 quick-setup.py
"""

import os
import sys
import platform
import subprocess
import urllib.request
from pathlib import Path

REPO = "https://raw.githubusercontent.com/willsigmon/vibecheck/main/workflows"
WORKFLOWS = [
    "vibecheck-claude",
    "vibecheck-gemini", 
    "vibecheck-openai",
    "vibecheck-cursor",
    "vibecheck-copilot"
]

def print_color(msg, color="green"):
    colors = {"green": "\033[92m", "yellow": "\033[93m", "red": "\033[91m", "cyan": "\033[96m", "reset": "\033[0m"}
    if sys.platform == "win32":
        print(msg)  # Windows doesn't always support ANSI
    else:
        print(f"{colors.get(color, '')}{msg}{colors['reset']}")

def command_exists(cmd):
    try:
        subprocess.run([cmd, "--version"], capture_output=True, check=False)
        return True
    except FileNotFoundError:
        return False

def main():
    print_color("🎯 vibecheck quick setup (Python)", "cyan")
    print_color("=" * 40, "cyan")
    
    system = platform.system()
    print(f"Detected: {system}")
    
    # Determine n8n directory
    if system == "Windows":
        workflows_dir = Path(os.environ["USERPROFILE"]) / ".n8n" / "workflows"
    else:
        workflows_dir = Path.home() / ".n8n" / "workflows"
    
    # Check for n8n
    if not command_exists("n8n"):
        print_color("\nn8n not found. Checking alternatives...", "yellow")
        
        if command_exists("docker"):
            print("Using Docker...")
            try:
                subprocess.run(["docker", "run", "-d", "--name", "n8n", "-p", "5678:5678", 
                              "-v", "n8n_data:/home/node/.n8n", "n8nio/n8n"], 
                              capture_output=True, check=False)
            except:
                subprocess.run(["docker", "start", "n8n"], capture_output=True, check=False)
            print_color("✓ n8n container ready at http://localhost:5678", "green")
        elif command_exists("npm"):
            print("Using npm...")
            subprocess.run(["npm", "install", "-g", "n8n"], check=True)
            print_color("✓ n8n installed. Run 'n8n start' to launch.", "green")
        else:
            print_color("❌ Install Docker or Node.js first, then re-run this script.", "red")
            sys.exit(1)
    else:
        print_color("✓ n8n found", "green")
    
    # Create workflows directory
    workflows_dir.mkdir(parents=True, exist_ok=True)
    
    print("\nDownloading workflows...")
    
    for workflow in WORKFLOWS:
        url = f"{REPO}/{workflow}.json"
        dest = workflows_dir / f"{workflow}.json"
        urllib.request.urlretrieve(url, dest)
        print_color(f"  ✓ {workflow}.json", "green")
    
    # Download template
    urllib.request.urlretrieve(f"{REPO}/knowledge-base.template.json", 
                               workflows_dir / "knowledge-base.json")
    print_color("  ✓ knowledge-base.json", "green")
    
    print_color("\n" + "=" * 40, "cyan")
    print_color("✓ Setup complete!", "green")
    print(f"""
Next steps:
  1. Start n8n: docker start n8n OR n8n start
  2. Open http://localhost:5678
  3. Workflows → Import → Pick your JSON from:
     {workflows_dir}
  4. Add your API credentials
  5. Activate!

Workflows:
  • vibecheck-claude.json  (Anthropic API)
  • vibecheck-gemini.json  (Google AI - FREE)
  • vibecheck-openai.json  (OpenAI API)
  • vibecheck-cursor.json  (OpenAI API)
  • vibecheck-copilot.json (OpenAI API)
""")

if __name__ == "__main__":
    main()
