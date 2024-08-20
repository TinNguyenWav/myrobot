*** Settings ***
Resource    ../keywords/common_test_steps.resource
Resource    ../../configurations/config.resource
Resource    insurancesPage.resource
*** Variables ***
${DEPENDENT_ITEM}                 css:.p-element.p-datatable-tbody tr
${ADD_BUTTON_ELE}                css:.fa.fa-plus
${EDIT_ICON_ELE}                css:h3.card-title .edit-icon
${CARD_TITLE_ELE}                css:h3.card-title
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
        Run Keyword And Continue On Failure    Fail     There is a error happen in process The number insurance of employee should be equal ${NUMBER}
    END

Click on edit icon '${cardName}'
    TRY
        @{list_icon} =    Get list WebElements    ${EDIT_ICON_ELE}
        ${INDEX}=    Set Variable    0
        FOR    ${element}    IN    @{list_icon}
            @{list_card_title}=     Get list WebElements    ${CARD_TITLE_ELE}
            ${current_ele}=    Get From List    ${list_card_title}    ${INDEX}
            ${title}=    Get Text    ${current_ele}
            IF    ('${title}' == '${cardName}')
                Log    ${element}
                Click on the web element    ${element}
            ELSE
                ${INDEX}=    Evaluate    ${INDEX}+1
            END
            Log    ${element}
            
        END
    EXCEPT    message
       Log    message
    END