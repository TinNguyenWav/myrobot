*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../../resources/keywords/command.resource


*** Variables ***
${TOAST_CONTAINER_sel}              css:.toast-container
${TOAST_BODY_SELECTOR}              css:.toast-body
${ROLE_CREATED_SUCCESSFULLY_MSG}    Permission group was saved successfully


*** Keywords ***
Get toast message content
    Wait Until Page Contains Element    ${TOAST_BODY_SELECTOR}
    ${element}=    Get Element by locator    ${TOAST_BODY_SELECTOR}
    ${msg_content}=    Wait Until Keyword Succeeds
    ...    ${RETRY}
    ...    ${INTERVAL}
    ...    Get Text    ${element}
    RETURN    ${msg_content}
