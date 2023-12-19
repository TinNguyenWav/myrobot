*** Settings ***
Resource    ../../configurations/config.resource


*** Keywords ***
Click desired text from list
    [Arguments]    ${list_selector}    ${text}
    @{elements}=    Get Webelements    ${list_selector}
    FOR    ${element}    IN    @{elements}
        ${elem_text}=    Get Text    ${element}
        IF    "${elem_text}" == "${text}"
            Click on the element    ${element}
            RETURN
        END
    END

Click on the element
    [Arguments]    ${locator}
    # Wait Until Page Contains Element    ${locator}
    Wait Until Keyword Succeeds
    ...    ${RETRY}
    ...    ${INTERVAL}
    ...    Click Element    ${locator}

Click on the link text
    [Arguments]    ${text_link}
    Wait Until Keyword Succeeds
    ...    ${RETRY}
    ...    ${INTERVAL}
    ...    Click Link    ${text_link}

Expect webelement contains text
    [Arguments]    ${locator}    ${expected_text}
    Wait Until Keyword Succeeds
    ...    ${RETRY}
    ...    ${INTERVAL}
    ...    Element Should Contain    ${locator}    ${expected_text}

Stop logging info
    Set Log Level    None

Restore logging info
    Set Log Level    INFO
