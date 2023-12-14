*** Settings ***
Library     RequestsLibrary
Library     Collections
Resource    utils.resource
Resource    ../../configurations/api_credentials.resource


*** Variables ***
${BASE_URL}             https://api.zephyrscale.smartbear.com/v2
# ${HEADERS}    {'Content-Type': 'application/json','Authorization': 'Bearer ${API_TOKEN}'}
${cycle_name_test}      This is a cycle name


*** Keywords ***
Create new session
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${API_ACCESS_TOKEN}
    Create Session    mysession    ${BASE_URL}    headers=${headers}

Create test Cycle
    ${cycle_name}=    Generate test cycle name
    Create new session
    &{payload}=    Create Dictionary    name=${cycle_name}    projectKey=${PROJECT_KEY}    folderId=11389742
    ${response}=    Post Request    mysession    /testcycles    data=${payload}

Update test case result to Zephyr Scale
    Get Test Case ID

Excute test
    [Arguments]    ${test_suite_name}
    Log    Call kyeword to trigger the test

Log the token from local file
    Log    ${API_ACCESS_TOKEN}

Get all test cases
    Create Session    mysession    ${BASE_URL}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${API_ACCESS_TOKEN}
    ${response}=    GET On Session    mysession    /testcases    headers=${headers}
    Log    ${response.status_code}
    Log    ${response.content}

# Get test cases by ID
#    [Arguments]    ${test_case_id}
#    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${API_TOKEN}
#    Create Session    mysession    ${BASE_URL}    headers=${headers}
#    ${response}=    GET On Session    mysession    /testcases/${test_case_id}    headers=${headers}
#    Log    ${response.status_code}
#    Log    ${response.content}

Get test cases by ID
    [Arguments]    ${test_case_id}
    Create new session
    ${response}=    GET On Session    mysession    /testcases/${test_case_id}
    Log    ${response.status_code}
    Log    ${response.content}
    Delete All Sessions

Generate test cycle name
    ${current_suite_name}=    Get Suite Name
    ${current_date_time}=    Get current date time
    ${cycle_name}=    Set Variable    ${current_suite_name} - ${current_date_time}
    RETURN    ${cycle_name}
