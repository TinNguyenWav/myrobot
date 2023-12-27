*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../pageObjects/multipleSelectPanel.resource


*** Keywords ***
# ------------------- GET ELEMENT -------------------#

Get element by id
    [Documentation]    User can input partial ID to locate element
    [Arguments]    ${id}
    ${element}=    Wait Until Keyword Succeeds
    ...    ${RETRY}
    ...    ${INTERVAL}
    ...    Get WebElement    css: [id*='${id}']
    RETURN    ${element}

Get element by text
    [Documentation]    User can input partial text to locate element
    [Arguments]    ${text}
    ${element}=    Wait Until Keyword Succeeds
    ...    ${RETRY}
    ...    ${INTERVAL}
    ...    Get WebElement    xpath: //*[contains(text(), '${text}')]
    RETURN    ${element}

# ------------------- ACTIONS -------------------#

Click desired text from list
    [Documentation]    User can click on a certain text in a list by providing the list of element locators and the text
    [Arguments]    ${list_selector}    ${text}
    @{elements}=    Get Webelements    ${list_selector}
    FOR    ${element}    IN    @{elements}
        ${elem_text}=    Get Text    ${element}
        IF    "${elem_text}" == "${text}"
            Click on the web element    ${element}
            RETURN
        END
    END

Click on the web element
    [Documentation]    Click on element by provided locator with configured retry
    [Arguments]    ${locator}
    Wait Until Keyword Succeeds
    ...    ${RETRY}
    ...    ${INTERVAL}
    ...    Click Element    ${locator}

Click on the link text
    [Documentation]    Click on element by provided partial link text
    [Arguments]    ${text_link}
    Wait Until Keyword Succeeds
    ...    ${RETRY}
    ...    ${INTERVAL}
    ...    Click Link    ${text_link}

Click on element contains text
    [Documentation]    Click on the element contains text
    [Arguments]    ${text}
    ${element}=    Get element by text    ${text}
    Click on the web element    ${element}

Input text to text field
    [Documentation]    Input text to the text field located by the provided locator
    [Arguments]    ${locator}    ${text}
    Wait Until Keyword Succeeds
    ...    ${RETRY}
    ...    ${INTERVAL}
    ...    Input Text    ${locator}    ${text}

Select option in dropdown menu
    [Documentation]    Select certain dropdown option by the provided locator and option value
    [Arguments]    ${locator}    ${expected_item_text}
    Wait Until Keyword Succeeds
    ...    ${RETRY}
    ...    ${INTERVAL}
    ...    Click Element    ${locator}
    Search and select option    ${expected_item_text}
    Click Element    ${locator}
    # Click desired text from list    css:p-dropdownitem    ${expected_item_text}

# ------------------- ASSERTIONS -------------------#

Expect webelement contains text
    [Arguments]    ${locator}    ${expected_text}
    Wait Until Keyword Succeeds
    ...    ${RETRY}
    ...    ${INTERVAL}
    ...    Element Should Contain    ${locator}    ${expected_text}

# ------------------- LOGS -------------------#

Stop logging info
    Set Log Level    None

Restore logging info
    Set Log Level    INFO
