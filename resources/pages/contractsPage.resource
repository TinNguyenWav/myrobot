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
${SEARCH_IP_ELE}    css=input[class="p-dropdown-filter p-inputtext p-component"]
*** Keywords ***
# ------------ACTION--------------
Click on the Add Contract button
    Click Element    ${ADDCONTRACT_BTN_ELE}
Click on the Submit button
    Click Element    ${SUBMIT_BTN_ELE}
Click on the Edit Contract button
    Wait Until Element Is Enabled    ${EDIT_BTN_ELE}
    Click Element    ${EDIT_BTN_ELE}
Select a option for the Contract Type dropdown field
    [Arguments]    ${option}
    Click Element    ${CONTRACT_TYPE_FIELD_ELE}
    Input text to ${SEARCH_IP_ELE} with ${option}
    Sleep    2s
    Click Element    css=li[aria-label="${option}"]
Input value for the Contract Number field
    ${value}    Get Current Date    result_format=%H%M%S
    Sleep    2s
    Input text to ${CONTRACT_NUMBER_FIELD_ELE} with ${value}
Input value for the Valid From field
    [Arguments]    ${value}
    Input text to ${VALID_FROM_FIELD_ELE} with ${value}
    Click Element    xpath=//h4[contains(text(), 'Add Contract')]
Input value for the Valid To field
    [Arguments]    ${value}
    Input text to ${VALID_TO_FIELD_ELD} with ${value}
    Click Element    xpath=//h4[contains(text(), 'Add Contract')]

Upload field for Upload File field
    [Arguments]    ${file_path}
    Choose File    ${UPLOAD_FILE_FIELD_ELE}    ${file_path}

# ------------BEHAVIOR------------
Enter all required field
    Select a option for the Contract Type dropdown field    Probation
    ${value}    Get Current Date    result_format=%H%M%S
    Sleep    2
    Input text to ${CONTRACT_NUMBER_FIELD_ELE} with ${value}
    Input value for the Valid From field    08/07/2024
    Set Global Variable    ${value}
Click on the Pencil icon next to the contract name
    Sleep    1s
    ${contracts_lst}=    Get WebElements    css=ul[class="experience-list"]>li
    ${contracts_lst_length}=    Get Length    ${contracts_lst}
    Run Keyword If    ${contracts_lst_length} > 0
    ...    Click on the Edit Contract button

# ------------EXPECTED------------
The error message shouldn't be display below the Valid To field
    ${stt}    Run Keyword And Return Status    Page Should Not Contain    Valid To must be equal or greater than Valid From
    Pass Execution If    "${stt}"==True    Success
The warning message " Valid To must be equal or greater than Valid From" should be display below the Valid To field
    ${stt}    Run Keyword And Return Status    Page Should Contain    Valid To must be equal or greater than Valid From
    Pass Execution If    "${stt}"==True    Success
The system should showed as Present on Contract Information card
    ${present_value_txt}=    Get Text    css=ul[class="experience-list"]>li div[class="timeline-content"]>a[title*="${value}"]+div[class="text-ellipsis"]    
    ${stt}    Run Keyword And Return Status    Should Contain    ${present_value_txt}    Present
    Pass Execution If    "${stt}"==True    Success
The contract should be edited success
    Sleep    1s
    Page Should Contain Element    css=div[class="toast-body"]
