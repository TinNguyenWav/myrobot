*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../keywords/command.resource
Library    XML
Resource    ./employeesPage.resource
*** Variables ***
${URL_USERACCOUNTS}    /app/user/accounts
${USERACCOUNT_PAGE_TITLE_ELEMENT}        css=h3[class="page-title"]
${EMPLOYEEEMALI_SEARCH_FIELD_ELE}         css=input-text[id*="input-text_email_2"]>input
${SEARCHUSERACCOUNT_BTN_ELE}    css=button[type="submit"]>i[class="fa fa-search"]
@{DEPARTMENT_LIST}=    Sale    Marketing    Customer Service    Quality Assurance/Control    Operations/Production    
...                    Information Technology (IT)    Finance and Accounting    Human Resources (HR)    Legal and Compliance
...                    Research and Development (R&D)
@{POSITION_LIST}=      Product manager    President    Chief financial officer or controller (CFO)    Chief operating officer (COO)
...                    Executive    Accountant    Business analyst    Human resources manager    Product manager    President
${SEARCH_INPUT_ROLE_NAME_USER_ACCOUNT_ELE}    css=div[class*="p-multiselect-filter-container"]>input
${MESSAGE_ELE}         css=div[class="toast-body"]
${NEW_USER_ACCOUNT_BTN_ELE}         css=button[class*="add-btn"]>i[class="fa fa-plus"]
${SEARCH_EMPLOYEE_UA_ELE}         css=input[role="searchbox"]
${SEARCH_LIST_ELE}         css=ul[role="listbox"]
${SEARCH_FIRST_ITEM_ELE}         css=ul[role="listbox"]>li:first-child
${SUBMIT_BTN_ADD_USER_POPUP_ELE}         css=div[class="submit-section"]>button[class*="submit-btn"]
${ACCOUNTS_USER_TABLE_ELE}         css=tbody[class*="p-datatable-tbody"]>tr
${ACTION_MENU_ICON_ELE}         css=tbody>tr:first-child>td:nth-child(7) i[class="dropdown-toggle material-icons"]
${EDIT_OPTION_USER_ACCOUNT_ELE}    css=body>div.dropdown>div>button:nth-child(1)
${OPTION_OF_ROLE_ELE}    css=ul[role="listbox"]>p-multiselectitem>li[aria-label="Test Role"]
${ASSIGN_ROLE_BTN_ELE}    xpath=//button[contains(text(),'Assign Roles')]
${SUBMIT_BTN_EDIT_USER_ACCOUNT_ELE}    xpath=//button[contains(text(),'Submit')]
${USER_STATUS_DROPDOWN_ELE}    css=ng-select-item[id*="_status_3"]
${OPTION_OF_ACTIONMENU_USER_ACCOUNT_ELE}    css=body>div.dropdown>div>button:nth-child(2)
${EMAILVALUE_EDIT_PROFILE_ELE}    css=table[id="pn_id_1-table"]>tbody[class="p-element p-datatable-tbody"]>tr:first-child>td:nth-child(4)
${GRANT_ACCESS_FOR_PROFILE_TITLE_ELE}    xpath=//lable[contains(text(),'Grant access to System with Company Email')]



*** Keywords ***
# ------------------------ACTION--------------------------
Input value for Employee Email at User Accounts Page
    [Arguments]    ${value}
    Page Should Contain Element    ${EMPLOYEEEMALI_SEARCH_FIELD_ELE}
    Wait Until Element Is Enabled    ${EMPLOYEEEMALI_SEARCH_FIELD_ELE}
    Input text to ${EMPLOYEEEMALI_SEARCH_FIELD_ELE} with ${value}
Click on the Search button
    Wait Until Element Is Enabled    ${SEARCHUSERACCOUNT_BTN_ELE}
    Click Element    ${SEARCHUSERACCOUNT_BTN_ELE}
    Sleep    1s
Click on the New User Account button
    Wait Until Element Is Enabled    ${NEW_USER_ACCOUNT_BTN_ELE}
    Click Element    ${NEW_USER_ACCOUNT_BTN_ELE}
Input value for the Search Employee field
    [Arguments]    ${value}   
    Wait Until Element Is Enabled    ${SEARCH_EMPLOYEE_UA_ELE}
    Input text to ${SEARCH_EMPLOYEE_UA_ELE} with ${value}
    
Select the searched employee account
    Wait Until Element Is Enabled    ${SEARCH_LIST_ELE}
    Click Element    ${SEARCH_FIRST_ITEM_ELE}
Click on the Submit button of the Add User Account pop-up
    Sleep    5s
    Wait Until Element Is Enabled    ${SUBMIT_BTN_ADD_USER_POPUP_ELE}
    Click Element    ${SUBMIT_BTN_ADD_USER_POPUP_ELE}
Click on the Action Menu of a user account
    ${user_accounts_list}=    Get WebElements    ${ACCOUNTS_USER_TABLE_ELE}
    ${user_accounts_list_length}=    Get Length    ${user_accounts_list}
    IF    ${user_accounts_list_length} > 0
            Wait Until Element Is Enabled    ${ACTION_MENU_ICON_ELE}
            Click Element    ${ACTION_MENU_ICON_ELE}
        
    ELSE
        Log    There are not any user accounts at User Accounts page         
    END
Select the Edit option on the Action Menu of a user account
    Wait Until Element Is Enabled    ${EDIT_OPTION_USER_ACCOUNT_ELE}
    Click Element    ${EDIT_OPTION_USER_ACCOUNT_ELE}
Select a value on the Role dropdown
    Wait Until Element Is Enabled    css=div[class="modal-body"] chevrondownicon
    Click Element    css=div[class="modal-body"] chevrondownicon
    Wait Until Element Is Enabled    ${SEARCH_INPUT_ROLE_NAME_USER_ACCOUNT_ELE}
    Sleep    1s
    Input text to ${SEARCH_INPUT_ROLE_NAME_USER_ACCOUNT_ELE} with Test Role
    Wait Until Element Is Enabled    ${OPTION_OF_ROLE_ELE}
    Click Element    ${OPTION_OF_ROLE_ELE}
Click on the Assign Roles button
    Wait Until Element Is Enabled    ${ASSIGN_ROLE_BTN_ELE}
    Click Element    ${ASSIGN_ROLE_BTN_ELE}
Click on the Submit button on the Edit User Account pop-up
    Wait Until Element Is Enabled    ${SUBMIT_BTN_EDIT_USER_ACCOUNT_ELE}
    Click Element    ${SUBMIT_BTN_EDIT_USER_ACCOUNT_ELE}
Select a value on the User Status dropdown
    [Arguments]    ${option_value}
    Wait Until Element Is Enabled    ${USER_STATUS_DROPDOWN_ELE}
    Click Element    ${USER_STATUS_DROPDOWN_ELE}
    Wait Until Element Is Enabled    css=ul[role="listbox"] li[aria-label="${option_value}"]
    Click Element    css=ul[role="listbox"] li[aria-label="${option_value}"]
Select the Resend Invite option on the Action Menu of a user account
    Wait Until Element Is Enabled    ${OPTION_OF_ACTIONMENU_USER_ACCOUNT_ELE}
    Click Element    ${OPTION_OF_ACTIONMENU_USER_ACCOUNT_ELE}
Select the Restore Access option on the Action Menu of a user account
    Wait Until Element Is Enabled    ${OPTION_OF_ACTIONMENU_USER_ACCOUNT_ELE}
    Click Element    ${OPTION_OF_ACTIONMENU_USER_ACCOUNT_ELE}
Select the Suspend Access option on the Action Menu of a user account
    Wait Until Element Is Enabled    ${OPTION_OF_ACTIONMENU_USER_ACCOUNT_ELE}
    Click Element    ${OPTION_OF_ACTIONMENU_USER_ACCOUNT_ELE}
# ------------------------BEHAVIOR--------------------------
Access the User Accounts page
    Go To    ${BASE_URL}${URL_USERACCOUNTS}
    Wait Until Location Contains    ${URL_USERACCOUNTS}
    User Accounts page should be opened
Create email of employee
    ${time}=    Get Current Date    result_format=%H%M%S%Y%m%d
    ${EMAIL_EMPLOYEE}=    Set Variable    robot${time}@gmail.com
    Set Global Variable    ${EMAIL_EMPLOYEE}
    RETURN    ${EMAIL_EMPLOYEE}
Create Department option
    ${department_length}=    Get Length    ${DEPARTMENT_LIST}
    ${random_index}=    Generate Random String    1    [NUMBERS]
    ${index}=    Convert To Integer    ${random_index}
    ${DEPARTMENT}=    Get From List    ${DEPARTMENT_LIST}    ${index}
    Set Global Variable    ${DEPARTMENT}
    RETURN    ${DEPARTMENT}
Create Position option
    ${department_length}=    Get Length    ${POSITION_LIST}
    ${random_index}=    Generate Random String    1    [NUMBERS]
    ${index}=    Convert To Integer    ${random_index}
    ${POSITION}=    Get From List    ${POSITION_LIST}    ${index}
    Set Global Variable    ${POSITION}
    RETURN    ${POSITION}
Create Last Name 
    ${random_string}=    Generate Random String    4    [NUMBERS]abcdef
    ${LAST_NAME}=    Set Variable    User${random_string}
    Set Global Variable    ${LAST_NAME}
    RETURN    ${LAST_NAME}

Create data
    Create email of employee
    Create Department option
    Create Position option
    Create Last Name
Get email of email field on edit profile pop-up
    ${value}=    Get Text    ${EMAILVALUE_EDIT_PROFILE_ELE}
    Access the User Accounts page
    Input value for Employee Email at User Accounts Page    ${value}
    Click on the Search button
    Wait Until Element Is Enabled    xpath=//tr[contains(@class,"table-row")]//td[4][contains(text(),"${value}")]
    ${check}=    Run Keyword And Return Status    Page Should Contain Element    xpath=//tr[contains(@class,"table-row")]//td[4][contains(text(),"${value}")]
    IF    ${check} == True
        #Employee had user account
        RETURN    1
    ELSE
        #Employee had not user account
        RETURN    0
    END
There is a user account that has Suspended status
    Login system with admin user account second
    Access the User Accounts page
    Select a value on the User Status dropdown    Active
    Click on the Search button
    Click on the Action Menu of a user account
    Select the Suspend Access option on the Action Menu of a user account
    The user should successfully select the Suspend Access
# ------------------------EXPECTED--------------------------
User Accounts page should be opened
    ${current URL}=    Get Location
    Should Contain    ${current URL}    ${URL_USERACCOUNTS}
    Wait Until Page Contains Element    ${USERACCOUNT_PAGE_TITLE_ELEMENT}
    Element Should Contain    ${USERACCOUNT_PAGE_TITLE_ELEMENT}    User Accounts

The added user account should display on the User Accounts page
    [Arguments]    ${email}
    Wait Until Element Is Enabled    xpath=//tr[contains(@class,"table-row")]//td[4][contains(text(),"${email}")]
    Page Should Contain Element    xpath=//tr[contains(@class,"table-row")]//td[4][contains(text(),"${email}")]
    
The system just should just show grant access for profile has no Account linked
    IF    ${result} == 1
        Page Should Not Contain Element    ${GRANT_ACCESS_FOR_PROFILE_TITLE_ELE}
    ELSE
        Page Should Contain Element    ${GRANT_ACCESS_FOR_PROFILE_TITLE_ELE}
    END
There is one employee who only has the employee account
    Add an new employee account at Employees page

The account should be displayed on the User Accounts page
    [Arguments]    ${value}
    Wait Until Element Is Enabled    ${SEARCH_LIST_ELE}
    ${item_list}=    Get WebElements    css=ul[role="listbox"]>li
    ${length}=    Get Length    ${item_list}
    IF    ${length} == 1
        Page Should Contain    ${value}
        Element Should Contain    css=ul[role="listbox"]>li>div>div    ${value}
    ELSE
        Log    There is not any account match with information that provides
    END
User should be edited success the user account
    Wait Until Element Is Enabled    ${MESSAGE_ELE}
    Page Should Contain Element    ${MESSAGE_ELE}
    Page Should Contain    Edit user account successfully
The user should successfully select the Resend Invite
    Sleep    1s
    Wait Until Element Is Enabled    ${MESSAGE_ELE}
    Page Should Contain    Resend invite to user successfully
The user should successfully select the Restore Invite
    Wait Until Element Is Enabled    ${MESSAGE_ELE}
    Sleep    1s
    Page Should Contain    Restore access user account successfully
The user should successfully select the Suspend Access
    Wait Until Element Is Enabled    ${MESSAGE_ELE}
    Sleep    1s
    Page Should Contain    Suspend user account successfully
    