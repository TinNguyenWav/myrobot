*** Settings ***
Resource    ../keywords/common_test_steps.resource
Resource    ../../configurations/config.resource
*** Variables ***

*** Keywords ***
The Insurances page should be opened 
    TRY
        # Wait Until Element Is Visible    css:.p-element p-icon-wrapper
        # Wait Until Element Is Not Visible    css:.p-element p-icon-wrapper
        Wait Until Page Contains Element    ${PAGE_TITLE_ELEMENT}
        Element Should Contain    ${PAGE_TITLE_ELEMENT}    Insurance Information
    EXCEPT   
        Run Keyword And Continue On Failure    Fail     There is a error happen in process The Insurances page should be opened 
    END
