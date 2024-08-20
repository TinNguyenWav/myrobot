*** Settings ***
Resource    ../../../resources/keywords/command.resource
Resource    ../../../configurations/config.resource
Resource    ../../../resources/keywords/common_test_steps.resource
Resource    ../../../resources/pageObjects/sidebarPageObject.resource
Resource    ../../../resources/pages/profilePage.resource
Resource    ../../../resources/pages/insurancesPage.resource
Resource    ../../../resources/pageObjects/appConfirmationDialogPageObject.robot

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
    The number insurance of employee should be equal '12'

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
    Input on the "Insurance No." field with value created automatic
    Input '01/09/2023' in the 'Valid From' Date field
    Input '01/01/2024' in the 'Valid to' Date field
    Input 'tester' in the 'Issued By' field
    Click on the Submit button
    The message "Insurance information was created successfully" should be display
    The number insurance of employee should be equal '13'

GH-T40 --- Verify that new added Insurance should show on Insurance Information card and be sorted with current sort option.
    [Tags]    High
    Login system with admin user account
    Select on the "People Management" option
    Select on the "Employees" from dropdown
    Employees page should be opened
    Click an employee with name Fresher Dev Nguyen
    Profile page should be opened
    Select the Insurances option
    The Insurances page should be opened
    Select sort option with 'Valid From' field
    Click on the Add button in Insurance page
    The New Insurance popup should be opened
    Select Insurance in dropdown with 'Bao Viet' option
    Input on the "Insurance No." field with value created automatic
    Input '11/20/2022' in the 'Valid From' Date field
    Input '01/01/2024' in the 'Valid to' Date field
    Input 'tester' in the 'Issued By' field
    Click on the Submit button
    The message "Insurance information was created successfully" should be display
    The list should be sort by From    11/20/2022

GH-T41 --- Verify that user can view attachment name by hover-over the download icon and User can download load existing attach by clicking on the download icon.
    [Tags]    High
    Login system with admin user account
    Select on the "People Management" option
    Select on the "Employees" from dropdown
    Employees page should be opened
    Click an employee with name Fresher Dev Nguyen
    Profile page should be opened
    Select the Insurances option
    The Insurances page should be opened
    Hover-over the download icon
    Click on the the download icon

GH-T42 --- Verify that user can edit existing insurance information by selecting Edit option on Table Actions Dropdown
    [Tags]    High
    Login system with admin user account
    Select on the "People Management" option
    Select on the "Employees" from dropdown
    Employees page should be opened
    Click an employee with name Fresher Dev Nguyen
    Profile page should be opened
    Select the Insurances option
    The Insurances page should be opened
    Click on the Edit button on the a Insurance
    The Edit Insurance popup should be opened 
    Update 'hello' in the 'Issued By' field
    Click on the Submit button
    The data should be new data    hello
GH-T43 --- Verify that user can delete existing insurance by selecting Delete option on Table Actions Dropdown then confirm on warning popup.
    [Tags]    High
    Login system with admin user account
    Select on the "People Management" option
    Select on the "Employees" from dropdown
    Employees page should be opened
    Click an employee with name Fresher Dev Nguyen
    Profile page should be opened
    Select the Insurances option
    The Insurances page should be opened
    Click on the Delete button on the a Insurance
    Click on OK button of Confirmation Dialog
    The message "Remove Insurance successfully" should be display
    The insurance should be no display


