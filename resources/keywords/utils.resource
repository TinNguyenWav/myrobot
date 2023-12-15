*** Settings ***
Library     String
Library     DateTime
Library     RequestsLibrary


*** Variables ***
${elapsed}      ${EMPTY}


*** Keywords ***
Get Suite Name
    RETURN    ${SUITE NAME}

Get Test Case Name
    RETURN    ${TEST NAME}

Get Test Case ID
    ${test_case_name}=    Get Test Case Name
    ${tc_parts}=    Split String    ${test_case_name}    ---
    ${first_part}=    Replace String    ${tc_parts}[0]    <    ${EMPTY}
    ${last_part}=    Replace String    ${first_part}    >    ${EMPTY}
    ${id_part}=    Strip String    ${last_part}
    RETURN    ${id_part}

Get test case status
    RETURN    ${TEST_STATUS}

Get test case execution time
    Log    st

Get current date time
    ${current_time}=    Get Current Date    result_format=%Y-%m-%d %H:%M:%S
    Log    ${current_time}
    RETURN    ${current_time}

Set test case start time
    ${start}=    Get Current Date
    Set Global Variable    ${start}
    RETURN    ${start}

Set test case end time
    ${end}=    Get Current Date
    Set Global Variable    ${end}
    RETURN    ${end}

Set test execution elapsed
    ${end}=    Set test case end time
    ${elapsed_time}=    Subtract Date From Date    ${end}    ${start}
    ${elapsed}=    Evaluate    ${elapsed_time}*1000
    Set Global Variable    ${elapsed}
    RETURN    ${elapsed}
