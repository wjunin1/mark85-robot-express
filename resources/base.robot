*** Settings ***

Library    libs/database.py
Library    Browser

*** Keywords ***
Start Session
    New Browser    headless=False    browser=chromium
    New Page    http://localhost:3000/