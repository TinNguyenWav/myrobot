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
    Click on edit icon 'Dependent Information'
    The New Add Dependent popup should be opened
    Input 'Van A' in the 'Name' field in the Add Dependent popup 
    Select Relationship in dropdown with 'Father' option 
    Input '07/09/1982' in the 'Date of Birth' field in the Add Dependent popup
    Input '125897456' in the 'Tax Id No.' field in the Add Dependent popup
    Click on the Submit button in the Dependent popup
    The message "Dependent was Created successfully" should be display
GH-T35 --- Verify that user can delete existing dependent by selecting Delete option on Table Actions Dropdown
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
    Click on the Delete button on the a Dependent
    Click on OK button to Confirmation delete Dependent in the Confirmation dialog
    The message "Remove Dependent Successfully" should be display
    The Dependent deleted should be no display
GH-T34 --- Verify that user can edit existing dependent information by selecting Edit option on Table Actions Dropdown
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
    Click on the Edit button on the a Dependent
    The Edit Dependent popup should be opened 
    Update 'Nguyen B' in the 'Name' field in the Add Dependent popup 
    Click on the Submit button in the Dependent popup
    The data should be new data of Dependent    Nguyen B