*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../keywords/common_test_steps.resource

*** Variables ***
${SIDEBAR_sel}    css=frontend-sidebar
${MENU_ELE}        css:.fa.fa-bars
${SIDENAR_ELE}      id:sidebar
${SIDEBAR_ELE}        css:.submenu
${OPTION_SIDEBAR}    css:[routerlinkactive="active"]
*** Keywords ***
Select on the "${NAME}" option 
    TRY
        @{LIST}=    Get list WebElements    ${SIDEBAR_ELE}
        FOR    ${element}    IN    @{LIST}
            ${TEXT}=    Get Text    ${element}
            IF    ("${TEXT}" == "${NAME}")
                Click on the web element    ${element}
                Exit For Loop
            END
    END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There are happen in process Select on the "${NAME}" option 
    END

Select on the "${NAME}" from dropdown
    TRY
        @{LIST}=    Get list WebElements    ${OPTION_SIDEBAR}
        FOR    ${element}    IN    @{LIST}
            ${TEXT}=    Get Text    ${element}
            IF    ("${TEXT}" == "${NAME}")
                Click on the web element    ${element}
                Exit For Loop
            END
    END
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    There are happen in process Select on the "${NAME}" option 
    END
