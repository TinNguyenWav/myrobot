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
${INPUT_FIELD_ELE}          css:.p-inputtext.p-component.p-element.form-control.input-control.ng-untouched.ng-pristine.ng-valid
${ADDBUTTON_BTN_ELE}        css:.d-flex.insurance-container .edit-icon
${DATE_FIELD_ELE}           css:.form-control.p-inputtext.p-component.ng-star-inserted
${SUBMIT_BTN_ELE}           css:.submit-section
${ADD_INSURANCE_POPUP}      css:.modal-content
${EDIT_INSURANCE_POPUP}     css:.modal-header
${MENU_OPTION}              css:.material-icons
${EDIT_OPTION}              css:.dropdown-item.ng-star-inserted
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
                    ${locator}=    Get From List    ${LIST_ELE}    0
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
    TRY
        @{COLUMNS}=    Get list WebElements    css:.p-datatable-thead tr th
        ${INDEX}=    Set Variable    0
        ${ROW_INDEX}=    Set Variable    0
        FOR    ${COLUMN}    IN    @{COLUMNS}
                ${TEXT}=    Get Text    ${COLUMN}
            IF    ('${TEXT}'=='Valid From')
                Exit For Loop
            END
            ${INDEX}=    Evaluate    ${INDEX}+1
        END
        @{ROWS}=    Get list WebElements    ${TABLE_ROWS}
        FOR    ${ROW}    IN    @{ROWS}
            ${parent}=    Get WebElements    ${TABLE_ROWS}
            # ${index_base}=    Get WebElement    ${parent}[${ROW_INDEX}]
            
            ${locator_row}=    Set Variable    ${parent}[${ROW_INDEX}]
            

            

            ${child}=    Get WebElements    css=${locator_row} tr td
            ${textdata} =    Get Text     ${child}[${INDEX}]
            Log    ${textdata}

            ${ROW_INDEX}=    Evaluate    ${ROW_INDEX}+1
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail     There is a error happen in process The list should be sort by From
    END
Hover-over the download icon
    TRY
        Mouse Over    css:a[href="https://api-uat.wsvhrm.com/api/AssetFile/load/cd38453e-f36b-1410-8dec-00e198c9d750"]
    EXCEPT    
        Run Keyword And Continue On Failure    Fail     There is a error happen in process Hover-over the download icon
    END
Click on the the download icon
    TRY
        Click on the web element    css:a[href="https://api-uat.wsvhrm.com/api/AssetFile/load/cd38453e-f36b-1410-8dec-00e198c9d750"]
    EXCEPT    
        Run Keyword And Continue On Failure    Fail     There is a error happen in process Click on the the download icon
    END

Click on the Edit button on the a Insurance
    TRY
        @{LIST}=    Get list WebElements    ${TABLE_ROWS}  
        FOR    ${element}    IN    @{LIST}
            Mouse Over    ${element}
            Click on the web element    ${MENU_OPTION}
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
                    ${locator}=    Get From List    ${LIST_ELE}    0
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
