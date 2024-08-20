*** Settings ***
Resource    ../keywords/common_test_steps.resource
Resource    ../../configurations/config.resource

*** Variables ***
${CARD_TITLE_ELEMENT}       css:.card-title
${LOAD_ICON}                css:.p-element.p-icon-wrapper
${INSURANCE_ITEM}           css:.table-row
${TABLE_ROWS}               css:.p-element.p-datatable-tbody tr
${INSURANCETYPE}            css:.w-100.p-dropdown.p-component.p-dropdown-clearable
${LABLE_FORM_ELE}           css:.form-label.ng-star-inserted
${INPUT_FIELD_ELE}          css:.p-inputtext.p-component
${ADDBUTTON_BTN_ELE}        css:.d-flex.insurance-container .edit-icon
${DATE_FIELD_ELE}           css:.form-control.p-inputtext.p-component.ng-star-inserted
${SUBMIT_BTN_ELE}           css:.submit-section
${ADD_INSURANCE_POPUP}      css:.modal-content
${EDIT_INSURANCE_POPUP}     css:.modal-header
${MENU_OPTION}              css:.material-icons
${OPTIONS}                  css:.dropdown-item.ng-star-inserted
${DOWLOAD_FILE}             css:a[title="3.-Mot-so-goi-y-lien-quan-viec-chuan-bi-cac-minh-chung (1) (7) (1).docx"]
*** Keywords ***
The Insurances page should be opened 
    TRY
        Wait Until Page Contains Element    ${CARD_TITLE_ELEMENT}
        Element Should Contain    ${CARD_TITLE_ELEMENT}    Insurance Information
        Wait Until Element Is Visible    ${LOAD_ICON} 
        Wait Until Element Is Not Visible    ${LOAD_ICON} 
    EXCEPT   
        Run Keyword And Continue On Failure    Fail     There is a error happen in process The Insurances page should be opened 
    END

The number insurance of employee should be equal '${NUMBER}'
    TRY
        Sleep    3S
        @{LIST}=    Get list WebElements    ${INSURANCE_ITEM}  
        ${COUNT}=    Set Variable    0
        FOR    ${element}    IN    @{LIST}
            IF    ('${element}'!='')
                ${COUNT}=    Evaluate    ${COUNT}+1
            END
        END
        ${COUNT}=    Convert To String    ${COUNT}
        Should Be Equal    ${COUNT}    ${NUMBER}
    EXCEPT   
        Run Keyword And Continue On Failure    Fail     There is a error happen in process The number insurance of employee should be equal ${NUMBER}
    END

Click on the Add button in Insurance page
    TRY
        Click on the web element    ${ADDBUTTON_BTN_ELE} 
    EXCEPT    
        Run Keyword And Continue On Failure    Fail     There is a error happen in process Click on the Add button in Insurance page
    END
The New Insurance popup should be opened 
    TRY
        Page Should Contain Element    ${ADD_INSURANCE_POPUP}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail     There is a error happen in process The New Insurance popup should be opened 
    END
The Edit Insurance popup should be opened 
    TRY
        Page Should Contain Element    ${EDIT_INSURANCE_POPUP}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail     There is a error happen in process The New Insurance popup should be opened 
    END
Select Insurance in dropdown with '${NAME}' option 
    TRY
        Click on the web element    ${INSURANCETYPE}
        Click on the web element    css:[aria-label="${NAME}"]
    EXCEPT    
        Run Keyword And Continue On Failure    Fail     There is a error happen in process Select Insurance in dropdown with ${NAME} option 
    END
Input '${VALUE}' in the '${NAME}' field
    TRY
        @{LIST}=    Get list WebElements    ${LABLE_FORM_ELE} 
        FOR    ${element}    IN    @{LIST}
            ${TEXT}=    Get Text    ${element}
            IF    ('${NAME}'in'${TEXT}')
                @{LIST_ELE}=    Get list WebElements    ${INPUT_FIELD_ELE}
                IF    ('${NAME}'in'Issued By')
                    ${locator}=    Get From List    ${LIST_ELE}    3
                    Click on the web element    ${locator}
                    Input text to ${locator} with ${VALUE}
                    Exit For Loop
                ELSE
                    ${locator}=    Get From List    ${LIST_ELE}    0
                    Click on the web element    ${locator}
                    Input text to ${locator} with ${VALUE}
                    Exit For Loop
                END
            END  
        END
    EXCEPT   
        Run Keyword And Continue On Failure    Fail     There is a error happen in process Input '${VALUE}' in the '${NAME}' field
    END

Input '${VALUE}' in the '${NAME}' Date field
    TRY
        @{LIST}=    Get list WebElements    ${LABLE_FORM_ELE} 
        FOR    ${element}    IN    @{LIST}
            ${TEXT}=    Get Text    ${element}
            IF    ('${NAME}'in'${TEXT}')
                @{LIST_ELE}=    Get list WebElements    ${DATE_FIELD_ELE}
                IF    ('${NAME}' in'Valid to')
                    ${locator}=    Get From List    ${LIST_ELE}    1
                    Click on the web element    ${locator}
                    Input text to ${locator} with ${VALUE}
                    Exit For Loop
                ELSE
                    ${locator}=    Get From List    ${LIST_ELE}    0
                    Click on the web element    ${locator}
                    Input text to ${locator} with ${VALUE}
                    Exit For Loop
                END
            END  
        END
    EXCEPT   
        Run Keyword And Continue On Failure    Fail     There is a error happen in process Input '${VALUE}' in the '${NAME}' Date field
    END

Click on the Submit button 
    TRY
        Click on the web element    ${SUBMIT_BTN_ELE} 
    EXCEPT    
        Run Keyword And Continue On Failure    Fail     There is a error happen in process Click on the Submit button
    END 

The message "${MESSAGE}" should be display 
    TRY
        Wait Until Page Contains    ${MESSAGE}
        Page Should Contain    ${MESSAGE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail     There is a error happen in process The message "${MESSAGE}" should be display 
    END

Select sort option with 'Valid From' field 
    TRY
        Click on the web element    css:[sortcolumn="from"]
    EXCEPT    
        Run Keyword And Continue On Failure    Fail     There is a error happen in process Select sort option with 'Type' field 
    END
The list should be sort by From
    [Arguments]    ${FROM}
    Sleep    3s
    TRY
        @{COLUMNS}=    Get list WebElements    css:.p-datatable-thead tr th
        ${INDEX}=    Set Variable    1
        ${ROW_INDEX}=    Set Variable    1
        FOR    ${COLUMN}    IN    @{COLUMNS}
                ${TEXT}=    Get Text    ${COLUMN}
            IF    ('${TEXT}'=='Valid From')
                Exit For Loop
            END
            ${INDEX}=    Evaluate    ${INDEX}+1
        END
        @{ROWS}=    Get list WebElements    ${TABLE_ROWS}
        FOR    ${ROW}    IN    @{ROWS}
            ${locator_row}=    Set Variable    css=tbody tr:nth-child(${ROW_INDEX}) td:nth-child(${INDEX})
            ${textdata} =    Get Text     ${locator_row}
            Should Be Equal    ${textdata}    ${FROM}
            Exit For Loop
            ${ROW_INDEX}=    Evaluate    ${ROW_INDEX}+1
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail     There is a error happen in process The list should be sort by From
    END
Hover-over the download icon
    TRY
        Mouse Over    ${DOWLOAD_FILE} 
    EXCEPT    
        Run Keyword And Continue On Failure    Fail     There is a error happen in process Hover-over the download icon
    END
Click on the the download icon
    TRY
        Click on the web element    ${DOWLOAD_FILE} 
    EXCEPT    
        Run Keyword And Continue On Failure    Fail     There is a error happen in process Click on the the download icon
    END

Click on the Edit button on the a Insurance
    TRY
        @{LIST}=    Get list WebElements    ${TABLE_ROWS}  
        FOR    ${element}    IN    @{LIST}
            Mouse Over    ${element}
            Click on the web element    ${MENU_OPTION}
            ${LIST_OPTION}=    Get list WebElements    ${OPTIONS}
            ${EDIT_OPTION}=    Get From List    ${LIST_OPTION}   0
            Click on the web element    ${EDIT_OPTION}
            Exit For Loop
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail     There is a error happen in process Click on the Edit button on the a Insurance
    END

Update '${VALUE}' in the '${NAME}' field
    TRY
        @{LIST}=    Get list WebElements    ${LABLE_FORM_ELE} 
        FOR    ${element}    IN    @{LIST}
            ${TEXT}=    Get Text    ${element}
            IF    ('${NAME}'in'${TEXT}')
                @{LIST_ELE}=    Get list WebElements    ${INPUT_FIELD_ELE}
                IF    ('${NAME}'in'Issued By')
                    ${locator}=    Get From List    ${LIST_ELE}    3
                    Click on the web element    ${locator}
                    Clear Element Text    ${locator}
                    Input text to ${locator} with ${VALUE}
                    Exit For Loop
                ELSE
                    ${locator}=    Get From List    ${LIST_ELE}    0
                    Click on the web element    ${locator}
                    
                    Input text to ${locator} with ${VALUE}
                    Exit For Loop
                END
            END  
        END
    EXCEPT   
        Run Keyword And Continue On Failure    Fail     There is a error happen in process update '${VALUE}' in the '${NAME}' field
    END
The data should be new data
    [Arguments]    ${data}
    Sleep    3s
    TRY
        @{COLUMNS}=    Get list WebElements    css:.p-datatable-thead tr th
        ${INDEX}=    Set Variable    1
        ${ROW_INDEX}=    Set Variable    1
        FOR    ${COLUMN}    IN    @{COLUMNS}
                ${TEXT}=    Get Text    ${COLUMN}
            IF    ('${TEXT}'=='Issued By')
                Exit For Loop
            END
            ${INDEX}=    Evaluate    ${INDEX}+1
        END
        @{ROWS}=    Get list WebElements    ${TABLE_ROWS}
        FOR    ${ROW}    IN    @{ROWS}
            ${locator_row}=    Set Variable    css=tbody tr:nth-child(${ROW_INDEX}) td:nth-child(${INDEX})
            ${textdata} =    Get Text     ${locator_row}
            Should Be Equal    ${textdata}    ${data}
            Exit For Loop
            ${ROW_INDEX}=    Evaluate    ${ROW_INDEX}+1
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail     There is a error happen in process The data should be new data
    END
Click on the Delete button on the a Insurance
    TRY
        ${COUNT_BEFORE}=    The quantity insurance of employee
        Set Global Variable    ${COUNT_BEFORE}
        @{LIST}=    Get list WebElements    ${TABLE_ROWS}  
        FOR    ${element}    IN    @{LIST}
            Mouse Over    ${element}
            Click on the web element    ${MENU_OPTION}
            ${LIST_OPTION}=    Get list WebElements    ${OPTIONS}
            ${DELETE_OPTION}=    Get From List    ${LIST_OPTION}   1
            Click on the web element    ${DELETE_OPTION}
            Exit For Loop
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail     There is a error happen in process Click on the Delete button on the a Insurance
    END
Click on the OK button on the a Confirmation dialog
    TRY
        @{LIST}=    Get list WebElements    ${TABLE_ROWS}  
        FOR    ${element}    IN    @{LIST}
            Mouse Over    ${element}
            Click on the web element    ${MENU_OPTION}
            Click on the web element    css:.btn.btn-primary
            Exit For Loop
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail     There is a error happen in process Click on the OK button on the a Confirmation dialog
    END
The quantity insurance of employee 
    TRY
        @{LIST}=    Get list WebElements    ${INSURANCE_ITEM}  
        ${COUNT}=    Set Variable    0
        FOR    ${element}    IN    @{LIST}
            IF    ('${element}'!='')
                ${COUNT}=    Evaluate    ${COUNT}+1
            END
        END
        ${COUNT}=    Convert To String    ${COUNT}
        RETURN    ${COUNT}
    EXCEPT   
        Run Keyword And Continue On Failure    Fail     There is a error happen in process The quantity insurance of employee 
    END

The insurance should be no display 
    TRY
        Sleep    2s
        ${COUNT_AFTER}=    The quantity insurance of employee
        ${SUM}  Evaluate   ${COUNT_BEFORE}-${COUNT_AFTER}
        ${SUM}=    Convert To String    ${SUM}
        Should Be Equal    ${SUM}    1
    EXCEPT    
         Run Keyword And Continue On Failure    Fail     There is a error happen in process The insurance should be no display 
    END
Create Insurances No.
    [Documentation]       This keyword is used to Create Email
    TRY
        ${current_hour}=    Get Current Date    result_format=%H
        ${current_minute}=  Get Current Date    result_format=%M
        ${current_second}=  Get Current Date    result_format=%S
        ${unique_insurance}=    Set Variable   ${current_hour}${current_minute}${current_second}
        RETURN    ${unique_insurance}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process create Insurances No.   
    END 
    
Input on the "Insurance No." field with value created automatic
    TRY
        ${Insurances No.}=    Create Insurances No.
        Input '${Insurances No.}' in the 'Insurance No.' field
    EXCEPT    
        Run Keyword And Continue On Failure   FAIL    There is a error happen in process Input on the "Insurance No." field with value created automatic   
    END

