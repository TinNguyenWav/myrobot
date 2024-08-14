*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../keywords/command.resource
*** Variables ***
${URL_USERACCOUNTS}    /app/user/accounts
${USERACCOUNT_PAGE_TITLE_ELEMENT}
${EMPLOYEEEMALI_SEARCH_FIELD_ELE}         css=input-text[id*="input-text_email_2"]>input
${SEARCHUSERACCOUNT_BTN_ELE}    css=formly-field[class*="search-btn-container"] button[class*="btn"]
@{DEPARTMENT_LIST}=    Sale    Marketing    Customer Service    Quality Assurance/Control    Operations/Production    
...                    Information Technology (IT)    Finance and Accounting    Human Resources (HR)    Legal and Compliance
...                    Research and Development (R&D)
@{POSITION_LIST}=      Product manager    President    Chief financial officer or controller (CFO)    Chief operating officer (COO)
...                    Executive    Accountant    Business analyst    Human resources manager    Product manager
*** Keywords ***
# ------------------------ACTION--------------------------
Input value for Employee Email at User Accounts Page
    [Arguments]    ${value}
    Input text to ${EMPLOYEEEMALI_SEARCH_FIELD_ELE} with ${value}
Click on the Search button
    Click Element    ${SEARCHUSERACCOUNT_BTN_ELE}
# ------------------------BEHAVIOR--------------------------
Access the User Account page
    Go To    ${BASE_URL}${URL_EMPLOYEE}
    Wait Until Location Contains    ${URL_EMPLOYEE}
    Employees page should be opened
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
# ------------------------EXPECTED--------------------------
User Accounts page should be opened
    ${current URL}=    Get Location
    Should Contain    ${current URL}    ${URL_USERACCOUNTS}
    Wait Until Page Contains Element    ${USERACCOUNT_PAGE_TITLE_ELEMENT}
    Element Should Contain    ${USERACCOUNT_PAGE_TITLE_ELEMENT}    User Accounts

The added user account should display on the User Accounts page
    [Arguments]    ${email}
    Page Should Contain Element    xpath=//tr[contains(@class,"table-row")]//td[4][contains(text(),"${email}")]
    