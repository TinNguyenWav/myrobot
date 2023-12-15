*** Settings ***
Library     RequestsLibrary


*** Variables ***
${base_url}         https://jsonplaceholder.typicode.com
${session_name}     example_session
${post_data}        {"title": "foo", "body": "bar", "userId": 1}


*** Test Cases ***
Create and Post on Session
    # Create a session with the base URL
    Create Session    ${session_name}    ${base_url}

    # Perform a POST request using the session
    ${response}=    Post On Session    ${session_name}    /posts    data=${post_data}    headers=${EMPTY}

    # Log the response status code and body
    Log    Response Status Code: ${response.status_code}
    Log    Response Body: ${response.text}

    # Delete the session to clean up
    Delete All Sessions
