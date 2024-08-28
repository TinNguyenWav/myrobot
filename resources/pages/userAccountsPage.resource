*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../keywords/command.resource
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
Click on the New User Account button
    Wait Until Element Is Enabled    css=button[class*="add-btn"]>i[class="fa fa-plus"]
    Click Element    css=button[class*="add-btn"]>i[class="fa fa-plus"]
Input value for the Search Employee field
    [Arguments]    ${value}   
    Wait Until Element Is Enabled    css=input[role="searchbox"]
    Input text to css=input[role="searchbox"] with ${value}
    
Select the searched employee account
    Wait Until Element Is Enabled    css=ul[role="listbox"]
    Click Element    css=ul[role="listbox"]>li:first-child
Click on the Submit button of the Add User Account pop-up
    Sleep    5s
    Wait Until Element Is Enabled    css=div[class="submit-section"]>button[class*="submit-btn"]
    Click Element    css=div[class="submit-section"]>button[class*="submit-btn"]
Click on the Action Menu of a user account
    ${user_accounts_list}=    Get WebElements    css=tbody[class*="p-datatable-tbody"]>tr
    ${user_accounts_list_length}=    Get Length    ${user_accounts_list}
    IF    ${user_accounts_list_length} > 0
        Wait Until Element Is Enabled    css=tbody>tr:first-child>td:nth-child(7) i[class="dropdown-toggle material-icons"]
        Click Element    css=tbody>tr:first-child>td:nth-child(7) i[class="dropdown-toggle material-icons"]
        
    ELSE
        Log    There are not any user accounts at User Accounts page         
    END
Select the Edit option on the Action Menu of a user account
    Wait Until Element Is Enabled    css=body>div.dropdown>div>button:nth-child(1)
    Click Element    css=body>div.dropdown>div>button:nth-child(1)
Select a value on the Role dropdown
    Wait Until Element Is Enabled    css=div[class="modal-body"] chevrondownicon
    Click Element    css=div[class="modal-body"] chevrondownicon
    Wait Until Element Is Enabled    ${SEARCH_INPUT_ROLE_NAME_USER_ACCOUNT_ELE}
    Sleep    1s
    Input text to ${SEARCH_INPUT_ROLE_NAME_USER_ACCOUNT_ELE} with Test Role
    Wait Until Element Is Enabled    css=ul[role="listbox"]>p-multiselectitem>li[aria-label="Test Role"]
    Click Element    css=ul[role="listbox"]>p-multiselectitem>li[aria-label="Test Role"]
Click on the Assign Roles button
    Wait Until Element Is Enabled    xpath=//button[contains(text(),'Assign Roles')]
    Click Element    xpath=//button[contains(text(),'Assign Roles')]
Click on the Submit button on the Edit User Account pop-up
    Wait Until Element Is Enabled    xpath=//button[contains(text(),'Submit')]
    Click Element    xpath=//button[contains(text(),'Submit')]
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
    ${value}=    Get Text    css=table[id="pn_id_1-table"]>tbody[class="p-element p-datatable-tbody"]>tr:first-child>td:nth-child(4)
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
        Page Should Not Contain Element    xpath=//lable[contains(text(),'Grant access to System with Company Email')]
    ELSE
        Page Should Contain Element    xpath=//lable[contains(text(),'Grant access to System with Company Email')]
    END
There is one employee who only has the employee account
    Add an new employee account at Employees page

The account should be displayed on the User Accounts page
    [Arguments]    ${value}
    Wait Until Element Is Enabled    css=ul[role="listbox"]
    ${item_list}=    Get WebElements    css=ul[role="listbox"]>li
    ${length}=    Get Length    ${item_list}
    IF    ${length} == 1
        Page Should Contain    ${value}
        Element Should Contain    css=ul[role="listbox"]>li>div>div    ${value}
    ELSE
        Log    There is not any account match with information that provides
    END
User should be edited success the user account
    Wait Until Element Is Enabled    css=div[class="toast-body"]
    Page Should Contain Element    css=div[class="toast-body"]
    Page Should Contain    Edit user account successfully