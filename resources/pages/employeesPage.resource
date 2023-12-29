*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../pageObjects/multipleSelectPanel.resource


*** Variables ***
${URL_EMPLOYEE}                         /app/employee/list
${PAGE_TITLE_ELEMENT}                   css=.page-title
${SEARCH_PROPERTY_ELEMENT}              css=[ng-reflect-label='Email'] input
${EMPLOYEE_ID_SEARCHBOX_ELEMENT1}       css=label:contains('Employee ID')
${EMPLOYEE_ID_SEARCHBOX_ELEMENT}        css=label:contains('Employee ID') ~ formly-field-input input
${ACTION_MENU_ELEMENT}                  css=Button.dropdown-toggle
${FIRST_ROW_ELEMENT}                    CSS=tbody tr
${DEPARTMENT_ID_LOCATOR}                departments


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

Search by "${field}"
    [Arguments]    ${value}
    Input text to ${field} with ${value}
    Click Search button

Get Search box by label
    [Arguments]    ${label}
    ${Searchbox}=    Get Element by locator    css=[ng-reflect-label='${label}'] input

Select Department name
    [Arguments]    ${name}
    ${LOCATOR}=    Get Element by locator    ${DEPARTMENT_ID_LOCATOR}
    Select option in dropdown menu    ${LOCATOR}    ${name}
