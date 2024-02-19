*** Settings ***
Documentation        Cenários de autenticação do usuário

Resource    base.resource
Resource    ../resources/pages/LoginPage.resource


Test Setup    Start Session
Test Teardown    Take Screenshot

*** Test Cases ***
Deve poder logar com um usuário pré-cadastrado

    ${user}    Create Dictionary    
    ...    name=Wellington Junior    
    ...    email=juninxrox@gmail.com    
    ...    password=123456

    # Remove user from database    ${user}[email]
    # Insert user from database    ${user}
    Submit login form    ${user}
    User should be logged in    ${user}[name]

