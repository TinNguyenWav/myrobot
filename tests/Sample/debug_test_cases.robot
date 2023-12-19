*** Settings ***
Library     SeleniumLibrary
Resource    ../../resources/keywords/utils.resource
Resource    ../../resources/pages/loginPage.resource
Resource    ../../resources/pages/employeesPage.resource
Resource    ../../resources/keywords/common_test_steps.resource
Resource    ../../resources/keywords/zephyr_scale_integrate.resource
# Suite Setup    Test Suite Setup
# Test Setup    Test case Setup
# Test Teardown    Test case Teardown


*** Keywords ***
Link Should Be Clickable
    [Arguments]    ${locator}

    ${status}=    Run Keyword And Return Status
    ...    Element Should Be Visible    ${locator}

    # Check if link can be clicked
    IF    ${status}
        ${enabled}=    Element Should Be Enabled    ${locator}
    ELSE
        ${enabled}=    Set Variable    ${None}
    END
    RETURN    ${status} and ${enabled}
