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
GH-T125 --- Verify that admin user can access Employee page
    [Documentation]    This is some basic info about test
    [Tags]    smoke
    Login system with admin user account
    Access Employees page
    Employees page should be opened

# Verify that admin user can
#    Login system with admin user account
#    Access Employees page
#    Click Add Employee button

GH-T128 --- Verify that admin user can search Employee profile by Email
    Login system with admin user account
    Access Employees page
    Employees page should be opened
    Search by "Email"    user00012@wsvietnam.com
    Page Should Contain    User00012 Nguyen

GH-T127 --- Verify that admin user can search Employee profile by employee name
    Login system with admin user account
    Access Employees page
    Employees page should be opened
    Search by "Employee Name"    user00006 Nguyen
    Page Should Contain    user00006 Nguyen

GH-T17 --- Verify that admin user can search Employee profile by Employee ID
    Login system with admin user account
    Access Employees page
    Employees page should be opened
    Search by "Employee ID"    VNE00006
    Page Should Contain    VNE00006_123

Debug test case
    [Setup]    NONE
    Log    st
    [Teardown]    NONE
#    Login system with admin user account
#    Access Employees page
#    # Click on "Edit" option on Action menu    user00006@wsvietnam.com

#    Click on Employee name "user00006 Nguyen"    user00006@wsvietnam.com
#    # Click on sort icon of column name "ID"
#    # Click on sort icon of column name "Name"
#    # Click on sort icon of column name "Email"
#    # Click on sort icon of column name "Mobile"
#    # Click on sort icon of column name "Join Date"
#    # Click on sort icon of column name "Position"
#    # Click on sort icon of column name "Department"


*** Keywords ***
Test Suite Setup
    Create test cycle at folder    Test Sample 1
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
