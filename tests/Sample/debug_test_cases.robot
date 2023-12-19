*** Settings ***
Library             SeleniumLibrary
Resource            ../../resources/keywords/utils.resource
Resource            ../../resources/pages/loginPage.resource
Resource            ../../resources/pages/employeesPage.resource
Resource            ../../resources/keywords/common_test_steps.resource
Resource            ../../resources/keywords/zephyr_scale_integrate.resource

Suite Setup         Test Suite Setup
Test Setup          Test case Setup
Test Teardown       Test case Teardown


*** Test Cases ***
Debug test case
    [Setup]    NONE
    Log    st
    Login system with admin user account
    Access Employees page
    # Click on "Edit" option on Action menu    user00006@wsvietnam.com

    Click on Employee name "user00006 Nguyen"    user00006@wsvietnam.com
    [Teardown]    NONE
    # Click on sort icon of column name "ID"
    # Click on sort icon of column name "Name"
    # Click on sort icon of column name "Email"
    # Click on sort icon of column name "Mobile"
    # Click on sort icon of column name "Join Date"
    # Click on sort icon of column name "Position"
    # Click on sort icon of column name "Department"


*** Keywords ***
Test Suite Setup
    Create test cycle at folder    Smoke Testing
    Log    This is suite setup

Test Suite Teardown
    # // code here...
    Log    Suite Teardown

Test case Setup
    Set test case start time
    Open Login page

Test case Teardown
    Set test execution elapsed
    # ${test_message}=    Set Variable    ${TEST MESSAGE}
    Create test execution result
    Log    Done test
    Close Browser
