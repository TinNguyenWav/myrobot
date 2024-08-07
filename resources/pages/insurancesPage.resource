*** Settings ***
Resource    ../keywords/common_test_steps.resource
Resource    ../../configurations/config.resource
*** Variables ***
${CARD_TITLE_ELEMENT}    css:.card-title
${LOAD_ICON}            css:.p-element.p-icon-wrapper
${INSURANCE_ITEM}        css:.table-row
${INSURANCETYPE}        css:.w-100.p-dropdown.p-component.p-dropdown-clearable
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
        Click on the web element    css:.d-flex.insurance-container .edit-icon
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
Get ID field by lable ${name} in insurance page
    TRY
        ${xpath}=    Set Variable    //label[text()='${name}']/following-sibling::div[contains(@class, 'p-inputgroup')]//input
        ${element}=    Get WebElement    ${xpath}
        ${id}=    Call Method    ${element}    get_attribute    id
        RETURN    id:${id}
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is a error happen in process Get ID field by lable ${name} in register page    
    END
Input '${VALUE}' in the Insurance No. field
    TRY
        ${ID}=    Get element by partial id    prefix-input
        ${id_value}=    Get Element Attribute    ${ID}    type
        ${id_value}=    Get Value    ${ID}

        Input Text    ${ID}   ${VALUE}
    EXCEPT   
        Run Keyword And Continue On Failure    Fail     There is a error happen in process Input '${VALUE}' in the Insurance No. field
    END