*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../../resources/keywords/command.resource
Resource    ../pages/employeesPage.resource


*** Variables ***
${SEARCH_BOX_LOCATOR}       css:.p-multiselect-panel input[role="textbox"]


*** Keywords ***
Search with text
    [Arguments]    ${tex}
    Input text to text field    ${SEARCH_BOX_LOCATOR}    ${tex}

Search and select option
    [Arguments]    ${tex}
    Input text to text field    ${SEARCH_BOX_LOCATOR}    ${tex}
    Click on element contains text    ${tex}
