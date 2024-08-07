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
GH-T37 --- Verify that there’s a page for managing all employee Insurances
    [Tags]    High
    Login system with admin user account
    Select on the "People Management" option
    Select on the "Employees" from dropdown
    Employees page should be opened
    Click an employee with name Fresher Dev Nguyen
    Profile page should be opened
    Select the Insurances option
    The Insurances page should be opened 
GH-T38 --- Verify that all existing employee Insurance(s) should show on Insurance Information card.
    [Tags]    High
    Login system with admin user account
    Select on the "People Management" option
    Select on the "Employees" from dropdown
    Employees page should be opened
    Click an employee with name Fresher Dev Nguyen
    Profile page should be opened
    Select the Insurances option
    The Insurances page should be opened 
    The number insurance of employee should be equal '8'

GH-T39 --- Verify that user can add new insurance by clicking on (+) button on Insurance Information card.
        [Tags]    High
    Login system with admin user account
    Select on the "People Management" option
    Select on the "Employees" from dropdown
    Employees page should be opened
    Click an employee with name Fresher Dev Nguyen
    Profile page should be opened
    Select the Insurances option
    The Insurances page should be opened 
    Click on the Add button in Insurance page
    The New Insurance popup should be opened
    Select Insurance in dropdown with 'PVI' option
    # Input '789456' in the Insurance No. field
    Get ID field by lable Insurance No. in insurance page