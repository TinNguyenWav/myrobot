*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../pageObjects/multipleSelectPanel.resource
Resource    ../keywords/common_test_steps.resource
Resource    ../pages/userAccountsPage.resource
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
${ADDRESS_FIELD_ELE}                    css=input-text[id*="text_currentResidentialAddress_8"]>input
${LASTNAME_FIELD_ELE}                   css=input-text[id*="lastName_3"]>input
${EMAIL_FIELD_ELE}                      css=input-text[id*="email_6"]>input
${JOININGDATE_FIELD_ELE}                css=datetime-picker[id*="date-time_startDate_10"]>p-calendar>span>input
${DEPARTMENT_FIELD_ELE}                 css=ng-select-item[id*="departmentId_12"] div[role="button"]
${DEPARTMENT_SEARCH_FIELD_ELE}          css=input[class="p-dropdown-filter p-inputtext p-component"]
${POSITION_FIELD_ELE}                   css=ng-select-item[id*="positionId_11"]
${POSITION_SEARCH_FIELD_ELE}            css=input[class="p-dropdown-filter p-inputtext p-component"]
${LOCATION_FIELD_ELE}                   css=ng-select-item[id*="select_locationId_9"]
${LOCATION_SEARCH_FIELD_ELE}            css=input[class="p-dropdown-filter p-inputtext p-component"]
${SUBMITADDEMPLOYEE_BTN_ELE}            css=div[class="submit-section"]>button[class*="submit-btn"]
${EMPLOYEE_ACCOUNT_LIST_ELE}            css=table[id="pn_id_1-table"]>tbody[class="p-element p-datatable-tbody"]>tr
${EMP_ID_INPUT_ELE}                     css=frontend-prefix-input[id="formly_22_prefix-input_fullCode_0"] input
${EDIT_OPTION_EMPLOYEE_ACCOUNT_ELE}     xpath=//ul[@role="menu"]//li[@role="menuitem"]//a[contains(text(),"Edit")]
${FIRST_EMPLOYEE_ELE}                   css=table[id="pn_id_1-table"]>tbody[class="p-element p-datatable-tbody"]>tr:first-child
${ACTION_MENU_EMPLOYEE_ACCOUNT_ELE}     css=table[id="pn_id_1-table"]>tbody[class="p-element p-datatable-tbody"]>tr:first-child>div>button>i[class="material-icons"]
${EMPLOYEE_NAME_ELE}                    css=tbody[class="p-element p-datatable-tbody"]>tr:first-child>td:nth-child(3)>a:nth-child(2)
${GRANT_ACCESS_FOR_PROFILE_CHECKBOX_ELE}    css=check-box[id*="check-box-control_grantedAccess_0"]


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
Input value for the First Name field
    [Arguments]    ${value}
    Sleep    1s
    Wait Until Element Is Enabled    ${FIRSTNAME_FIELD_ELE}
    Input text to ${FIRSTNAME_FIELD_ELE} with ${value}
Input value for the Last Name field
    [Arguments]    ${value}
    Wait Until Element Is Enabled    ${LASTNAME_FIELD_ELE}
    Input text to ${LASTNAME_FIELD_ELE} with ${value}

Input value for the Email field
    [Arguments]    ${value}
    Input text to ${EMAIL_FIELD_ELE} with ${value}
Input value for the Joining Date field
    ${value}=    Get current time
    Input text to ${JOININGDATE_FIELD_ELE} with ${value}

Select value for the Department field
    [Arguments]    ${option}
    TRY
        
        Wait Until Element Is Enabled    ${ADDRESS_FIELD_ELE}
        Click Element    ${ADDRESS_FIELD_ELE}
        Wait Until Element Is Enabled    ${DEPARTMENT_FIELD_ELE}
        Scroll Element Into View    ${DEPARTMENT_FIELD_ELE}
        Click Element    ${DEPARTMENT_FIELD_ELE}
        Input text to ${DEPARTMENT_SEARCH_FIELD_ELE} with ${option}
        Wait Until Element Is Enabled    css=li[aria-label="${option}"]
        Scroll Element Into View    css=li[aria-label="${option}"]
        Click Element    css=li[aria-label="${option}"]
        
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Can not select the ${option} on the Contract Type dropdown field
    END

Select value for the Position field
    [Arguments]    ${option}
    TRY
        Click Element    ${POSITION_FIELD_ELE}
        Input text to ${POSITION_SEARCH_FIELD_ELE} with ${option}
        Sleep    2s
        Click Element    css=li[aria-label="${option}"]
        
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Can not select the ${option} on the Contract Type dropdown field
    END

Select value for the Location field
    [Arguments]    ${option}
    TRY
        Click Element    ${LOCATION_FIELD_ELE}
        Input text to ${LOCATION_SEARCH_FIELD_ELE} with ${option}
        Sleep    2s
        Click Element    css=li[aria-label="${option}"]
        
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Can not select the ${option} on the Contract Type dropdown field
    END
Select the Grant access to System checkbox
    Click Element    ${GRANT_ACCESS_FOR_PROFILE_CHECKBOX_ELE}

Click on the Submit button
    Scroll Element Into View    ${SUBMITADDEMPLOYEE_BTN_ELE}
    Click Element    ${SUBMITADDEMPLOYEE_BTN_ELE}
Select an employee account
    ${employee_name}=    Get WebElement    ${EMPLOYEE_NAME_ELE}
    Click on the web element    ${employee_name}
Click on the Action menu of an employee account
    Wait Until Element Is Enabled    ${EMPLOYEE_ACCOUNT_LIST_ELE}
    ${list_row}=    Get WebElements    ${EMPLOYEE_ACCOUNT_LIST_ELE}
    ${check_length}=    Get Length    ${list_row}
    ${check}=    Get email of email field on edit profile pop-up
    IF    ${check_length} > 0
        IF    ${check} == 1
            ${result}=    Evaluate    1
            Set Global Variable    ${result} 
        ELSE
            ${result}=    Evaluate    0
            Set Global Variable    ${result} 
        END
            Access Employees page
            Wait Until Element Is Enabled    ${FIRST_EMPLOYEE_ELE}
            Mouse Over    ${FIRST_EMPLOYEE_ELE}
            Wait Until Element Is Enabled    ${ACTION_MENU_EMPLOYEE_ACCOUNT_ELE}
            Click Element    ${ACTION_MENU_EMPLOYEE_ACCOUNT_ELE} 
    ELSE
        Fail    Log    Don't have any employee account to select
    END
Select the Edit option on the Action menu of an employee account
    Wait Until Element Is Enabled    ${EDIT_OPTION_EMPLOYEE_ACCOUNT_ELE}
    Click Element    ${EDIT_OPTION_EMPLOYEE_ACCOUNT_ELE}

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
Get Employee ID on Add New Employee pop-up
    Wait Until Element Is Enabled    ${EMP_ID_INPUT_ELE}
    ${EMPLOYEE_ID}=    Get Value    ${EMP_ID_INPUT_ELE}
    ${EMPLOYEE_ID}=    Set Variable    ${EMPLOYEE_ID}
    Set Global Variable    ${EMPLOYEE_ID}
    RETURN    ${EMPLOYEE_ID}
Add an new employee account at Employees page
    Login system with admin user account second
    Access Employees page
    Create data
    Click Add Employee button
    Input value for the First Name field    Robot
    Input value for the Last Name field    ${LAST_NAME}
    Input value for the Email field    ${EMAIL_EMPLOYEE}
    Select value for the Location field    Vietnam
    Select value for the Position field    ${POSITION}
    Input value for the Joining Date field
    Select value for the Department field    ${DEPARTMENT}
    Get Employee ID on Add New Employee pop-up
    Click on the Submit button
    Wait Until Page Contains    Employee was created successfully
