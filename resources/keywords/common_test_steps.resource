*** Settings ***
Resource    ../../resources/pages/loginPage.resource
Resource    ../../resources/pages/homePage.resource
Resource    ../../resources/pageObjects/hearderPageObject.resource
Resource    ./zephyr_scale_integrate.resource


*** Keywords ***
Login system with admin user account
    Open Login page
    Login with username and password    ${ADMIN USER}    ${ADMIN PASSWORD}
    Wait Until Location Does Not Contain    login

Test Suite Setup
    Create test cycle at folder    Smoke Testing
    Log    This is suite setup

Test Suite Teardown
    Delete All Sessions
    Log    Suite Teardown

Test case Setup
    Set test case start time

Test case Teardown
    Close Browser
    Update test case result to Zephyr Scale
