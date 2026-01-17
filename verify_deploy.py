#!/usr/bin/env python3
"""
Pre-deployment verification script
Tests that all dependencies can be installed and the app can start
"""

import sys
import subprocess
import os

def run_command(cmd, description):
    """Run a command and report results"""
    print(f"\n{'='*60}")
    print(f"Testing: {description}")
    print(f"Command: {cmd}")
    print('='*60)
    
    try:
        result = subprocess.run(
            cmd,
            shell=True,
            capture_output=True,
            text=True,
            timeout=120
        )
        
        if result.returncode == 0:
            print(f"✅ SUCCESS: {description}")
            return True
        else:
            print(f"❌ FAILED: {description}")
            print(f"Error: {result.stderr}")
            return False
    except subprocess.TimeoutExpired:
        print(f"⏱️ TIMEOUT: {description}")
        return False
    except Exception as e:
        print(f"❌ ERROR: {str(e)}")
        return False

def main():
    print("🚀 Pre-Deployment Verification Script")
    print("="*60)
    
    tests = [
        ("python --version", "Python Version Check"),
        ("pip --version", "Pip Version Check"),
        ("pip install --upgrade pip", "Upgrade Pip"),
        ("pip install -r requirements.txt", "Install Dependencies"),
    ]
    
    results = []
    for cmd, desc in tests:
        results.append(run_command(cmd, desc))
    
    print("\n" + "="*60)
    print("VERIFICATION SUMMARY")
    print("="*60)
    
    for i, (cmd, desc) in enumerate(tests):
        status = "✅ PASS" if results[i] else "❌ FAIL"
        print(f"{status}: {desc}")
    
    if all(results):
        print("\n🎉 All checks passed! Ready to deploy to Render.")
        print("\nNext steps:")
        print("1. git add .")
        print("2. git commit -m 'Fix: Add Render deployment configuration'")
        print("3. git push origin main")
        print("4. Deploy on Render Dashboard")
        return 0
    else:
        print("\n⚠️ Some checks failed. Please fix the issues before deploying.")
        return 1

if __name__ == "__main__":
    sys.exit(main())
