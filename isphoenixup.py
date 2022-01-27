#!/usr/bin/env python

"""Test regularly if phoenix is up."""

import os

from selenium import webdriver
from selenium.webdriver.firefox.options import Options

PHOENIX_USERNAME = os.environ["PHOENIX_USERNAME"]
PHOENIX_PASSWORD = os.environ["PHOENIX_PASSWORD"]

options = Options()
options.headless = True

driver = webdriver.Firefox(options=options)
driver.set_window_size(1120, 550)
driver.get("https://phoenix.juniorisep.com")
driver.find_element_by_id("username").send_keys(PHOENIX_USERNAME)
driver.find_element_by_id("password").send_keys(PHOENIX_PASSWORD)
driver.find_element_by_xpath(
    "//div[@class='MuiButtonBase-root MuiButton-root MuiButton-contained"
    "MuiButton-containedPrimary MuiButton-fullWidth'"
).click()
print(driver.current_url)
driver.quit()
