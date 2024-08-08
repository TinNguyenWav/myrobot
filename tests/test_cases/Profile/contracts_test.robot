*** Settings ***
Resource            ../../../configurations/config.resource
Resource            ../../../resources/pages/contractsPage.resource
Resource            ../../../resources/pages/profilePage.resource
Resource            ../../../resources/keywords/common_test_steps.resource
Resource            ../../../resources/keywords/zephyr_scale_integrate.resource
Resource            ../../../resources/keywords/utils.resource
Resource            ../../../resources/pages/loginPage.resource
Resource            ../../../resources/pages/employeesPage.resource

Suite Setup    
*** Test Cases ***
GH-T51 --- Verify that there is a page for managing all employee contracts page
    [Tags]    High
    Login system with admin user account
    Access Employees page
    Select an employee account
    Open the Contracts tab
    All contracts of employees should manager on the Contract card
GH-T52 --- Verify that the user can navigate to Contracts page by selecting the Contracts tab on Employee profile
    [Tags]    High
    Login system with admin user account
    Access Employees page
    Select an employee account
    The Contract tab should appear
GH-T53 --- Verify that all employee contracts should show on Contract Information card
    [Tags]    High
    Login system with admin user account
    Access Employees page
    Select an employee account
    Open the Contracts tab
    All employee contract should be showed on Contract Information card
GH-T54 --- Verify that user can add new contract by clicking on (+) button on Contract Information card
    [Tags]    Normal
    Login system with admin user account
    Access Employees page
    Select an employee account
    Open the Contracts tab
    Click on the Add Contract button
    Select a option for the Contract Type dropdown field    One year
    Input value for the Contract Number field
    Input value for the Valid From field    08/07/2024
    Input value for the Valid To field    08/07/2025
    Click on the Submit button
    
GH-T57 --- Verify that value of Valid To must be equal value of Valid From when adding new Contract
    [Tags]    Normal
    Login system with admin user account
    Access Employees page
    Select an employee account
    Open the Contracts tab
    Click on the Add Contract button
    Select a option for the Contract Type dropdown field    One year
    Input value for the Contract Number field
    Input value for the Valid From field    08/07/2024
    Input value for the Valid To field    08/07/2024
    The error message shouldn't be display below the Valid To field
GH-T552 --- Verify that the Valid To field should appear error message when value of Valid to field is smaller than value of Valid From when adding new Contract
    [Tags]    Normal
    Login system with admin user account
    Access Employees page
    Select an employee account
    Open the Contracts tab
    Click on the Add Contract button
    Input value for the Valid From field    08/07/2024
    Input value for the Valid To field    08/06/2024
    The warning message " Valid To must be equal or greater than Valid From" should be display below the Valid To field

GH-T553 --- Verify that value of Valid To must be greater than Valid From when adding new Contract
    [Tags]    Normal
    Login system with admin user account
    Access Employees page
    Select an employee account
    Open the Contracts tab
    Click on the Add Contract button
    Input value for the Valid From field    08/07/2024
    Input value for the Valid To field    08/09/2024
    The error message shouldn't be display below the Valid To field
GH-T63 --- Verify that the system will show as Present when the user does not set the Valid To
    [Tags]    High
    Login system with admin user account
    Access Employees page
    Select an employee account
    Open the Contracts tab
    Click on the Add Contract button
    Enter all required field
    Click on the Submit button
    The system should showed as Present on Contract Information card


