#!/usr/bin/env python

"""Test regularly if phoenix is up."""

import os
import argparse
import logging

from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.firefox.options import Options
from selenium.webdriver.support.ui import WebDriverWait

PHOENIX_USERNAME = os.environ["PHOENIX_USERNAME"]
PHOENIX_PASSWORD = os.environ["PHOENIX_PASSWORD"]

WIDTH, HEIGHT = 1120, 550


def is_phoenix_up(driver: webdriver.Firefox) -> bool:
    """Test if phoenix is up."""
    try:
        driver.set_window_size(WIDTH, HEIGHT)
        driver.get("https://phoenix.juniorisep.com")
        driver.find_element(By.ID, "username").send_keys(PHOENIX_USERNAME)
        driver.find_element(By.ID, "password").send_keys(PHOENIX_PASSWORD)

        driver.find_element(By.TAG_NAME, "button").click()
        wait = WebDriverWait(driver, 10)
        wait.until(
            lambda driver: driver.current_url != "https://phoenix.juniorisep.com/"
        )
        return True
    except Exception as error:
        logging.debug(error)
        return False


def fix_phoenix():
    """Restart Phoenix VM, DNSix and IPA."""


if __name__ == "__main__":
    # Build the parser
    parser = argparse.ArgumentParser(prog=__doc__)
    parser.add_argument(
        "-H",
        "--headless",
        type=bool,
        default=False,
        help="Whether the browser is show on screen or not.",
    )
    args = parser.parse_args()

    # Build the driver
    options = Options()
    if args.headless:
        options.headless = True
    driver = webdriver.Firefox(options=options)

    # Test if phoenix is up
    if not is_phoenix_up(driver):
        fix_phoenix()

    # Close the driver
    driver.quit()
