from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
import time
from datetime import datetime

def log(message):
    now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    with open("log.txt", "a") as f:
        f.write(f"[{now}] {message}\n")
    print(message)

# Setup headless Chrome
options = Options()
options.add_argument("--headless")
options.add_argument("--no-sandbox")
options.add_argument("--disable-dev-shm-usage")

driver = webdriver.Chrome(options=options)

try:
    url = "https://pay-va.nvsgames.com/topup/262304/ph-en?tab=purchase&role_id=Leo%2317383"
    driver.get(url)

    time.sleep(10)  # Wait for page to load

    # Find and click the "FREE Draw" button
    draw_button = driver.find_element(By.CLASS_NAME, "index__drawButton--ZO0Zn")
    draw_button.click()

    log("Clicked FREE Draw button!")

finally:
    driver.quit()