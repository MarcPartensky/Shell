#!/usr/bin/env python

"""Test regularly if phoenix is up."""

import os
import argparse

from selenium import webdriver
from selenium.webdriver.firefox.options import Options

PHOENIX_USERNAME = os.environ["PHOENIX_USERNAME"]
PHOENIX_PASSWORD = os.environ["PHOENIX_PASSWORD"]

parser = argparse.ArgumentParser(prog=__doc__)
parser.add_argument(
    "-H",
    "--headless",
    type=bool,
    default=False,
    help="Whether the browser is show on screen or not.",
)
args = parser.parse_args()

options = Options()
if args.headless:
    options.headless = True

driver = webdriver.Firefox(options=options)
driver.set_window_size(1120, 550)
driver.get("https://phoenix.juniorisep.com")
driver.find_element_by_id("username").send_keys(PHOENIX_USERNAME)
driver.find_element_by_id("password").send_keys(PHOENIX_PASSWORD)
driver.find_element_by_xpath(
    "//div["
    "contains(@class, MuiButtonBase-root) and"
    "contains(@class, MuiButtone-root) and"
    "contains(@class, MuiButton-contained) and"
    "contains(@class, MuiButton-containedPrimary) and"
    "contains(@class, MuiButton-fullWidth)"
    "]"
).click()
print(driver.current_url)
driver.quit()
