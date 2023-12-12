*** Settings ***
Resource            ../../resources/keywords/common.resource
Resource            ../../resources/pages/loginPage.resource
Resource            ../../resources/pages/homePage.resource
Resource            ../../resources/pageObjects/hearderPageObject.resource

Test Setup          Open Login page
Test Teardown       Close Browser


*** Test Cases ***
Verify that user can access Login page
    Login page is opened

Verify that the user can log in with valid credential
    Login with username and password    ${ADMIN USER}    ${ADMIN PASSWORD}
    Home page should be opened
    Header should contains user name of user login    Robot AutoBot
