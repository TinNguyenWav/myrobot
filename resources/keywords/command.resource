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

Input text to text field
    [Arguments]    ${locator}    ${text}
    Wait Until Keyword Succeeds
    ...    ${RETRY}
    ...    ${INTERVAL}
    ...    Input Text    ${locator}    ${text}

Select option in dropdown menu
    [Arguments]    ${locator}    ${expected_item_text}
    Wait Until Keyword Succeeds
    ...    ${RETRY}
    ...    ${INTERVAL}
    ...    Click Element    ${locator}
    Click desired text from list    css:p-dropdownitem    ${expected_item_text}

Get element by id or partial id
    [Arguments]    ${id}
    # ${element}=    Set Variable    css: [id*='${id}']
    ${element}=    Get WebElement    css: [id*='${id}']
    RETURN    ${element}
    # css: [id*='locationId']

Stop logging info
    Set Log Level    None

Restore logging info
    Set Log Level    INFO
