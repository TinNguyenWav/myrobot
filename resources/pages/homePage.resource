*** Settings ***
Resource    ../../configurations/config.resource


*** Variables ***
${URL_HOME}     /app


*** Keywords ***
Home page should be opened
    ${current URL}=    Get Location
    Should Contain    ${current URL}    ${URL_HOME}
