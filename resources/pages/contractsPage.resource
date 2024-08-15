*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../keywords/command.resource
Library    XML

*** Variables ***
${ADDCONTRACT_BTN_ELE}    css=a[class="edit-icon ng-star-inserted"]
${SUBMIT_BTN_ELE}    xpath=//button[contains(text(),"Submit")]
${CONTRACT_TYPE_FIELD_ELE}    css=div[class="p-dropdown-trigger"]
${CONTRACT_NUMBER_FIELD_ELE}    css=input-text[id*="_contractNumber_1"] input
${VALID_FROM_FIELD_ELE}    css=datetime-picker[id*="_validFrom_2"] input
${VALID_TO_FIELD_ELD}    css=datetime-picker[id*="_validTo_3"] input
${UPLOAD_FILE_FIELD_ELE}
${EDIT_BTN_ELE}    css=ul[class="experience-list"]>li:first-child a[class*="edit-icon"]
${DELETE_BTN_ELE}    css=ul[class="experience-list"]>li:first-child a[class*="edit-icon"]>i[class="fa fa-trash"]
${SEARCH_IP_ELE}    css=input[class="p-dropdown-filter p-inputtext p-component"]
${CONTRACT_LIST_ELE}    css=ul[class="experience-list"]>li
${ADD_CONTRACT_TITLE}    xpath=//h4[contains(text(), 'Add Contract')]
${OK_BTN_ELE}    xpath=//button[contains(@type,"button") and text()='OK']
*** Keywords ***
# ------------ACTION--------------
Click on the Add Contract button
    TRY
        Wait Until Element Is Enabled    ${ADDCONTRACT_BTN_ELE}
        Click Element    ${ADDCONTRACT_BTN_ELE}
        
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Can not clicking on the Add Contract button
    END
Click on the Submit button at the Contract
    TRY
        Wait Until Element Is Enabled    ${SUBMIT_BTN_ELE}
        Click Element    ${SUBMIT_BTN_ELE}
        ${check}=    Run Keyword And Return Status    Page Should Contain     The contract time is overlapped with existing contract. Still want to save it?
        IF    ${check}
            Click Element    ${OK_BTN_ELE}
        END

    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Can not clicking on the Submit button
    END

Click on the Edit Contract button
    TRY
        Wait Until Element Is Enabled    ${EDIT_BTN_ELE}
        Click Element    ${EDIT_BTN_ELE}
        
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Can not clicking on the Edit Contract button
    END

Select a option for the Contract Type dropdown field
    [Arguments]    ${option}
    TRY
        Click Element    ${CONTRACT_TYPE_FIELD_ELE}
        Input text to ${SEARCH_IP_ELE} with ${option}
        Sleep    2s
        Click Element    css=li[aria-label="${option}"]
        
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Can not select the ${option} on the Contract Type dropdown field
    END

Input value for the Contract Number field
    TRY
        ${value}    Get Current Date    result_format=%H%M%S%Y%m%d
        Sleep    2s
        Input text to ${CONTRACT_NUMBER_FIELD_ELE} with ${value}
        
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Can not input value for the Contract Number field
    END

Input value for the Valid From field
    [Arguments]    ${value}=${None}
    TRY
        IF    ${value} == ${None}
            ${from_date}=    Get Current Date    result_format=%m/%d/%Y
            ${value}=    Set Variable    ${from_date}
        END
        Input text to ${VALID_FROM_FIELD_ELE} with ${value}
        Click Element    ${ADD_CONTRACT_TITLE}
        
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Can not input value for the Valid From field
    END

Input value for the Valid To field
    [Arguments]    ${value}=${None}
    TRY
        IF    ${value} == ${None}
            ${month_day}=    Get Current Date    result_format=%m/%d
            ${year}=    Get Current Date    result_format=%Y
            ${year}=    Evaluate    ${year}+1
            ${date}=    Set Variable    ${month_day}/${year}
            ${value}=    Set Variable    ${date}
        ELSE IF    "${value}" == MM/DD/YYYY
            ${date}=    Get Current Date    result_format=%m/%d/%Y
            ${value}=    Set Variable    ${date}      
        ELSE 
            ${month}=    Get Current Date    result_format=%m
            ${day}=    Get Current Date    result_format=%d
            ${year}=    Get Current Date    result_format=%Y
            IF    ${day} <= 31 AND ${day} > 1
                ${day}=    Evaluate    ${day}-1
                ${date}=    Set Variable    ${month}/${day}/${year}
            ELSE IF    ${day} == 1 AND ${month} == 12
                ${day}=    Evaluate    ${day}-1
                ${month}=    Evaluate    1
                ${date}=    Set Variable    ${month}/${day}/${year}
                
            END
            ${year}=    Evaluate    ${year}+1
            ${date}=    Set Variable    ${month_day}/${year}
            ${value}=    Set Variable    ${date}
                 
        END
        Input text to ${VALID_TO_FIELD_ELD} with ${value}
        Click Element    ${ADD_CONTRACT_TITLE}
        
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Can not input value for the Valid To field
    END

Upload field for Upload File field
    [Arguments]    ${file_path}
    Choose File    ${UPLOAD_FILE_FIELD_ELE}    ${file_path}

# ------------BEHAVIOR------------
Enter all required field
    TRY
        Select a option for the Contract Type dropdown field    Probation
        ${value}    Get Current Date    result_format=%H%M%S%Y%m%d
        Sleep    2
        Input text to ${CONTRACT_NUMBER_FIELD_ELE} with ${value}
        Input value for the Valid From field
        Set Global Variable    ${value}
        
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Can not enter one in all required field on the Contract 
    END

Click on the Pencil icon next to the contract name
    TRY
        Sleep    1s
        ${contracts_lst}=    Get WebElements    ${CONTRACT_LIST_ELE}
        ${contracts_lst_length}=    Get Length    ${contracts_lst}
        Run Keyword If    ${contracts_lst_length} > 0
        ...    Click on the Edit Contract button
        
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Can not clicking on the Pencil icon next to the contract name
    END
Click on the Delete button next to the contract name
    TRY
        Sleep    1s
        ${contracts_lst}=    Get WebElements    ${CONTRACT_LIST_ELE}
        ${contracts_lst_length}=    Get Length    ${contracts_lst}
        IF    ${contracts_lst_length} > 0
            Wait Until Element Is Enabled    ${DELETE_BTN_ELE}
            Click Element    ${DELETE_BTN_ELE}
        ELSE
            Log    Employee doesn't have any contract on Contracts tab 
        END
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Can not click on the Delete button next to the contract name
    END
Click on the OK button
    TRY
        Wait Until Element Is Enabled    ${OK_BTN_ELE}
        Click Element    ${OK_BTN_ELE}
    EXCEPT    message
        Run Keyword And Continue On Failure    Fail    Can not click on the OK button
    END
# ------------EXPECTED------------
The error message shouldn't be display below the Valid To field
    TRY
        ${stt}    Run Keyword And Return Status    Page Should Not Contain    Valid To must be equal or greater than Valid From
        Pass Execution If    "${stt}"==True    Success        
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    The error message displayed below the Valid To field
    END

The warning message " Valid To must be equal or greater than Valid From" should be display below the Valid To field
    TRY
        ${stt}    Run Keyword And Return Status    Page Should Contain    Valid To must be equal or greater than Valid From
        Pass Execution If    "${stt}"==True    Success
        
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    The warning message didn't display below the Valid To field
    END

The system should showed as Present on Contract Information card
    TRY
        ${present_value_txt}=    Get Text    css=ul[class="experience-list"]>li div[class="timeline-content"]>a[title*="${value}"]+div[class="text-ellipsis"]    
        ${stt}    Run Keyword And Return Status    Should Contain    ${present_value_txt}    Present
        Pass Execution If    "${stt}"==True    Success
        
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    The system did not show as Present on Contract Information card
    END

The contract should be edited success
    TRY
        Sleep    1s
        Page Should Contain Element    css=div[class="toast-body"]
        
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Can not edit the contract
    END
The contract should be added success
    TRY
        Sleep    1s
        Page Should Contain    Contract was Created successfully
        
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Can not edit the contract
    END
The contract should be removed from the list
    TRY
        Page Should Contain    text
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Failed to remove the contract
    END
