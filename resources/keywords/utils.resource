*** Settings ***
Library     String
Library     DateTime
Library     RequestsLibrary


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

Get current date time
    ${current_time}=    Get Current Date    result_format=%Y-%m-%d %H:%M:%S
    Log    ${current_time}
    RETURN    ${current_time}
