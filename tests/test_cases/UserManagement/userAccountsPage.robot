*** Settings ***
Resource    ../../../resources/pages/userAccountsPage.resource
Resource    ../../../configurations/config.resource
Resource            ../../../resources/keywords/common_test_steps.resource
Resource            ../../../resources/keywords/zephyr_scale_integrate.resource
Resource            ../../../resources/keywords/utils.resource
Resource            ../../../resources/pages/loginPage.resource
Resource            ../../../resources/pages/employeesPage.resource
*** Variables ***
*** Test Cases ***
GH-T75 --- Verify that Admin user can create user account by selecting checkbox Grant access to System
    [Tags]    High
    [Setup]    Create data
    Login system with admin user account
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
    Access the User Account page
    Input value for Employee Email at User Accounts Page    ${EMAIL_EMPLOYEE}
    Click on the Search button
    The added user account should display on the User Accounts page    ${EMAIL_EMPLOYEE}