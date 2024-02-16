*** Settings ***
Documentation        Cenários de testes do cadastro de usuários

Resource    ../resources/base.robot
#Library        FakerLibrary

# *** Variables ***
# ${name}         Wellington Júnior
# ${email}        wpsjunior23@gmail.com
# ${password}     pwd123

Suite Setup    Log    Tudo aqui ocorre antes dos testes
Suite Teardown    Log    Tudo aqui ocorre depois dos testes

Test Setup        Start Session
Test Teardown     Take Screenshot

*** Test Cases ***
Deve poder cadastrar um novo usuário

    ${user}    Create Dictionary    
    ...    name=Wellington Júnior    
    ...    email=wpsjunior23@gmail.com    
    ...    password=pwd123

    # ${name}    Set Variable    Wellington Júnior
    # ${email}    Set Variable    wpsjunior23@gmail.com
    # ${password}    Set Variable    pwd123
    #${name}    FakerLibrary.Name
    #${email}    FakerLibrary.Email

    Remove user from database    ${user}[email]
    Go To    http://localhost:3000/signup
    Wait For Elements State    css=h1    visible    5
    Get Text    css=h1    equal    Faça seu cadastro
    Fill Text    id=name    ${user}[name]
    Fill Text    id=email    ${user}[email]
    Fill Text    id=password    ${user}[password]
    Click    id=buttonSignup
    Wait For Elements State    css=.notice p    visible    5
    Get Text    css=.notice p     equal   Boas vindas ao Mark85, o seu gerenciador de tarefas.


Não deve permitir o cadastro com email duplicado
    [Tags]    dup

        ${user}    Create Dictionary    
    ...    name=Wellington Júnior    
    ...    email=wpsjunior23@gmail.com    
    ...    password=pwd123

    # ${name}    Set Variable    Wellington Júnior duplicado
    # ${email}    Set Variable    wpsjunior23@gmail.com
    # ${password}    Set Variable    pwd123
    
    Remove user from database    ${user}[email]
    Insert user from database    ${user}
    Go To    http://localhost:3000/signup
    Wait For Elements State    css=h1    visible    5
    Get Text    css=h1    equal    Faça seu cadastro
    Fill Text    id=name    ${user}[name]
    Fill Text    id=email    ${user}[email]
    Fill Text    id=password    ${user}[password]
    Click    id=buttonSignup
    Wait For Elements State    css=.notice p    visible    5
    Get Text    css=.notice p     equal   Oops! Já existe uma conta com o e-mail informado.
    