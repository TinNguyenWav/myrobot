*** Settings ***
Resource    ../keywords/common_test_steps.resource
Resource    ../../configurations/config.resource
Resource    insurancesPage.resource
*** Variables ***
${DEPENDENT_ITEM}                 css:.p-element.p-datatable-tbody tr
${ADD_BUTTON_ELE}                css:.fa.fa-plus
${EDIT_ICON_ELE}                css:h3.card-title .edit-icon
${CARD_TITLE_ELE}                css:h3.card-title
${ADD_DEPENDENT_POPUP}            css:.modal-title.pull-left
${MENU_ACTION}                    css:.table-actions.dropdown
${LIST_ACTION}                    css:.dropdown-item.ng-star-inserted
*** Keywords ***
The Denpendent tab should be display 
    TRY
        ${LIST_TITLE}=    Get list WebElements    ${CARD_TITLE_ELEMENT}
        FOR    ${element}    IN    @{LIST_TITLE}
            ${TITLE}=    Get Text    ${element}
            IF   ('${TITLE}'=="Dependent Information")
                Exit For Loop
            END
            
        END
    EXCEPT   
        Run Keyword And Continue On Failure    Fail     There is a error happen in process The Denpendent page should be opened 
    END
The number Dependent of employee should be equal '${NUMBER}'
    TRY
        Sleep    2S
        @{LIST}=    Get list WebElements    ${DEPENDENT_ITEM}  
        ${COUNT}=    Set Variable    0
        FOR    ${element}    IN    @{LIST}
            IF    ('${element}'!='')
                ${COUNT}=    Evaluate    ${COUNT}+1
            END
        END
        ${COUNT}=    Convert To String    ${COUNT}
        Should Be Equal    ${COUNT}    ${NUMBER}
    EXCEPT   
        Run Keyword And Continue On Failure    Fail     There is a error happen in process The number of employee should be equal ${NUMBER}
    END

Click on Edit icon '${cardName}'
    TRY
        @{LIST_ICON} =    Get list WebElements    ${EDIT_ICON_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{LIST_ICON}
            @{LIST_CARD_TITLE}=     Get list WebElements    ${CARD_TITLE_ELE}
            ${CURRENT_ELE}=    Get From List    ${LIST_CARD_TITLE}    ${INDEX}
            ${TITLE}=    Get Text    ${CURRENT_ELE}
            IF    ('${TITLE}' == '${CARDNAME}')
                Click on the web element    ${element}
            ELSE
                ${INDEX}=    Evaluate    ${INDEX}+1
            END
        END
    EXCEPT   
        Run Keyword And Continue On Failure    Fail     There is a error happen in process Click on Edit icon '${CARDNAME}'
    END
The New Add Dependent popup should be opened 
    TRY
        Page Should Contain Element    ${ADD_DEPENDENT_POPUP}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail     There is a error happen in process The New Add Dependent popup should be opened 
    END
Input '${VALUE}' in the '${NAME}' field in the Add Dependent popup 
    ${LIST_LABLE_ADD}=    Set Variable    css:.form-label.ng-star-inserted 
    ${LIST_FIELD}=    Set Variable    css:.p-inputtext.p-component
    TRY
        @{LIST_TITLE}=    Get list WebElements    ${LIST_LABLE_ADD}
        FOR    ${element}    IN    @{LIST_TITLE}
            ${LABLE}=    Get Text    ${element}
            @{LIST_INPUT}=    Get list WebElements    ${LIST_FIELD}
            IF    ('Name'in'${LABLE}' and '${NAME}'in'${LABLE}')  
                ${ELEMENT_INPUT}=    Get From List    ${LIST_INPUT}   0
                Clear Element Text    ${ELEMENT_INPUT}
                Sleep    1s
                Input text to ${ELEMENT_INPUT} with ${VALUE}
                Exit For Loop
            ELSE IF    ('Date of Birth'in'${LABLE}'and '${NAME}'in'${LABLE}')  
                ${ELEMENT_INPUT}=    Get From List    ${LIST_INPUT}   1
                Clear Element Text    ${ELEMENT_INPUT}
                Sleep    1s
                Input text to ${ELEMENT_INPUT} with ${VALUE}
                Exit For Loop
            ELSE IF    ('Tax Id No.'in'${LABLE}'and '${NAME}'in'${LABLE}')  
                ${ELEMENT_INPUT}=    Get From List    ${LIST_INPUT}   2
                Clear Element Text    ${ELEMENT_INPUT}
                Sleep    1s
                Click on the web element    ${ELEMENT_INPUT}
                Input text to ${ELEMENT_INPUT} with ${VALUE}
                Exit For Loop
            END
        END

    EXCEPT
        Run Keyword And Continue On Failure    Fail     There is a error happen in process Input '${VALUE}' in the '${NAME}' field
    END
Select Relationship in dropdown with '${NAME}' option
    ${DROPDOWN_RELATIONSHIP}=    Set Variable     css:.p-dropdown-trigger
    ${REALTIONSHIP_NAME}=    Set Variable    css:[aria-label="${NAME}"]
    TRY
        Click on the web element    ${DROPDOWN_RELATIONSHIP}
        Click on the web element    ${REALTIONSHIP_NAME}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail     There is a error happen in process Select Relationship in dropdown with ${NAME} option 
    END
Click on the Submit button in the Dependent popup
    ${SUBMIT_BTN}=    Set Variable    css:.btn.btn-primary.submit-btn
    TRY
        Click on the web element    ${SUBMIT_BTN}
    EXCEPT   
        Run Keyword And Continue On Failure    Fail     There is a error happen in process Click on the Submit button
    END
Click on the Delete button on the a Dependent
    TRY
        ${COUNT_BEFORE}=    The quantity of employee
        Set Global Variable    ${COUNT_BEFORE}
        @{LIST}=    Get list WebElements    ${DEPENDENT_ITEM}  
        FOR    ${element}    IN    @{LIST}
            Mouse Over    ${element}
            Click on the web element    ${MENU_ACTION} 
            ${LIST_OPTION}=    Get list WebElements    ${LIST_ACTION}
            ${DELETE_OPTION}=    Get From List    ${LIST_OPTION}   1
            Click on the web element    ${DELETE_OPTION}
            Exit For Loop
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail     There is a error happen in process Click on the Delete button on the a Dependent
    END
Click on OK button to Confirmation delete Dependent in the Confirmation dialog
    ${OK_BTN_ELE}=    Set Variable    css:.btn.btn-primary
    TRY
        Click on the web element    ${OK_BTN_ELE}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail     There is a error happen in process Click on the Delete button on the a Dependent
    END
The quantity of employee 
    TRY
        @{LIST}=    Get list WebElements    ${DEPENDENT_ITEM} 
        ${COUNT}=    Set Variable    0
        FOR    ${element}    IN    @{LIST}
            IF    ('${element}'!='')
                ${COUNT}=    Evaluate    ${COUNT}+1
            END
        END
        ${COUNT}=    Convert To String    ${COUNT}
        RETURN    ${COUNT}
    EXCEPT   
        Run Keyword And Continue On Failure    Fail     There is a error happen in process The quantity of employee 
    END

The Dependent deleted should be no display 
    TRY
        Sleep    2s
        ${COUNT_AFTER}=    The quantity of employee
        ${SUM}  Evaluate   ${COUNT_BEFORE}-${COUNT_AFTER}
        ${SUM}=    Convert To String    ${SUM}
        Should Be Equal    ${SUM}    1
    EXCEPT    
         Run Keyword And Continue On Failure    Fail     There is a error happen in process The should be no display 
    END
Click on the Edit button on the a Dependent
    TRY
        ${COUNT_BEFORE}=    The quantity of employee
        Set Global Variable    ${COUNT_BEFORE}
        @{LIST}=    Get list WebElements    ${DEPENDENT_ITEM}  
        FOR    ${element}    IN    @{LIST}
            Mouse Over    ${element}
            Click on the web element    ${MENU_ACTION} 
            ${LIST_OPTION}=    Get list WebElements    ${LIST_ACTION}
            ${DELETE_OPTION}=    Get From List    ${LIST_OPTION}   0
            Click on the web element    ${DELETE_OPTION}
            Exit For Loop
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail     There is a error happen in process Click on the Edit button on the a Dependent
    END
The Edit Dependent popup should be opened 
    ${EDIT_DEPENDENT_POPUP}=    Set Variable    css:.modal-header
    TRY
        Page Should Contain Element    ${EDIT_DEPENDENT_POPUP}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail     There is a error happen in process The Edit Dependent popup should be opened 
    END
Update '${VALUE}' in the '${NAME}' field in the Add Dependent popup 
    TRY
       Input '${VALUE}' in the '${NAME}' field in the Add Dependent popup
    EXCEPT
        Run Keyword And Continue On Failure    Fail     There is a error happen in process Update '${VALUE}' in the '${NAME}' field
    END
The data should be new data of Dependent
    [Arguments]    ${DATA}
    ${LIST_TITLECOLUMN}=    Set Variable    css:.p-datatable-thead tr th
    Sleep    3s
    TRY
        @{COLUMNS}=    Get list WebElements    ${LIST_TITLECOLUMN}
        ${INDEX}=    Set Variable    1
        ${ROW_INDEX}=    Set Variable    1
        FOR    ${COLUMN}    IN    @{COLUMNS}
                ${TEXT}=    Get Text    ${COLUMN}
            IF    ('${TEXT}'=='Name')
                Exit For Loop
            END
            ${INDEX}=    Evaluate    ${INDEX}+1
        END
        @{ROWS}=    Get list WebElements    ${DEPENDENT_ITEM}
        FOR    ${ROW}    IN    @{ROWS}
            ${LOCATOR_ROW}=    Set Variable    css=tbody tr:nth-child(${ROW_INDEX}) td:nth-child(${INDEX})
            ${TEXTDATA} =    Get Text     ${LOCATOR_ROW}
            Should Be Equal    ${TEXTDATA}    ${DATA}
            Exit For Loop
            ${ROW_INDEX}=    Evaluate    ${ROW_INDEX}+1
        END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail     There is a error happen in process The data should be new data
    END