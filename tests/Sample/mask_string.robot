*** Settings ***
Library     String


*** Keywords ***
Check my keywords
    ${token}=    Set Variable    12312312312
    ${masked}=    Mask String    ${token}
