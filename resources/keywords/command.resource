*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../pageObjects/multipleSelectPanel.resource
Resource    utils.resource


*** Variables ***
${web_element_indicator}    selenium.webdriver.remote.webelement.WebElement


*** Keywords ***
# ------------------- GET ELEMENT -------------------#

Get element by partial id
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

Get Element by locator
    [Documentation]    Returns the WebElement matching the given locator.
    ...    For supported locate, using the build in keyword.
    ...    For unsupported locate, using the custom keyword.
    ...    Keyword will find and return a web element based on specific criteria.
    [Arguments]    ${locator}

    TRY
        ${is_web_element}=    Is web element    ${locator}
        IF    "${is_web_element}" == "True"
            RETURN    ${locator}
        ELSE
            ${locator}=    Search and Replace double quotes by single quote    ${locator}
            ${is_supported_locator}=    Is supported element locator    ${locator}
            IF    "${is_supported_locator}" != "None"
                Wait until element is Visible    ${locator}
                ${element}=    Wait Until Keyword Succeeds
                ...    ${RETRY}
                ...    ${INTERVAL}
                ...    Get WebElement    ${locator}
                RETURN    ${element}
            ELSE
                TRY
                    ${element}=    Get element by partial id    ${locator}
                    RETURN    ${element}
                EXCEPT
                    ${element}=    Get element by text    ${locator}
                    RETURN    ${element}
                END
            END
        END
    EXCEPT
        Fail    Element with locator ${locator} not found
    END

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
    ${element}=    Get Element by locator    ${locator}
    Wait Until Keyword Succeeds
    ...    ${RETRY}
    ...    ${INTERVAL}
    ...    Click Element    ${element}

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
    ${element}=    Get Element by locator    ${locator}
    Wait Until Keyword Succeeds
    ...    ${RETRY}
    ...    ${INTERVAL}
    ...    Input Text    ${element}    ${text}

Input text to ${field} with ${value}
    Input Text    css=[ng-reflect-label='${field}'] input    ${value}

Select option in dropdown menu
    [Documentation]    Select certain dropdown option by the provided locator and option value
    [Arguments]    ${locator}    ${expected_item_text}
    Wait Until Keyword Succeeds
    ...    ${RETRY}
    ...    ${INTERVAL}
    ...    Click Element    ${locator}
    Search and select option    ${expected_item_text}

# ------------------- ASSERTIONS -------------------#

Expect webelement contains text
    [Arguments]    ${locator}    ${expected_text}
    Wait Until Keyword Succeeds
    ...    ${RETRY}
    ...    ${INTERVAL}
    ...    Element Should Contain    ${locator}    ${expected_text}

Link Should Be Clickable
    [Arguments]    ${locator}

    ${status}=    Run Keyword And Return Status
    ...    Element Should Be Visible    ${locator}

    # Check if link can be clicked
    IF    ${status}
        ${enabled}=    Element Should Be Enabled    ${locator}
    ELSE
        ${enabled}=    Set Variable    ${None}
    END
    RETURN    ${status} and ${enabled}

Is web element
    [Arguments]    ${locator}
    ${is_web_element}=    Is Text Contains    ${locator}    ${web_element_indicator}
    RETURN    ${is_web_element}

# ------------------- CUSTOM WAIT -------------------#

Wait until element is Visible
    [Arguments]    ${locator}
    Wait Until Keyword Succeeds
    ...    ${RETRY}
    ...    ${INTERVAL}
    ...    Run Keyword And Return Status    Element Should Be Visible    ${locator}

# ------------------- LOGS -------------------#

Stop logging info
    Set Log Level    None

Restore logging info
    Set Log Level    INFO
