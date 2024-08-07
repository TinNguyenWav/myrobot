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
    Click on the web element    ${PROJECTTAB_ELE} 
Select the Contracts item
    # Click on the web element    ${CONTRACTSTAB_ELE}
    command.Wait until element is Visible    ${CONTRACTSTAB_ELE}
    Click Element    ${CONTRACTSTAB_ELE}
Select the Insurances item
    Click on the web element    ${INSURANCESTAB_ELE}
# -----------BEHAVIOR-----------
Open the Project and Report Line tab
    Select the Project and Report item
    Expect webelement contains text    ${PROJECTTAB_TITLE_ELE}    Project(s)
Open the Contracts tab
    Select the Contracts item
Open the Insurances tab
    Select the Insurances item
    Expect webelement contains text    ${INSURANCESTAB_TITLE_ELE}    Insurance Information
# ------------EXPECTED RESULT-----------
The Contract tab should appear
    Expect webelement contains text    ${CONTRACTSTAB_TITLE_ELE}    Contract Information
All contracts of employees should manager on the Contract card
    ${contract_list}=    Get WebElements    css=div[class="experience-box"]>ul[class="experience-list"]>li[class="ng-star-inserted"]
    ${contract_list_length}=    Get Length    ${contract_list}
    Pass Execution If    ${contract_list_length} > 0    Success
All employee contract should be showed on Contract Information card
    Expect webelement contains text    ${CONTRACTSTAB_TITLE_ELE}    Contract Information
    ${contract_list}=    Get WebElements    css=div[class="experience-box"]>ul[class="experience-list"]>li[class="ng-star-inserted"]
    ${contract_list_length}=    Get Length    ${contract_list}
    Pass Execution If    ${contract_list_length} > 0    Success
