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
