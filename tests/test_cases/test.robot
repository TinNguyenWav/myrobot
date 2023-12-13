*** Settings ***
Library             RequestsLibrary
Resource            ../../resources/keywords/zephyr_scale_integrate.resource
Resource            ../../resources/keywords/utils.resource

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

<GH-001> --- Test something
    Log    hello


*** Keywords ***
Post action test
    Get Test Case ID
