*** Settings ***
Library     String
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
