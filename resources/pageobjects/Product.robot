*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${LOGO_APP}                          class=app_logo
${PRODUCT}                           xpath=//div[text()="Sauce Labs Bolt T-Shirt"]
${BUTTON_ADDTOCART_TSHIRT}           id=add-to-cart-sauce-labs-bolt-t-shirt

*** Keywords ***
Click on product "T-shirt"
    Wait Until Element Is Visible    ${LOGO_APP}
    Wait Until Element Is Visible    ${PRODUCT}
    Click Element                    ${PRODUCT}

Click on button "Add to Cart"
    Wait Until Element Is Visible    ${BUTTON_ADDTOCART_TSHIRT}
    Click Button                     ${BUTTON_ADDTOCART_TSHIRT}

Add the product "T-shirt" in the cart
    Click on product "T-shirt"
    Click on button "Add to Cart"