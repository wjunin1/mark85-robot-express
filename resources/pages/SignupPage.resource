*** Settings ***
Documentation        Elementos e ações da página de cadastro

Library        Browser
Resource    ../env.resource


*** Keywords ***

Go to signup page
    ${element}    Set Variable    css=h1

    Go To    ${BASE_URL}/signup
    Wait For Elements State    ${element}    visible    5
    Get Text    ${element}    equal    Faça seu cadastro

Submit signup form
    [Arguments]        ${user}

    Fill Text    id=name    ${user}[name]
    Fill Text    id=email    ${user}[email]
    Fill Text    id=password    ${user}[password]
    Click    id=buttonSignup

Notice should be
    [Arguments]        ${expected_text}
    ${notice_element}    Set Variable    css=.notice p

    Wait For Elements State    ${notice_element}    visible    5
    Get Text    ${notice_element}    equal   ${expected_text}

Alert should be
    [Arguments]    ${alert_text}
    
    Wait For Elements State    css=.alert-error >> text=${alert_text}    visible    5

