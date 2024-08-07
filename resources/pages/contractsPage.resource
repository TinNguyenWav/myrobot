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
${EDIT_BTN_ELE}    
${SEARCH_IP_ELE}    css=input[class="p-dropdown-filter p-inputtext p-component"]
*** Keywords ***
# ------------ACTION--------------
Click on the Add Contract button
    Click Element    ${ADDCONTRACT_BTN_ELE}
Click on the Submit button
    Click Element    ${SUBMIT_BTN_ELE}
Click on the Edit Contract button
    Click on the web element    ${EDIT_BTN_ELE}
Select a option for the Contract Type dropdown field
    [Arguments]    ${option}
    Click Element    ${CONTRACT_TYPE_FIELD_ELE}
    Input text to ${SEARCH_IP_ELE} with ${option}
    Sleep    2s
    Click Element    css=li[aria-label="${option}"]
Input value for the Contract Number field
    ${value}    Get Current Date    result_format=%H%M%S
    Sleep    2
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
# ------------EXPECTED------------
The error message shouldn't be display below the Valid To field
    ${stt}    Run Keyword And Return Status    Page Should Not Contain    Valid To must be equal or greater than Valid From
    Pass Execution If    "${stt}"==True    Success
