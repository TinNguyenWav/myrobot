*** Settings ***
Resource    ../../../resources/keywords/command.resource
Resource    ../../../configurations/config.resource
Resource    ../../../resources/keywords/common_test_steps.resource
Resource    ../../../resources/pageObjects/sidebarPageObject.resource
Resource    ../../../resources/pages/profilePage.resource
Resource    ../../../resources/pages/insurancesPage.resource
Test Teardown    Close Browser
*** Variables ***

*** Test Cases ***
TC001---Test case 
    Login system with admin user account
    Select on the "People Management" option
    Select on the "Employees" from dropdown
    Employees page should be opened
    Click an employee with name Fresher Dev Nguyen
    Profile page should be opened
    Select the Insurances option
    The Insurances page should be opened 