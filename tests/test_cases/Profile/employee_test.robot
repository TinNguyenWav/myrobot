*** Settings ***
Resource            ../../../resources/keywords/utils.resource
Resource            ../../../resources/pages/loginPage.resource
Resource            ../../../resources/pages/employeesPage.resource
Resource            ../../../resources/keywords/common_test_steps.resource
Resource            ../../../resources/keywords/zephyr_scale_integrate.resource

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
    Page Should Contain    VNE00006
