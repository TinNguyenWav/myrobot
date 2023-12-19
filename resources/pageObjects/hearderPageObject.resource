*** Settings ***
Resource    ../../configurations/config.resource


*** Variables ***
${HEADER_sel}       css=frontend-header


*** Keywords ***
Header should contains user name of user login
    [Arguments]    ${user name}
    Wait Until Page Contains Element    ${HEADER_sel}
    Wait Until Element Contains    ${HEADER_sel}    ${user name}
