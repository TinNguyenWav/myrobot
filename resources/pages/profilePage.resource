*** Settings ***
Resource    ../keywords/common_test_steps.resource
Resource    ../../configurations/config.resource
*** Variables ***
${URL_PROFILE}        /app/employee-profile
${INSURANCE_OPTION}    css:[aria-label="Insurances"]
*** Keywords ***
Profile page should be opened
    TRY
        Wait Until Page Contains    Personal Information
        ${current URL}=    Get Location
        Should Contain    ${current URL}    ${URL_PROFILE}
        Wait Until Page Contains Element    ${PAGE_TITLE_ELEMENT}
        Element Should Contain    ${PAGE_TITLE_ELEMENT}    Profile
    EXCEPT   
        Run Keyword And Continue On Failure    Fail     There is a error happen in process Profile page should be opened
    END

Select the Insurances option 
    TRY
        Click on the web element    ${INSURANCE_OPTION} 
    EXCEPT    
        Run Keyword And Continue On Failure    Fail     There is a error happen in process Select the Insurances option 
    END
    