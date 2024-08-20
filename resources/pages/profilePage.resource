*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../keywords/command.resource
*** Variables ***
${PROJECTTAB_ELE}    
${PROJECTTAB_TITLE_ELE}    
${CONTRACTSTAB_ELE}        css=a[aria-label="Contracts"]
${CONTRACTSTAB_TITLE_ELE}    css=frontend-contract-info[class="ng-star-inserted"]
${INSURANCESTAB_ELE}    
${INSURANCESTAB_TITLE_ELE}    
*** Keywords ***
# -----------ACTION-------------
Select the Project and Report item
    TRY
        Click on the web element    ${PROJECTTAB_ELE}         
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Can not select the Project and Report item
    END

Select the Contracts item
    TRY
        Wait Until Element Is Enabled    ${CONTRACTSTAB_ELE}
        Click Element    ${CONTRACTSTAB_ELE}        
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Can not select the Contracts item
    END

Select the Insurances item
    TRY
        Click on the web element    ${INSURANCESTAB_ELE}        
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Can not select the Insurances item
    END




# -----------BEHAVIOR-----------
Open the Project and Report Line tab
    TRY
        Select the Project and Report item
        Expect webelement contains text    ${PROJECTTAB_TITLE_ELE}    Project(s)        
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Can not open the Project and Report Line tab
    END

Open the Contracts tab
    TRY
        Select the Contracts item    
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Can not open the Contracts tab
    END

Open the Insurances tab
    TRY
        Select the Insurances item
        Expect webelement contains text    ${INSURANCESTAB_TITLE_ELE}    Insurance Information        
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    Can not open the Insurance tab
    END





# ------------EXPECTED RESULT-----------
The Contract tab should appear
    TRY
        Expect webelement contains text    ${CONTRACTSTAB_TITLE_ELE}    Contract Information    
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    The Contract tab did not appear
    END

All contracts of employees should manager on the Contract card
    TRY
        ${contract_list}=    Get WebElements    css=div[class="experience-box"]>ul[class="experience-list"]>li[class="ng-star-inserted"]
        ${contract_list_length}=    Get Length    ${contract_list}
        Pass Execution If    ${contract_list_length} > 0    Success        
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There isn't any contract that manager on the Contract card
    END

All employee contract should be showed on Contract Information card
    TRY
        Expect webelement contains text    ${CONTRACTSTAB_TITLE_ELE}    Contract Information
        ${contract_list}=    Get WebElements    css=div[class="experience-box"]>ul[class="experience-list"]>li[class="ng-star-inserted"]
        ${contract_list_length}=    Get Length    ${contract_list}
        Pass Execution If    ${contract_list_length} > 0    Success        
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There is not any contract show on Contract Information card
    END

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
    