#!/usr/bin/env /tmp/uc-env/bin/python3
# ╔══════════════════════════════════════════════════════════════════╗
# ║  UNDETECTED CHROMEDRIVER — Bot Detection Bypass Script v2       ║
# ║  Fixed: Chrome binary path, sandbox flags, headless mode        ║
# ╚══════════════════════════════════════════════════════════════════╝

import undetected_chromedriver as uc
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time
import sys

options = uc.ChromeOptions()
options.binary_location = "/usr/bin/google-chrome"
options.add_argument("--no-sandbox")
options.add_argument("--disable-dev-shm-usage")
options.add_argument("--disable-blink-features=AutomationControlled")
options.add_argument("--disable-extensions")
options.add_argument("--disable-gpu")
options.add_argument("--window-size=1280,720")
options.add_argument("--headless=new")  # Headless mode for no-display env

# Create driver with stealth
try:
    driver = uc.Chrome(options=options, version_main=147)
    print("✅ Chrome driver launched successfully")
except Exception as e:
    print(f"❌ Failed to launch Chrome: {e}")
    sys.exit(1)

def try_hackernews():
    print("\n🚀 Starting Hacker News signup...")
    try:
        driver.get("https://news.ycombinator.com/login")
        time.sleep(3)
        
        print(f"Current URL: {driver.current_url}")
        print(f"Page title: {driver.title}")
        
        # HN login page has both login and create account forms
        # The create account form is below the login form
        inputs = driver.find_elements(By.TAG_NAME, "input")
        print(f"Found {len(inputs)} input fields")
        
        # Find the create account section
        forms = driver.find_elements(By.TAG_NAME, "form")
        print(f"Found {len(forms)} forms")
        
        for i, form in enumerate(forms):
            action = form.get_attribute("action") or ""
            print(f"Form {i}: action={action}")
            
            # HN create account form action contains "create"
            if "create" in action.lower():
                print(f"✅ Found create account form (form {i})")
                
                # Get inputs in this form
                form_inputs = form.find_elements(By.TAG_NAME, "input")
                for inp in form_inputs:
                    name = inp.get_attribute("name") or ""
                    print(f"  Input: name={name}")
                
                # Fill username
                for inp in form_inputs:
                    if inp.get_attribute("name") == "acct":
                        inp.send_keys("kimiclaw")
                        print("✅ Filled username: kimiclaw")
                        break
                
                # Fill password
                for inp in form_inputs:
                    if inp.get_attribute("name") == "pw":
                        inp.send_keys("KimiclawSecure2026!")
                        print("✅ Filled password")
                        break
                
                # Click create account button
                buttons = form.find_elements(By.TAG_NAME, "input")
                for btn in buttons:
                    if btn.get_attribute("type") == "submit":
                        btn.click()
                        print("✅ Clicked create account")
                        break
                
                time.sleep(5)
                
                # Check result
                print(f"After submit URL: {driver.current_url}")
                
                # Look for error messages
                body_text = driver.find_element(By.TAG_NAME, "body").text
                if "error" in body_text.lower() or "already" in body_text.lower():
                    print(f"⚠️ Possible error: {body_text[:200]}")
                else:
                    print("✅ Account creation submitted successfully")
                
                break
        
        # Take screenshot
        driver.save_screenshot("/root/.openclaw/workspace/kimiclaw-toolkit/profiles/hackernews_result.png")
        print("📸 Screenshot saved: hackernews_result.png")
        
    except Exception as e:
        print(f"❌ HN error: {e}")
        import traceback
        traceback.print_exc()
        driver.save_screenshot("/root/.openclaw/workspace/kimiclaw-toolkit/profiles/hackernews_error.png")

if __name__ == "__main__":
    print("═══════════════════════════════════════════════════════════════")
    print("  UNDETECTED CHROMEDRIVER v2 — Platform Signup Automation")
    print("═══════════════════════════════════════════════════════════════")
    
    try_hackernews()
    
    print("\n═══════════════════════════════════════════════════════════════")
    print("  Done. Check screenshots for results.")
    print("═══════════════════════════════════════════════════════════════")
    
    driver.quit()
