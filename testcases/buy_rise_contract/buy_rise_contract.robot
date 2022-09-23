*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${login_button}  //button[@id='dt_login_button']
${login_form_button}  //button[@type='submit']
${email_field}  //input[@id='txtEmail']
${email}
${password_field}  //input[@id='txtPass']
${password}  
${account_info}  //div[@id='dt_core_account-info_acc-info']
${real_tab}  //li[@id='real_account_tab']
${purchase_call_button}  //button[@id='dt_purchase_call_button']
${demo_tab}  //li[@id='dt_core_account-switcher_demo-tab']

*** Keywords ***
Login To Deriv
    Open Browser  https://app.deriv.com  chrome
    Maximize Browser Window
    Wait Until Page Contains Element  ${purchase_call_button}  200
    Click Element  ${login_button} 
    Wait Until Page Contains Element  ${email_field}  200
    Input Text  ${email_field}  ${email}
    Input Text  ${password_field}  ${password}
    Click Element  ${login_form_button}
    Wait Until Page Contains Element  ${purchase_call_button}  200

Check the Current Account Lands on Real Account
    Click Element  ${account_info}
    Page Should Contain Element  ${real_tab}

Switch to Virtual Account and Verify Virtual Account is Displayed
    Click Element  ${demo_tab}
    Page Should Contain Element  //*[contains(text(),'Demo') and .//div[contains(@class, 'acc-switcher__loginid-text')]]
    Click Element  //div[contains(@class, 'acc-switcher__accounts')]
    Wait Until Page Contains Element  //span[contains(@class, 'trade-container__price-info-currency')]  200

Buy Rise Contract
    Wait Until Page Contains Element  ${account_info}  200
    Click Element  ${account_info}
    Click Element  //div[@class='cq-symbol-select-btn']
    # Wait Until Page Contains Element  //div[contains(text(), 'Volatility 10 (1s) Index') and @class='sc-mcd__item__name']  200
    # Click Element  //div[contains(text(), 'Volatility 10 (1s) Index') and @class='sc-mcd__item__name']
    Sleep    2
    Wait Until Page Contains Element  //div[contains(@class, 'sc-mcd__item sc-mcd__item--1HZ10V ')]  200 
    Click Element  //div[contains(@class, 'sc-mcd__item sc-mcd__item--1HZ10V ')]
    Sleep    2
    Wait Until Page Contains Element  //span[contains(@class, 'trade-container__price-info-currency')]  200
    Click Element  //div[@data-testid='dt_contract_dropdown']
    Wait Until Page Contains Element  //div[@id='dt_contract_rise_fall_item']  200
    Click Element  //div[@id='dt_contract_rise_fall_item']
    Wait Until Page Contains Element  //div[@id='dt_purchase_call_price']  200
    Click Element  //button[@id='dc_t_toggle_item']
    ${status}=    Run Keyword And Return Status  Page Should Contain Element    //span[@data-testid='tick_step_5' and contains(@class,"active")]
    IF  ${status} is False
        Click Element    //span[@data-testid='tick_step_5']       
    END   
    Click Element  //button[@id='dc_stake_toggle_item']
    Press Keys  //input[@id='dt_amount_input']  CTRL+a+BACKSPACE
    Input Text  //input[@id='dt_amount_input']  10
    Wait Until Page Contains Element  //span[contains(@class, 'trade-container__price-info-currency')]  200
    Click Element  ${purchase_call_button}


*** Test Cases ***
Buy Rise Contract
    Login To Deriv
    Check the Current Account Lands on Real Account
    Switch to Virtual Account and Verify Virtual Account is Displayed
    Buy Rise Contract
    