*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../../resources/keywords/command.resource
Resource    ../pages/employeesPage.resource


*** Variables ***
${SEARCH_BOX_LOCATOR}       css:input.p-dropdown-filter


*** Keywords ***
Search with text
    [Arguments]    ${tex}
    Input text to text field    ${SEARCH_BOX_LOCATOR}    ${tex}

Search and select option
    [Arguments]    ${tex}
    ${DROPDOWN_ITEM_LOCATOR}    Set Variable    css:p-dropdownitem[ng-reflect-label='${tex}']
    Input text to text field    ${SEARCH_BOX_LOCATOR}    ${tex}
    Click Element    ${DROPDOWN_ITEM_LOCATOR}

    # Click on element contains text    ${tex}
