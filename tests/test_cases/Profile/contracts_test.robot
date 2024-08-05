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
    The Contract tab should appear