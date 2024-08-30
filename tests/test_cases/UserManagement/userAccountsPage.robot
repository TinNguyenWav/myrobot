*** Settings ***
Resource    ../../../resources/pages/userAccountsPage.resource
Resource    ../../../configurations/config.resource
Resource            ../../../resources/keywords/common_test_steps.resource
Resource            ../../../resources/keywords/zephyr_scale_integrate.resource
Resource            ../../../resources/keywords/utils.resource
Resource            ../../../resources/pages/loginPage.resource
Resource            ../../../resources/pages/employeesPage.resource
# Suite Setup         Test Suite Setup
# Test Setup          Test case Setup
Test Teardown       Close Browser 
# Suite Teardown      Test Suite Teardown
*** Variables ***
*** Test Cases ***
GH-T75 --- Verify that Admin user can create user account by selecting checkbox Grant access to System
    [Tags]    High
    [Setup]    Create data
    Login system with admin user account second
    Access Employees page
    Click Add Employee button
    Input value for the First Name field    Robot
    Input value for the Last Name field    ${LAST_NAME}
    Input value for the Email field    ${EMAIL_EMPLOYEE}
    Select value for the Location field    Vietnam
    Select value for the Position field    ${POSITION}
    Input value for the Joining Date field
    Select value for the Department field    ${DEPARTMENT}
    Select the Grant access to System checkbox
    Click on the Submit button
    Access the User Accounts page
    Input value for Employee Email at User Accounts Page    ${EMAIL_EMPLOYEE}
    Click on the Search button
    The added user account should display on the User Accounts page    ${EMAIL_EMPLOYEE}
GH-T81 --- Verify that in edit mode, just show grant acess for profile has no Account linked
    [Tags]    High
    Login system with admin user account second
    Access Employees page
    Click on the Action menu of an employee account
    Select the Edit option on the Action menu of an employee account
    The system just should just show grant access for profile has no Account linked
GH-T107 --- Verify that there is a page for managing all user accounts
    [Tags]    High
    Login system with admin user account second
    Access the User Accounts page
    User Accounts page should be opened
GH-T108 --- Verify that users can add a new User Account for existing employee profile
    [Tags]    High
    [Setup]    There is one employee who only has the employee account
    Access the User Accounts page
    Click on the New User Account button
    Input value for the Search Employee field    ${EMAIL_EMPLOYEE}
    Select the searched employee account
    Click on the Submit button of the Add User Account pop-up
    Input value for Employee Email at User Accounts Page    ${EMAIL_EMPLOYEE}
    Click on the Search button
    The added user account should display on the User Accounts page    ${EMAIL_EMPLOYEE}
GH-T109 --- Verify that admin users can search employees by Name, Employee ID, Email
    [Tags]    High
    [Setup]    There is one employee who only has the employee account
    Access the User Accounts page
    Click on the New User Account button
    Input value for the Search Employee field    ${EMAIL_EMPLOYEE}
    The account should be displayed on the User Accounts page    ${EMAIL_EMPLOYEE}
    Input value for the Search Employee field    Robot ${LAST_NAME}
    The account should be displayed on the User Accounts page    Robot ${LAST_NAME}
    Input value for the Search Employee field    ${EMPLOYEE_ID}
    The account should be displayed on the User Accounts page    ${EMPLOYEE_ID}
GH-T112 --- Verify that users can edit existing accounts by selecting the Edit option on the Action menu
    [Tags]    High
    Login system with admin user account second
    Access the User Accounts page
    Click on the Action Menu of a user account
    Select the Edit option on the Action Menu of a user account
    Select a value on the Role dropdown
    Click on the Assign Roles button
    Click on the Submit button on the Edit User Account pop-up
    User should be edited success the user account
GH-T114 --- Verify that the user can successfully select the Resend Invite button
    [Tags]    High
    Login system with admin user account second
    Access the User Accounts page
    Select a value on the User Status dropdown    Invited
    Click on the Search button
    Click on the Action Menu of a user account
    Select the Resend Invite option on the Action Menu of a user account
    The user should successfully select the Resend Invite
GH-T115 --- Verify that admin user can select Restore access when current status is Suspended
    [Tags]    High
    [Setup]    There is a user account that has Suspended status
    Access the User Accounts page
    Select a value on the User Status dropdown    Suspended
    Click on the Search button
    Click on the Action Menu of a user account
    Select the Restore Access option on the Action Menu of a user account
    The user should successfully select the Restore Invite