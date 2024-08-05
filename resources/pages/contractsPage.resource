*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../keywords/command.resource

*** Variables ***
${ADDCONTRACT_BTN_ELE}    
${SUBMIT_BTN_ELE}    
${CONTRACT_TYPE_FIELD_ELE}
${CONTRACT_NUMBER_FIELD_ELE}
${VALID_FROM_FIELD_ELE}
${VALID_TO_FIELD_ELD}
${UPLOAD_FILE_FIELD_ELE}
${EDIT_BTN_ELE}    
*** Keywords ***
# ------------ACTION--------------
Click on the Add Contract button
    Click on the web element    ${ADDCONTRACT_BTN_ELE}
Click on the Submit button
    Click on the web element    ${SUBMIT_BTN_ELE}
Click on the Edit Contract button
    Click on the web element    ${EDIT_BTN_ELE}
Select a option for the Contract Type dropdown field
    [Arguments]    ${option}
    Input text to ${CONTRACT_TYPE_FIELD_ELE} with ${option}
    Select option in dropdown menu    ${CONTRACT_TYPE_FIELD_ELE}    ${option}
Input value for the Contract Number field
    [Arguments]    ${value}
    Input text to ${CONTRACT_NUMBER_FIELD_ELE} with ${value}
Input value for the Valid From field
    [Arguments]    ${value}
    Input text to ${VALID_FROM_FIELD_ELE} with ${value}
Input value for the Valid To field
    [Arguments]    ${value}
    Input text to ${VALID_TO_FIELD_ELD} with ${value}
Upload field for Upload File field
    [Arguments]    ${file_path}
    Choose File    ${UPLOAD_FILE_FIELD_ELE}    ${file_path}

# ------------BEHAVIOR------------
