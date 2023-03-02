*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}                           chrome
${TIMEOUT}                           15

*** Keywords ***
#### Setup e Teardown
Setup
    Set Selenium Timeout             ${TIMEOUT}
    Open Browser                     about:blank   ${BROWSER}

Tear Down
    Close Browser