*** Settings ***
Resource            ../../resources/keywords/utils.resource
Resource            ../../resources/pages/loginPage.resource
Resource            ../../resources/pages/employeesPage.resource
Resource            ../../resources/keywords/common_test_steps.resource
Resource            ../../resources/keywords/zephyr_scale_integrate.resource

Test Setup          Setup action test
Test Teardown       Post action test


*** Test Cases ***
GH-T125 - Verify that user can access Employee page
    [Documentation]    This is some basic info about test
    [Tags]    smoke
    Login system with admin user account
    Access Employees page
    Employees page should be opened

Verify that admin user can
    Login system with admin user account
    Access Employees page
    Click Add Employee button

Verify that user can search with Email
    Login system with admin user account
    Access Employees page
    Employees page should be opened
    Search by "Email"    user00012@wsvietnam.com
    Page Should Contain    User00012 Nguyen

Verify that user can search with Employee name
    Login system with admin user account
    Access Employees page
    Employees page should be opened
    Search by "Employee Name"    user00006 Nguyen
    Page Should Contain    user00006 Nguyen

Verify that user can search with Employee ID
    Login system with admin user account
    Access Employees page
    Employees page should be opened
    Search by "Employee ID"    VNE00006
    Page Should Contain    VNE00006

Debug test case
    Login system with admin user account
    Access Employees page
    # Click on "Edit" option on Action menu    user00006@wsvietnam.com

    Click on Employee name "user00006 Nguyen"    user00006@wsvietnam.com
    # Click on sort icon of column name "ID"
    # Click on sort icon of column name "Name"
    # Click on sort icon of column name "Email"
    # Click on sort icon of column name "Mobile"
    # Click on sort icon of column name "Join Date"
    # Click on sort icon of column name "Position"
    # Click on sort icon of column name "Department"


*** Keywords ***
Suite Setup
    # // code here...
    Log    Suite Setup

Suite Teardown
    # // code here...
    Log    Suite Teardown

Test case Setup
    Open Login page

Test case Teardown
    Close Browser

Setup action test
    Set test case start time
    Open Login page

Post action test
    Set test execution elapsed
    ${test_message}=    Set Variable    ${TEST MESSAGE}
    Create test execution result
    Log    Done test
