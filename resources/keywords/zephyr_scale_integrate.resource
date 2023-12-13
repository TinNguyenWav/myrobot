*** Settings ***
Library     RequestsLibrary
Resource    utils.resource
Resource    ../../configurations/api_credentials.resource


*** Keywords ***
Create test Cycle
    Get Suite Name
    # Code to create test cycle by test suite name
    Log    Test cycle is created

Update test case result to Zephyr Scale
    Get Test Case ID
    # Update test result by test case ID
    Log    Test case result is updated

Excute test
    [Arguments]    ${test_suite_name}
    Log    Call kyeword to trigger the test

Log the token from local file
    Log    ${API_TOKEN}
