*** Settings ***
Documentation        Online

Library    Browser

*** Test Cases ***
Webapp deve estar online
    
    New Browser    headless=False    browser=chromium
    New Page    http://localhost:3000/
    Get Title    equal    Mark85 by QAx
        Sleep    10
