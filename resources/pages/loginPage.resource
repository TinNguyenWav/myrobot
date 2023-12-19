*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../keywords/command.resource


*** Variables ***
${URL_LOGIN}                /login
${USERNAME_TXT_ELEMENT}     css=#email
${PASSWORD_TXT_ELEMENT}     css=#password
${LOGIN_BTN_ELEMENT}        css=.account-btn


*** Keywords ***
Open Login page
    Open Browser    ${BASE_URL}${URL_LOGIN}    ${BROWSER}
    Maximize Browser Window

Input username
    [Arguments]    ${username}
    Input Text    ${USERNAME_TXT_ELEMENT}    ${username}

Input password
    [Arguments]    ${password}
    Input Text    ${PASSWORD_TXT_ELEMENT}    ${password}

Click Login button
    Click Button    ${LOGIN_BTN_ELEMENT}

Login with username and password
    [Arguments]    ${username}    ${password}
    Stop logging info
    Input username    ${username}
    Input password    ${password}
    Restore logging info
    Click Login button

Login page is opened
    Page Should Contain Element    css=.account-title
