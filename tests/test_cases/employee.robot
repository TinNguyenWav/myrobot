*** Settings ***
Resource            ../../resources/pages/employeesPage.resource
Resource            ../../resources/keywords/common.resource
Resource            ../../resources/pages/loginPage.resource

Test Setup          Open Login page
Test Teardown       Close Browser


*** Test Cases ***
Verify that user can access Employee page
    Log    Test Case Name: ${TEST_NAME}
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

GH-T30-Example Test
    ${test_case_name}=    Get Test Case Name
    ${test_case_id}=    Get Test Case ID    ${test_case_name}
    Log    Test Case ID: ${test_case_id}
    # Add other actions or verifications as needed


*** Keywords ***
Get Test Case Name
    RETURN    ${TEST NAME}

Get Test Case ID
    [Arguments]    ${test_case_name}
    ${id_parts}=    Split String    ${test_case_name}    -
    RETURN    ${id_parts}[0]
