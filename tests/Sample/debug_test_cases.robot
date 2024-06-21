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
The result of ${calculation} should be ${expected}
    ${result} =    Evaluate    ${calculation}
    Should Be Equal As Numbers    ${result}     ${expected}
    

*** Test Cases ***
This for debug purpos
    Login system with admin user account
    Access Employees page
    Employees page should be opened
    # Select Department name    Department 2 - QC

Normal test case with embedded arguments
    The result of 1 + 1 should be 2
    The result of 1 + 2 should be 3

Template with embedded arguments
    [Template]    The result of ${calculation} should be ${expected}
    1 + 1    2
