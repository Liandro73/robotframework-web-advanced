*** Settings ***
Resource               ../resources/Resource.robot
Resource               ../resources/pageobjects/Login.robot
Resource               ../resources/pageobjects/Product.robot
Resource               ../resources/pageobjects/Cart.robot
Test Setup             Setup
Test Teardown          Tear Down

*** Test Case ***
Test Case 01 with Page Object: remove cart's products
    [Documentation]    Validate that be possible to remove products from cart
    [Tags]             smoketest
    Login.Go to homepage Sauce Demo - Store
    Login.Login with user "standard_user" and password "secret_sauce"
    Product.Add the product "T-shirt" in the cart
    Cart.Verify that there are the product "Sauce Labs Bolt T-Shirt" in the cart
    Cart.Remove the product from the cart
    Cart.The cart should be empty

Test Case 02 with Page Object: create an order
    [Documentation]    Validate that be possible to complete an order
    [Tags]             smoketest
    Login.Go to homepage Sauce Demo - Store
    Login.Login with user "standard_user" and password "secret_sauce"
    Product.Add the product "T-shirt" in the cart
    Cart.Verify that there are the product "Sauce Labs Bolt T-Shirt" in the cart
    Cart.Go to checkout
    Cart.Fill the checkout information and continue
    Cart.Finish the order
    Cart.The order should be completed and this message should be visible "Thank you for your order!"