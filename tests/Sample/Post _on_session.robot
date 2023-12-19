*** Settings ***
Library             SeleniumLibrary

Suite Setup         Open the browser
Suite Teardown      Close All Browsers


*** Variables ***
${URL}          https://forum.robotframework.org/t/setting-test-setup-is-not-allowed-in-resource-file-error-message-in-console/5926/6
${BROWSER}      Chrome


*** Test Cases ***
Test Case 1
    Log    Executing Test Case 1
    # Your test steps for Test Case 1

Test Case 2
    Log    Executing Test Case 2
    # Your test steps for Test Case 2


*** Keywords ***
Open the browser
    Open Browser    ${URL}    ${BROWSER}
