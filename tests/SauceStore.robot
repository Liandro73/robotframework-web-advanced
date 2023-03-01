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

Test Case 02 with Page Object: create an order
    Go to homepage Sauce Demo - Store
    Login with user "standard_user" and password "secret_sauce"
    Add the product "t-shirt" in the cart
    Verify that there are the product "Sauce Labs Bolt T-Shirt" in the cart
    Go to checkout
    Fill the checkout information and continue
    Finish the order
    The order should be completed and this message should be visible "Thank you for your order!"