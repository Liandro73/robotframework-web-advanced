*** Settings ***
Resource            ../resources/Resource.robot
Test Setup          Setup
Test Teardown       Tear Down

*** Test Case ***
Test Case 01 with Page Object: remove cart's products
    Go to homepage Sauce Demo - Store
    Login with user "standard_user" and password "secret_sauce"
    Add the product "t-shirt" in the cart
    Verify that there are the product "Sauce Labs Bolt T-Shirt" in the cart
    Remove the product from the cart
    The cart should be empty

### EXERCÍCIO
# Caso de Teste com PO 02: Adicionar Cliente
#     Acessar a página home do site
#     Clicar em "Sign in"
#     Informar um e-mail válido
#     Clicar em "Create an account"
#     Preencher os dados obrigatórios
#     Submeter cadastro
#     Conferir se o cadastro foi efetuado com sucesso
