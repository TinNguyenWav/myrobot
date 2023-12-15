*** Settings ***
Library             RequestsLibrary
Resource            ../../resources/keywords/zephyr_scale_integrate.resource
Resource            ../../resources/keywords/utils.resource

Test Setup          Setup action test
Test Teardown       Post action test


*** Test Cases ***
Example Get API Call
    Create Session    mysession    https://61de6362ab592500178c714e.mockapi.io

    ${response}=    GET On Session    mysession    /user
    Log    ${response.status_code}
    Log    ${response.content}

    ${user}=    Set Variable    { "name": "John", "id": 123 }
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${response}=    POST On Session    mysession    /api/users    json=${user}    headers=${headers}

    Status Should Be    201    ${response}

Test get test case
    # Get all test cases
    Get test cases by ID    GH-T125

Crete test Cycle
    Create test Cycle

GH-T126 --- Create test execution test
    Sleep    5s    # Pause for 2 seconds
    Log    Done test


*** Keywords ***
Setup action test
    Set test case start time

Post action test
    Set test execution elapsed
    ${test_message}=    Set Variable    ${TEST MESSAGE}
    Create test execution result
    Log    Done test
