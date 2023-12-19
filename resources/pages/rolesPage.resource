*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../../resources/keywords/command.resource


*** Variables ***
${URL_ROLES}                        /app/user/roles
${LOCATION_MENU_ROLES_LOCATOR}      css:.roles-menu a
${ROLE_DETAILS_POPUP_LOCATOR}       css:app-role-detail


*** Keywords ***
Access Roles page
    Go To    ${BASE_URL}${URL_ROLES}
    Wait Until Location Contains    ${URL_ROLES}
    Roles page should be opened

Click location name
    [Arguments]    ${location_name}
    Click desired text from list    ${LOCATION_MENU_ROLES_LOCATOR}    ${location_name}

Click role name
    [Arguments]    ${role_name}
    Click on the link text    ${role_name}

Click on Add Role button
    Click on the element    Add Role

Role detail popup should contain text
    [Arguments]    ${expected_text}
    Expect webelement contains text    ${ROLE_DETAILS_POPUP_LOCATOR}    ${expected_text}

Roles page should be opened
    ${current URL}=    Get Location
    Should Contain    ${current URL}    ${URL_ROLES}
