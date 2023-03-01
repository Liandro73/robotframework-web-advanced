*** Settings ***
Library    SeleniumLibrary
Library    String
Library    FakerLibrary

*** Variables ***
${BROWSER}                           chrome
${URL}                               https://saucedemo.com/
${TIMEOUT}                           15
#LoginPage
${INPUT_USERNAME}                    id=user-name
${INPUT_PASSWORD}                    id=password
#ProductPage
${PRODUCT}                           xpath=//div[text()="Sauce Labs Bolt T-Shirt"]
#CheckoutPage
${INPUT_FIRSTNAME}                   id=first-name
${INPUT_LASTNAME}                    id=last-name
${INPUT_ZIPCODE}                     id=postal-code


*** Keywords ***
#### Setup e Teardown
Setup
    Set Selenium Timeout             ${TIMEOUT}
    Open Browser                     about:blank   ${BROWSER}

Tear Down
    Close Browser

#### Actions
Go to homepage Sauce Demo - Store
    Go To                            ${URL}
    Wait Until Element Is Visible    class=login_logo
    Title Should Be                  Swag Labs

Login with user "${USER}" and password "${PASSWORD}"
    Capture Page Screenshot
    Clear Element Text               ${INPUT_USERNAME}
    Input Text                       ${INPUT_USERNAME}    ${USER}

    Clear Element Text               ${INPUT_PASSWORD}
    Input Text                       ${INPUT_PASSWORD}    ${PASSWORD}

    Click Button                     id=login-button

Click on product "T-shirt"
    Wait Until Element Is Visible    class=app_logo
    Wait Until Element Is Visible    ${PRODUCT}
    Click Element                    ${PRODUCT}

Click on button "Add to Cart"
    Wait Until Element Is Visible    id=add-to-cart-sauce-labs-bolt-t-shirt
    Click Button                     id=add-to-cart-sauce-labs-bolt-t-shirt

Clicar no botão "Proceed to checkout"
    Wait Until Element Is Visible    xpath=//*[@id="layer_cart"]//a[@title="Proceed to checkout"]
    Click Element                    xpath=//*[@id="layer_cart"]//a[@title="Proceed to checkout"]

Add the product "t-shirt" in the cart
    Click on product "T-shirt"
    Click on button "Add to Cart"

Verify that there are the product "${PRODUCT_NAME}" in the cart
    Wait Until Element Is Visible    class=shopping_cart_badge
    Element Text Should Be           class=shopping_cart_badge    1
    Click Element                    class=shopping_cart_link
    Wait Until Element Is Visible    xpath=//span[text()="Your Cart"]
    Capture Page Screenshot
    Element Text Should Be           ${PRODUCT}    ${PRODUCT_NAME}

Remove the product from the cart
    Click Button                     id=remove-sauce-labs-bolt-t-shirt
    
The cart should be empty
    Element Should Not Be Visible    class=shopping_cart_badge
    Capture Page Screenshot

Go to checkout
    Click Button                     id=checkout 

Fill the checkout information and continue
    Wait Until Element Is Visible    xpath=//span[text()="Checkout: Your Information"]

    ${FIRSTNAME}                     First Name
    ${LASTNAME}                      Last Name
    ${ZIPCODE}                       Zipcode

    Clear Element Text               ${INPUT_FIRSTNAME}
    Input Text                       ${INPUT_FIRSTNAME}    ${FIRSTNAME}

    Clear Element Text               ${INPUT_LASTNAME}
    Input Text                       ${INPUT_LASTNAME}     ${LASTNAME}

    Clear Element Text               ${INPUT_ZIPCODE}
    Input Text                       ${INPUT_ZIPCODE}      ${ZIPCODE}
    Capture Page Screenshot

    Click Button                     id=continue

Finish the order
    Wait Until Element Is Visible    xpath=//span[text()="Checkout: Overview"]
    Click Button                     id=finish

The order should be completed and this message should be visible "${MESSAGE}"
    Wait Until Element Is Visible    xpath=//span[text()="Checkout: Complete!"]
    Element Should Be Visible        xpath=//h2[text()="${MESSAGE}"]
    Capture Page Screenshot