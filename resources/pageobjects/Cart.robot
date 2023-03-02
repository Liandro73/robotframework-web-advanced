*** Settings ***
Library    SeleniumLibrary
Library    FakerLibrary

*** Variables ***
${PRODUCT}                           xpath=//div[text()="Sauce Labs Bolt T-Shirt"]
${BADGE_SHOPPINGCART}                class=shopping_cart_badge
${BUTTON_REMOVEPRODUCT_TSHIRT}       id=remove-sauce-labs-bolt-t-shirt
${INPUT_FIRSTNAME}                   id=first-name
${INPUT_LASTNAME}                    id=last-name
${INPUT_ZIPCODE}                     id=postal-code
${BUTTON_CHECKOUT}                   id=checkout
${BUTTON_CONTINUE}                   id=continue
${BUTTON_FINISH}                     id=finish

*** Keywords ***
Verify page title or message
    [Arguments]                      ${TITLE_OR_MESSAGE}
    Element Should Be Visible        xpath=//*[text()="${TITLE_OR_MESSAGE}"]

Verify that there are the product "${PRODUCT_NAME}" in the cart
    Wait Until Element Is Visible    ${BADGE_SHOPPINGCART}
    Element Text Should Be           ${BADGE_SHOPPINGCART}    1
    Click Element                    ${BADGE_SHOPPINGCART}
    Verify page title or message     Your Cart
    Capture Page Screenshot
    Element Text Should Be           ${PRODUCT}    ${PRODUCT_NAME}

Remove the product from the cart
    Click Button                     ${BUTTON_REMOVEPRODUCT_TSHIRT}
    
The cart should be empty
    Element Should Not Be Visible    ${BADGE_SHOPPINGCART}
    Capture Page Screenshot 

Go to checkout
    Click Button                     ${BUTTON_CHECKOUT}

Fill the checkout information and continue
    Verify page title or message     Checkout: Your Information

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

    Click Button                     ${BUTTON_CONTINUE}

Finish the order
    Verify page title or message     Checkout: Overview
    Click Button                     ${BUTTON_FINISH}

The order should be completed and this message should be visible "${MESSAGE}"
    Verify page title or message     Checkout: Complete!
    Verify page title or message     ${MESSAGE}
    Capture Page Screenshot