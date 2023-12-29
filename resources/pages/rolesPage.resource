*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../../resources/keywords/command.resource
Resource    ../pageObjects/toastMessagePageObject.resource


*** Variables ***
${URL_ROLES}                            /app/user/roles
${ROLE_CREATED_SUCCESSFULLY_MSG}        Permission group was saved successfully
${NAME_LOCATOR}                         css:input-text[ng-reflect-label="Name"] input
${PARENT_ID_LOCATOR}                    parentId
${LOCATION_ID_LOCATOR}                  locationId
${SUBMIT_BUTTON_LOCATOR}                css:button.submit-btn
${ADD_ROLE_BUTTON_LOCATOR}              css:a.btn
${ROLE_DETAILS_POPUP_LOCATOR}           css:app-role-detail
${LOCATION_MENU_ITEM_ROLES_LOCATOR}     css:.roles-menu a


*** Keywords ***
Access Roles page
    Go To    ${BASE_URL}${URL_ROLES}
    Wait Until Location Contains    ${URL_ROLES}
    Roles page should be opened

Click location name
    [Arguments]    ${name}
    Click desired text from list    ${LOCATION_MENU_ITEM_ROLES_LOCATOR}    ${name}

Click role name
    [Arguments]    ${name}
    Click on the link text    ${name}

Click on Add Role button
    Click on the web element    ${ADD_ROLE_BUTTON_LOCATOR}

Click on Submit button
    Click on the web element    ${SUBMIT_BUTTON_LOCATOR}

Input text to Name field
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

Add role successfully
    ${msg}=    Get toast message content
    Wait Until Keyword Succeeds
    ...    ${RETRY}
    ...    ${INTERVAL}
    ...    Should Contain    ${msg}    ${ROLE_CREATED_SUCCESSFULLY_MSG}

Delete role
    [Arguments]    ${name}
    ${table_rows}=    Set Variable    css:tbody>tr
    ${row}=    Get element by text    ${name}
    ${locator}=    Get Element Attribute    ${row}    css
    Log    ${locator}
