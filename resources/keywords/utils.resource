*** Settings ***
Library     String
Library     DateTime
Library     Collections
Library     RequestsLibrary
Library     SeleniumLibrary


*** Variables ***
@{supported_locators}       id:
...                         name:
...                         xpath:
...                         css:
...                         link:
...                         class:
...                         tag:
...                         partial link:
...                         dom:


*** Keywords ***
Get Suite Name
    RETURN    ${SUITE NAME}

Get Test Case Name
    RETURN    ${TEST NAME}

Get Test Case key
    ${test_case_name}=    Get Test Case Name
    ${is_test_case_name_correct_format}=    Should Match Regexp    ${test_case_name}    .*---.*
    ${tc_parts}=    Split String    ${test_case_name}    ---
    ${first_part}=    Replace String    ${tc_parts}[0]    <    ${EMPTY}
    ${last_part}=    Replace String    ${first_part}    >    ${EMPTY}
    ${key_part}=    Strip String    ${last_part}
    ${is_correct_key}=    Should Match Regexp    ${key_part}    GH-.*
    IF    '${is_correct_key}' == 'None'
        Fatal Error    Test case ID does not exist
    ELSE
        RETURN    ${key_part}
    END

# Stop Execution On Failure
#    [Arguments]    ${condition}
#    IF    ${condition} == True
#    Run Keyword And Return From Test Case    Fail    Test failed
#    END

Get test case status
    RETURN    ${TEST_STATUS}

Get test case message
    RETURN    ${TEST_MESSAGE}

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

Get test execution elapsed
    ${end}=    Set test case end time
    ${elapsed_time}=    Subtract Date From Date    ${end}    ${start}
    ${elapsed}=    Evaluate    ${elapsed_time}*1000
    Set Global Variable    ${elapsed}
    RETURN    ${elapsed}

Get Matching String
    [Arguments]    ${actual}    ${expected}
    ${length}=    Set Variable    ${expected.__len__()}
    IF    '${actual}'.startswith('${expected}')
        ${matching_string}=    Evaluate    '${actual}'[:${length}]
    ELSE
        ${matching_string}=    Set Variable    ${matching_string}    ${EMPTY}
    END
    RETURN    ${matching_string}

Is Text Start With
    [Documentation]    Return True if the actual string start with expected
    [Arguments]    ${actual}    ${expected}
    ${result}=    Evaluate    "${actual}".startswith("${expected}")    # Evaluate returns a boolean value
    RETURN    ${result}

Is Text Contains
    [Arguments]    ${actual}    ${expected}
    ${string_variable}=    Convert To String    ${actual}
    ${status}=    Run Keyword And Return Status    Should Contain    ${string_variable}    ${expected}
    RETURN    ${status}

Is supported element locator
    [Documentation]    Return locator value incase the selector start with commonly used locators in Robot Framework:
    ...    id, name, xpath, css, link, class, tag, partial link, dom
    [Arguments]    ${Locator}
    FOR    ${element}    IN    @{supported_locators}
        ${is_contains}=    Is Text Start With    ${Locator}    ${element}
        IF    "${is_contains}" == "True"    RETURN    True
    END

Search and Replace double quotes by single quote
    [Arguments]    ${original_string}
    ${modified_string}=    Replace String    ${original_string}    "    '
    RETURN    ${modified_string}

# Scroll Element Into View
#    [Arguments]    ${element}
#    Execute Javascript    arguments[0].scrollIntoView(true);    ${element}
