*** Settings ***
Resource    ../keywords/common_test_steps.resource
Resource    ../../configurations/config.resource
*** Variables ***
${CARD_TITLE_ELEMENT}       css:.card-title
${LOAD_ICON}                css:.p-element.p-icon-wrapper
${INSURANCE_ITEM}           css:.table-row
${INSURANCETYPE}            css:.w-100.p-dropdown.p-component.p-dropdown-clearable
${LABLE_FORM_ELE}           css:.form-label.ng-star-inserted
${INPUT_FIELD_ELE}          css:.p-inputtext.p-component.p-element.form-control.input-control.ng-untouched.ng-pristine.ng-valid
${ADDBUTTON_BTN_ELE}        css:.d-flex.insurance-container .edit-icon
${DATE_FIELD_ELE}           css:.form-control.p-inputtext.p-component.ng-star-inserted
${SUBMIT_BTN_ELE}           css:.submit-section
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
        Page Should Contain Element    css:.modal-content
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

Select sort option with 'Type' field 
    TRY
        Click on the web element    css:[sortcolumn="insuranceType"]
    EXCEPT    
        Run Keyword And Continue On Failure    Fail     There is a error happen in process Select sort option with 'Type' field 
    END

Hover-over the download icon
    TRY
        Mouse Over    css:a[href="https://api-uat.wsvhrm.com/api/AssetFile/load/4290433e-f36b-1410-8de1-00e198c9d750"]
    EXCEPT    
        Run Keyword And Continue On Failure    Fail     There is a error happen in process Hover-over the download icon
    END
Click on the the download icon
    TRY
        Click on the web element    css:a[href="https://api-uat.wsvhrm.com/api/AssetFile/load/4290433e-f36b-1410-8de1-00e198c9d750"]
    EXCEPT    
        Run Keyword And Continue On Failure    Fail     There is a error happen in process Click on the the download icon
    END