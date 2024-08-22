*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../pageObjects/multipleSelectPanel.resource

Library    Process

*** Variables ***
${URL_EMPLOYEE}                         /app/employee/list
${PAGE_TITLE_ELEMENT}                   css=.page-title
${SEARCH_PROPERTY_ELEMENT}              css=[ng-reflect-label='Email'] input
${EMPLOYEE_ID_SEARCHBOX_ELEMENT1}       css=label:contains('Employee ID')
${EMPLOYEE_ID_SEARCHBOX_ELEMENT}        css=label:contains('Employee ID') ~ formly-field-input input
${ACTION_MENU_ELEMENT}                  css=Button.dropdown-toggle
${FIRST_ROW_ELEMENT}                    css=tbody tr
${DEPARTMENT_ID_LOCATOR}                departments
${EMPLOYEE_ID_FIELD_ELE}    
${FIRSTNAME_FIELD_ELE}                  css=input-text[id*="firstName_2"]>input
${ADDRESS_FIELD_ELE}                  css=input-text[id*="text_currentResidentialAddress_8"]>input
${LASTNAME_FIELD_ELE}                   css=input-text[id*="lastName_3"]>input
${EMAIL_FIELD_ELE}                      css=input-text[id*="email_6"]>input
${JOININGDATE_FIELD_ELE}                css=datetime-picker[id*="date-time_startDate_10"]>p-calendar>span>input
${DEPARTMENT_FIELD_ELE}                 css=ng-select-item[id*="departmentId_12"]
${DEPARTMENT_SEARCH_FIELD_ELE}          css=input[class="p-dropdown-filter p-inputtext p-component"]
${POSITION_FIELD_ELE}                   css=ng-select-item[id*="positionId_11"]
${POSITION_SEARCH_FIELD_ELE}            css=input[class="p-dropdown-filter p-inputtext p-component"]
${LOCATION_FIELD_ELE}                   css=ng-select-item[id*="select_locationId_9"]
${LOCATION_SEARCH_FIELD_ELE}            css=input[class="p-dropdown-filter p-inputtext p-component"]
${SUBMITADDEMPLOYEE_BTN_ELE}            css=div[class="submit-section"]>button[class*="submit-btn"]


*** Keywords ***
### Actions ###

Click Add Employee button
    Click Button    New Employee

Click Search button
    Click Button    Search

# Input text to ${field} with ${value}
#    Input Text    css=[ng-reflect-label='${field}'] input    ${value}

Click on "${action}" option on Action menu
    [Arguments]    ${Email}
    Search by "Email"    ${Email}
    Wait Until Page Contains    ${Email}
    Click Element    ${FIRST_ROW_ELEMENT}
    Click Element    ${ACTION_MENU_ELEMENT}
    Click Element    link=${action}

Click on sort icon of column name "${column}"
    IF    "${column}" == "ID"
        ${column}=    Set Variable    code
        Click Element    css=[sortcolumn='${column}']
    ELSE IF    "${column}" == "Mobile"
        ${column}=    Set Variable    phone
        Click Element    css=[sortcolumn='${column}']
    ELSE IF    "${column}" == "Join Date"
        ${column}=    Set Variable    startDate
        Click Element    css=[sortcolumn='${column}']
    ELSE IF    "${column}" == "Position"
        ${column}=    Set Variable    position.name
        Click Element    css=[sortcolumn='${column}']
    ELSE IF    "${column}" == "Department"
        ${column}=    Set Variable    department.name
        Click Element    css=[sortcolumn='${column}']
    ELSE
        ${sortcolumn}=    Convert To Lower Case    ${column}
        Click Element    css=[sortcolumn='${sortcolumn}']
    END

Click on Employee name "${employeeName}"
    [Arguments]    ${Email}
    Search by "Email"    ${Email}
    Wait Until Page Contains    ${Email}
    Wait Until Element Contains    ${FIRST_ROW_ELEMENT}    ${employeeName}
    Click Element    link=${employeeName}
Click on the Submit button
    Scroll Element Into View    ${SUBMITADDEMPLOYEE_BTN_ELE}
    Click Element    ${SUBMITADDEMPLOYEE_BTN_ELE}
Select an employee account
    ${employee_name}=    Get WebElement    css=tbody[class="p-element p-datatable-tbody"]>tr:first-child>td:nth-child(3)>a:nth-child(2)
    Click on the web element    ${employee_name}
### Behavior ###

Access Employees page
    Go To    ${BASE_URL}${URL_EMPLOYEE}
    Wait Until Location Contains    ${URL_EMPLOYEE}
    Employees page should be opened

Employees page should be opened
    ${current URL}=    Get Location
    Should Contain    ${current URL}    ${URL_EMPLOYEE}
    Wait Until Page Contains Element    ${PAGE_TITLE_ELEMENT}
    Element Should Contain    ${PAGE_TITLE_ELEMENT}    Employees

Get text field by label
    [Arguments]    ${expected_label}
    @{list_label}=    Get WebElements    css=label.form-label
    ${index}=    Set Variable    0
    FOR    ${element}    IN    @{list_label}
        ${lable}=    Get Text    ${element}
        IF    '${lable}'=='${expected_label}'
            ${input_fields}=    Get WebElements    css:formly-field-input input
            ${input_field}=    Get WebElement    ${input_fields}[${index}]
            RETURN    ${input_field}
        END    
        ${index}=    Evaluate    ${index} + 1
    END

Search by "${field}"
    [Arguments]    ${value}
    ${field}=    Get text field by label    ${field}
    Input text to ${field} with ${value}
    Click Search button

Get Search box by label
    [Arguments]    ${label}
    ${Searchbox}=    Get Element by locator    css=[ng-reflect-label='${label}'] input

Select Department name
    [Arguments]    ${name}
    ${LOCATOR}=    Get Element by locator    ${DEPARTMENT_ID_LOCATOR}
    Select option in dropdown menu    ${LOCATOR}    ${name}
