*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}                               https://saucedemo.com/
${LOGO_LOGIN}                        class=login_logo
${INPUT_USERNAME}                    id=user-name
${INPUT_PASSWORD}                    id=password
${BUTTON_LOGIN}                      id=login-button

*** Keywords ***
Go to homepage Sauce Demo - Store
    Go To                            ${URL}
    Wait Until Element Is Visible    ${LOGO_LOGIN}
    Title Should Be                  Swag Labs

Login with user "${USER}" and password "${PASSWORD}"
    Capture Page Screenshot
    Clear Element Text               ${INPUT_USERNAME}
    Input Text                       ${INPUT_USERNAME}    ${USER}

    Clear Element Text               ${INPUT_PASSWORD}
    Input Text                       ${INPUT_PASSWORD}    ${PASSWORD}

    Click Button                     ${BUTTON_LOGIN}