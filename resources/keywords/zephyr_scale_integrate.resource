*** Settings ***
Library     json
Library     RequestsLibrary
Library     Collections
Resource    utils.resource
Resource    ../../configurations/api_credentials.resource


*** Variables ***
${BASE_URL}         https://api.zephyrscale.smartbear.com/v2
# ${HEADERS}    {'Content-Type': 'application/json','Authorization': 'Bearer ${API_TOKEN}'}
${Content_Type}     application/json


*** Keywords ***
Create new session
    ${headers}=    Create Dictionary    Content-Type=${Content_Type}    Authorization=Bearer ${API_ACCESS_TOKEN}
    Create Session    mysession    ${BASE_URL}    headers=${headers}

Create test Cycle
    ${cycle_name}=    Generate test cycle name
    ${folder_id}=    Set Variable    11389742
    Create new session
    ${payload}=    Create Dictionary
    ...    name= ${cycle_name}
    ...    projectKey=${PROJECT_KEY}
    ...    folderId=${folder_id}
    ${json_payload}=    Evaluate    json.dumps($payload, ensure_ascii=False)
    ${response}=    POST On Session    mysession    /testcycles    data=${json_payload}

    ${cycle_key}=    Set Variable    ${response.json()}[key]
    Log    ${cycle_key}
    RETURN    ${cycle_key}

Update test case result to Zephyr Scale
    Get Test Case ID

Excute test
    [Arguments]    ${test_suite_name}
    Log    Call kyeword to trigger the test

Log the token from local file
    Log    ${API_ACCESS_TOKEN}

Get all test cases
    Create new session
    ${response}=    GET On Session    mysession    /testcases
    Log    ${response.status_code}
    Log    ${response.content}

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

Create test execution result
    # [Arguments]    ${elapsed}
    ${endpoint}=    Set Variable    /testexecutions
    ${cycle_key}=    Create test Cycle
    ${test_case_id}=    Get Test Case ID
    ${test_case_status}=    Get test case status
    # ${execution_time}=    Set Variable    ${elapsed}
    ${execution_time}=    Get Variable Value    ${elapsed}
    Create new session
    &{payload}=    Create Dictionary
    ...    projectKey=${PROJECT_KEY}
    ...    testCaseKey=${test_case_id}
    ...    testCycleKey=${cycle_key}
    ...    statusName=${test_case_status}
    ...    executionTime=${execution_time}
    ${payload_json}=    Evaluate    json.dumps($payload, ensure_ascii=False)
    ${response}=    POST On Session    mysession    ${endpoint}    data=${payload_json}
    Log    ${response}
