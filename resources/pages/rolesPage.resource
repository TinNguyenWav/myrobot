*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../../resources/keywords/command.resource


*** Variables ***
${URL_ROLES}                        /app/user/roles
${LOCATION_MENU_ROLES_LOCATOR}      css:.roles-menu a
${ROLE_DETAILS_POPUP_LOCATOR}       css:app-role-detail
${ADD_ROLE_BUTTON_LOCATOR}          css:a.btn
${NAME_LOCATOR}                     css:input-text[ng-reflect-label='Name'] input
${LOCATION_ID_LOCATOR}              locationId
${PARENT_ID_LOCATOR}                parentId


*** Keywords ***
Access Roles page
    Go To    ${BASE_URL}${URL_ROLES}
    Wait Until Location Contains    ${URL_ROLES}
    Roles page should be opened

Click location name
    [Arguments]    ${name}
    Click desired text from list    ${LOCATION_MENU_ROLES_LOCATOR}    ${name}

Click role name
    [Arguments]    ${name}
    Click on the link text    ${name}

Click on Add Role button
    ${element}=    Get Element by locator    ${ADD_ROLE_BUTTON_LOCATOR}
    Click Element    ${element}

Input text to name field
    [Arguments]    ${text}
    Input text to text field    ${NAME_LOCATOR}    ${text}

Select Location name
    [Arguments]    ${name}
    ${LOCATOR}=    Get element by partial id    ${LOCATION_ID_LOCATOR}
    Select option in dropdown menu    ${LOCATOR}    ${name}

Select Parent name
    [Arguments]    ${name}
    ${LOCATOR}=    Get element by partial id    ${PARENT_ID_LOCATOR}
    Select option in dropdown menu    ${LOCATOR}    ${name}

Role detail popup should contain text
    [Arguments]    ${expected_text}
    Expect webelement contains text    ${ROLE_DETAILS_POPUP_LOCATOR}    ${expected_text}

Roles page should be opened
    ${current URL}=    Get Location
    Should Contain    ${current URL}    ${URL_ROLES}

Add Role popup should be opened
    Expect webelement contains text    ${ROLE_DETAILS_POPUP_LOCATOR}    Add Role
