*** Settings ***
Resource    ../../../resources/pages/rolesPage.resource
Resource    ../../../resources/keywords/common_test_steps.resource
Resource    ../../../resources/pageObjects/toastMessagePageObject.resource
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

GH-T137 --- Verify that Add Roles popup appear when user click on Add Role button
    Login system with admin user account
    Access Roles page
    Click on Add Role button
    Add Role popup should be opened

Verify that the user can create a new Role by fulfilling all required fields
    Login system with admin user account
    Access Roles page
    Click on Add Role button
    Add Role popup should be opened
    Input text to Name field    Role 01234567
    Select Location name    Vietnam
    Select Parent name    USER
    Click on Submit button
    Add role successfully
    Sleep    5s

Verify that the user can delete a Role
    Login system with admin user account
    Access Roles page
    Click location name    Vietnam
    Delete role    Role 01
    Sleep    5s

Debug
    ${actual}    Set Variable
    ...    <selenium.webdriver.remote.webelement.WebElement (session="b4ee2c949126a23bbe8815998dd215c7", element="21BE646D1744BFA700E8BF1E7846C542_element_157")>
    ${substring}    Set Variable    selenium.webdriver.remote.webelement.WebElement
    ${result}    Is Text Contains    ${actual}    ${substring}
    Log    ${result}


*** Keywords ***
Input role name
    [Arguments]    ${name}
    ${element}    Get Element by locator    css:[ng-reflect-label="Name"] input
