*** Settings ***
Library    SeleniumLibrary
Library    String

*** Variables ***
${BROWSER}                           chrome
${URL}                               https://saucedemo.com/
${TIMEOUT}                           15
#LoginPage
${INPUT_USERNAME}                    id=user-name
${INPUT_PASSWORD}                    id=password
#ProductPage
${PRODUCT}                           xpath=//div[text()="Sauce Labs Bolt T-Shirt"]


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

Clicar em "Sign in"
    Click Element    xpath=//*[@id="header"]//*[@class="login"][contains(text(),"Sign in")]

Informar um e-mail válido
    Wait Until Element Is Visible   id=email_create
    ${EMAIL}                        Generate Random String
    Input Text                      id=email_create    ${EMAIL}@testerobot.com

Clicar em "Create an account"
    Click Button    id=SubmitCreate

Preencher os dados obrigatórios
    Wait Until Element Is Visible   xpath=//*[@id="account-creation_form"]//h3[contains(text(),"Your personal information")]
    Click Element                   id=id_gender2
    Input Text                      id=customer_firstname    May
    Input Text                      id=customer_lastname     Fernandes
    Input Text                      id=passwd                123456
    Input Text                      id=address1              Rua Framework, Bairro Robot
    Input Text                      id=city                  Floripa
    Set Focus To Element            id=id_state
    ### No firefox ocorreu problema ao achar o listbox State, então coloquei um if para esperar
    ### pelo elemento quando for firefox
    Run Keyword If    '${BROWSER}'=='firefox'  Wait Until Element Is Visible   id=id_state
    Select From List By Index       id=id_state              9
    Input Text                      id=postcode              12345
    Input Text                      id=phone_mobile          99988877

Submeter cadastro
    Click Button    submitAccount

#### Conferências
Conferir se o cadastro foi efetuado com sucesso
    Wait Until Element Is Visible    xpath=//*[@id="center_column"]/p
    Element Text Should Be           xpath=//*[@id="center_column"]/p
    ...    Welcome to your account. Here you can manage all of your personal information and orders.
    Element Text Should Be           xpath=//*[@id="header"]/div[2]//div[1]/a/span    May Fernandes

Conferir se o carrinho fica vazio
    Wait Until Element Is Visible   xpath=//*[@id="center_column"]/p[@class='alert alert-warning']
    Element Text Should Be          xpath=//*[@id="center_column"]/p[@class='alert alert-warning']    Your shopping cart is empty.
