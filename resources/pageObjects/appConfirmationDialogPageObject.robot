*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../../resources/keywords/command.resource


*** Variables ***
${MESSAGE_CONTENT_SELECTOR}     css:app-confirmation-dialog .modal-body


*** Keywords ***
Get Message Content From Confirmation Dialog
    ${element}=    Get Element by locator    ${MESSAGE_CONTENT_SELECTOR}
    ${msg}=    Get Text    ${element}
    RETURN    ${msg}
