*** Settings ***
Resource    ../../../resources/keywords/command.resource
Resource    ../../../configurations/config.resource
Resource    ../../../resources/keywords/common_test_steps.resource
Resource    ../../../resources/pageObjects/sidebarPageObject.resource
Resource    ../../../resources/pages/profilePage.resource
Resource    ../../../resources/pageObjects/appConfirmationDialogPageObject.robot
Resource    ../../../resources/pages/dependentPage.resource
Test Teardown    Close Browser
*** Test Cases ***
GH-T32 --- Verify that dependents information should show on Dependents Information card
    [Tags]    High
    Login system with admin user account
    Select on the "People Management" option
    Select on the "Employees" from dropdown
    Employees page should be opened
    Click an employee with name Fresher Dev Nguyen
    Profile page should be opened
    Open the Contracts tab
    The Contract tab should appear
    The Denpendent tab should be display 
    The number Dependent of employee should be equal '2'

GH-T31 --- Verify that there’s a page for managing employee Dependents information
    [Tags]    High
    Login system with admin user account
    Select on the "People Management" option
    Select on the "Employees" from dropdown
    Employees page should be opened
    Click an employee with name Fresher Dev Nguyen
    Profile page should be opened
    Open the Contracts tab
    The Contract tab should appear
    The Denpendent tab should be display 
 GH-T33 Verify that user can add dependents information by clicking on plus button on Dependents Information card
    Login system with admin user account
    Select on the "People Management" option
    Select on the "Employees" from dropdown
    Employees page should be opened
    Click an employee with name Fresher Dev Nguyen
    Profile page should be opened
    Open the Contracts tab
    The Contract tab should appear
    The Denpendent tab should be display 
    Click on edit icon 'Dependent Information'