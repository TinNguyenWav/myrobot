*** Settings ***
Resource    ../../../resources/pages/rolesPage.resource
Resource    ../../../resources/keywords/common_test_steps.resource
# Suite Setup    Test Suite Setup
# Test Setup    Test case Setup
# Test Teardown    Test case Teardown


*** Test Cases ***
GH-T129 --- Verify that there is a tab be called as Members to support user add existing user account to a role
    Login system with admin user account
    Access Roles page
    Click location name    Vietnam
    Click role name    Admin
    Role detail popup should contain text    Members

Verify that Add Roles popup appear when user click on Add Role button
    Login system with admin user account
    Access Roles page
    Click on Add Role button
    Add Role popup should be opened
    Input text to name field    Some text here
    Select Location name    Vietnam
    Select Parent name    USER
    Sleep    5s
