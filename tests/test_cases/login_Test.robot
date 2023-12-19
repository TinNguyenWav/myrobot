*** Settings ***
Resource            ../../resources/pages/homePage.resource
Resource            ../../resources/pages/loginPage.resource
Resource            ../../resources/keywords/common_test_steps.resource
Resource            ../../resources/pageObjects/hearderPageObject.resource

Test Setup          Test case Setup
Test Teardown       Test case Teardown


*** Test Cases ***
Verify that user can access Login page
    Login page is opened

Verify that the user can log in with valid credential
    Login with username and password    ${ADMIN USER}    ${ADMIN PASSWORD}
    Home page should be opened
    Header should contains user name of user login    Robot AutoBot


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
