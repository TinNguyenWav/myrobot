*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../../resources/keywords/command.resource
Resource    ../pageObjects/toastMessagePageObject.resource
Resource    ../pageObjects/appConfirmationDialogPageObject.robot


*** Variables ***
${URL_ROLES}                            /app/user/roles
${ROLE_CREATED_SUCCESSFULLY_MSG}        Permission group was saved successfully
${NAME_LOCATOR}                         css:input-text[ng-reflect-label="Name"] input
${PARENT_ID_LOCATOR}                    parentId
${LOCATION_ID_LOCATOR}                  locationId
${SUBMIT_BUTTON_LOCATOR}                css:button.submit-btn
${ADD_ROLE_BUTTON_LOCATOR}              css:a.btn
${ROLE_DETAILS_POPUP_LOCATOR}           css:app-role-detail
# ${LOCATION_MENU_ITEM_ROLES_LOCATOR}    css:.roles-menu a
${LOCATION_MENU_ITEM_ROLES_LOCATOR}     css:.roles-menu li
${ACTION_MENU_LIST_ELEMENT}             css:td.dropdown-container
${ACTION_MENU_OPTION_ELEMENT}           css:button.dropdown-item


*** Keywords ***
Access Roles page
    Go To    ${BASE_URL}${URL_ROLES}
    Wait Until Location Contains    ${URL_ROLES}
    Roles page should be opened

Click location name
    [Arguments]    ${name}
    ${element}=    Click desired text from list    ${LOCATION_MENU_ITEM_ROLES_LOCATOR}    ${name}
    Wait Until Keyword Succeeds
    ...    ${RETRY}
    ...    ${INTERVAL}
    ...    Element Attribute Value Should Be    ${element}    class    active

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

App should show message about role was saved successfully
    ${msg}=    Get toast message content
    Wait Until Keyword Succeeds
    ...    ${RETRY}
    ...    ${INTERVAL}
    ...    Should Contain    ${msg}    ${ROLE_CREATED_SUCCESSFULLY_MSG}

Delete role
    [Arguments]    ${role_name}
    Select option from action menu    ${role_name}    Delete
    Click on OK button of Confirmation Dialog

Click on dropdown item value
    [Arguments]    ${value}
    Click desired text from list    ${ACTION_MENU_OPTION_ELEMENT}    ${value}

Select option from action menu
    [Arguments]    ${row_value}    ${option}
    ${table_rows}=    Set Variable    css:tbody>tr
    Wait Until Page Contains Element    ${table_rows}
    @{rows}=    Get WebElements    ${table_rows}
    ${menu_items}=    Get WebElements    ${ACTION_MENU_LIST_ELEMENT}
    ${i}=    Set Variable    0
    FOR    ${element}    IN    @{rows}
        ${is_contains}=    Run Keyword And Return Status    Element Should Contain    ${element}    ${row_value}
        IF    "${is_contains}" == "True"
            Scroll to element    ${element}
            ${menu}=    Set Variable    ${menu_items}[${i}]
            Click on the web element    ${menu}
            Click on dropdown item value    ${option}
            RETURN
        ELSE
            ${i}=    Evaluate    ${i} + 1
            Log    Not found
        END
    END

Scroll to element
    [Arguments]    ${element}
    Wait Until Keyword Succeeds
    ...    ${RETRY}
    ...    ${INTERVAL}
    ...    Run Keyword And Ignore Error    Scroll Element Into View    ${element}
