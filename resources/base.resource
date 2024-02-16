*** Settings ***

Library    libs/database.py
Library    Browser

Resource    env.resource
Resource    pages/SignupPage.resource

*** Keywords ***
Start Session
    New Browser    headless=False    browser=chromium
    New Page    ${BASE_URL}

short password
    [Arguments]        ${short_pass}
        ${user}    Create Dictionary    
    ...    name=Wellington Júnior
    ...    email=wpsjunior23@gmail.com
    ...    password=${short_pass}
    
    Go to signup page
    Submit signup form    ${user}
    Alert should be    Informe uma senha com pelo menos 6 digitos