*** Settings ***
Resource    ../../resources/pages/loginPage.resource
Resource    ../../resources/pages/homePage.resource
Resource    ../../resources/pageObjects/hearderPageObject.resource


*** Keywords ***
Login system with admin user account
    Login with username and password    ${ADMIN USER}    ${ADMIN PASSWORD}
    Wait Until Location Does Not Contain    login
