*** Settings ***
Documentation        Cenários de testes do cadastro de usuários

Resource    ../resources/base.resource
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

    #${name}    Set Variable    Wellington Júnior
    #${email}    Set Variable    wpsjunior23@gmail.com
    #${password}    Set Variable    pwd123
    #${name}    FakerLibrary.Name
    #${email}    FakerLibrary.Email

    Remove user from database    ${user}[email]
    Go to signup page
    Submit signup form    ${user}
    Notice should be    Boas vindas ao Mark85, o seu gerenciador de tarefas.


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
    Go to signup page
    Submit signup form    ${user}
    Notice should be    Oops! Já existe uma conta com o e-mail informado.

Campos obrigatórios

        ${user}    Create Dictionary    
    ...    name=${EMPTY} 
    ...    email=${EMPTY}   
    ...    password=${EMPTY} 

    Go to signup page
    Submit signup form    ${user}
    Alert should be    Informe seu nome completo
    Alert should be    Informe seu e-email
    Alert should be    Informe uma senha com pelo menos 6 digitos
    
Não deve cadastrar com email incorreto

        ${user}    Create Dictionary    
    ...    name=${EMPTY} 
    ...    email=chavier.com.br  
    ...    password=${EMPTY} 

    Go to signup page
    Submit signup form    ${user}
    Alert should be    Digite um e-mail válido

Não deve cadastrar com senha de 1 digito
    [Tags]    short_pass
    [Template]
    short password    1

Não deve cadastrar com senha de 2 digitos
    [Tags]    short_pass
    [Template]
    short password    12

Não deve cadastrar com senha de 3 digitos
    [Tags]    short_pass
    [Template]
    short password    123

Não deve cadastrar com senha de 4 digitos
    [Tags]    short_pass
    [Template]
    short password    1234

Não deve cadastrar com senha de 5 digitos
    [Tags]    short_pass
    [Template]
    short password    12345


Não deve cadastrar com senha muito curta

    @{password_list}    Create List    1    12    123    1234    12345

    FOR  ${password}  IN  @{password_list}
        ${user}    Create Dictionary    
        ...    name=Wellington Júnior
        ...    email=wpsjunior23@gmail.com
        ...    password=${password}
        
        Go to signup page
        Submit signup form    ${user}
        Alert should be    Informe uma senha com pelo menos 6 digitos
    END
    