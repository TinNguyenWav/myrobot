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
Click on the Action menu of an employee account
    Wait Until Element Is Enabled    css=table[id="pn_id_1-table"]>tbody[class="p-element p-datatable-tbody"]>tr
    ${list_row}=    Get WebElements    css=table[id="pn_id_1-table"]>tbody[class="p-element p-datatable-tbody"]>tr
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
            Wait Until Element Is Enabled    css=table[id="pn_id_1-table"]>tbody[class="p-element p-datatable-tbody"]>tr:first-child
            Mouse Over    css=table[id="pn_id_1-table"]>tbody[class="p-element p-datatable-tbody"]>tr:first-child
            Wait Until Element Is Enabled    css=table[id="pn_id_1-table"]>tbody[class="p-element p-datatable-tbody"]>tr:first-child>div>button>i[class="material-icons"]
            Click Element    css=table[id="pn_id_1-table"]>tbody[class="p-element p-datatable-tbody"]>tr:first-child>div>button>i[class="material-icons"] 
    ELSE
        Fail    Log    Don't have any employee account to select
    END
Select the Edit option on the Action menu of an employee account
    Wait Until Element Is Enabled    xpath=//ul[@role="menu"]//li[@role="menuitem"]//a[contains(text(),"Edit")]
    Click Element    xpath=//ul[@role="menu"]//li[@role="menuitem"]//a[contains(text(),"Edit")]
Click on the New User Account button
    Wait Until Element Is Enabled    css=button[class*="add-btn"]>i[class="fa fa-plus"]
    Click Element    css=button[class*="add-btn"]>i[class="fa fa-plus"]
Input value for the Search Employee field
    Wait Until Element Is Enabled    css=input[role="searchbox"]
    Input text to css=input[role="searchbox"] with ${EMAIL_EMPLOYEE}
Select the searched employee account
    Wait Until Element Is Enabled    css=ul[role="listbox"]
    Click Element    css=ul[role="listbox"]>li:first-child
Click on the Submit button of the Add User Account pop-up
    # Wait Until Element Is Enabled    css=div[class="modal-body"]>div:nth-child(2)>div:nth-child(2)>div:nth-child(2)>p
    # ${EMAIL_EMPLOYEE_ON_ADD_USER_ACCOUNT_POPUP}=    Get Text    css=div[class="modal-body"]>div:nth-child(2)>div:nth-child(2)>div:nth-child(2)>p
    # Set Global Variable    ${EMAIL_EMPLOYEE_ON_ADD_USER_ACCOUNT_POPUP}
    Sleep    5s
    Wait Until Element Is Enabled    css=div[class="submit-section"]>button[class*="submit-btn"]
    Click Element    css=div[class="submit-section"]>button[class*="submit-btn"]
# ------------------------BEHAVIOR--------------------------
Access the User Account page
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
    Access the User Account page
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