#!/usr/bin/env python

from selenium import webdriver
from selenium.webdriver.firefox.options import Options

options = Options()
options.headless = True

driver = webdriver.Firefox(options=options)
# drive = webdriver.PhantomJS(executable_path=r"/usr/local/bin/phantomjs")
driver.set_window_size(1120, 550)
driver.get("https://duckduckgo.com/")
driver.find_element_by_id("search_form_input_homepage").send_keys("realpython")
driver.find_element_by_id("search_button_homepage").click()
print(driver.current_url)
driver.quit()
