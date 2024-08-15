*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../../resources/keywords/command.resource


*** Variables ***
${MESSAGE_CONTENT_SELECTOR}     css:app-confirmation-dialog .modal-body
${OK_BUTTON_SELECTOR}           css:button.btn-primary
${CANCEL_BUTTON_SELECTOR}       css:button.btn-secondary


*** Keywords ***
Get Message Content From Confirmation Dialog
    ${element}=    Get Element by locator    ${MESSAGE_CONTENT_SELECTOR}
    ${msg}=    Get Text    ${element}
    RETURN    ${msg}

Click on OK button of Confirmation Dialog
    Click on the web element    ${OK_BUTTON_SELECTOR}

Click on Cancel button of Confirmation Dialog
    Click on the web element    ${CANCEL_BUTTON_SELECTOR}
