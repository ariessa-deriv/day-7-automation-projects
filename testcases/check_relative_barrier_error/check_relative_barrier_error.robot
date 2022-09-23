*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${login_button}  //button[@id='dt_login_button']
${login_form_button}  //button[@type='submit']
${email_field}  //input[@id='txtEmail']
${email}  ariessa+67@besquare.com.my
${password_field}  //input[@id='txtPass']
${password}  
${account_info}  //div[@id='dt_core_account-info_acc-info']
${real_tab}  //li[@id='real_account_tab']
${purchase_call_button}  //button[@id='dt_purchase_call_button']
${purchase_put_button}  //button[@id='dt_purchase_put_button']
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

Check Relative Barrier Error
    Wait Until Page Contains Element  ${account_info}  200
    Click Element  ${account_info}
    Click Element  //div[@class='cq-symbol-select-btn']
    Sleep    2
    Wait Until Page Contains Element  //div[contains(text(), 'Forex') and contains(@class, 'sc-mcd__filter__item ')]  200 
    Click Element  //div[contains(text(), 'Forex') and contains(@class, 'sc-mcd__filter__item ')]
    Wait Until Page Contains Element  //div[contains(@class, 'sc-mcd__item sc-mcd__item--frxAUDUSD ')]  200 
    Click Element  //div[contains(@class, 'sc-mcd__item sc-mcd__item--frxAUDUSD ')]
    Sleep    2
    Wait Until Page Contains Element  //div[@data-testid='dt_contract_dropdown']  200
    Click Element  //div[@data-testid='dt_contract_dropdown']
    Sleep    2
    Wait Until Page Contains Element  //div[@id='dt_contract_high_low_item']  200
    Click Element  //div[@id='dt_contract_high_low_item']
    Sleep    2
    Click Element  //button[@id='dc_duration_toggle_item']
    Sleep    2
    Press Keys  //input[@class='dc-input__field' and @name='duration']  CTRL+a+BACKSPACE
    Input Text  //input[@class='dc-input__field' and @name='duration']  4
    Press Keys  //input[@id='dt_barrier_1_input']  CTRL+a+BACKSPACE
    Input Text  //input[@id='dt_barrier_1_input']  +0.1
    Click Element  //button[@id='dc_payout_toggle_item']
    Press Keys  //input[@id='dt_amount_input']  CTRL+a+BACKSPACE
    Input Text  //input[@id='dt_amount_input']  10
    Wait Until Page Contains Element  //span[contains(text(), 'Contracts more than 24 hours in duration would need an absolute barrier.')]  200
    Element Should Be Disabled  ${purchase_put_button}


*** Test Cases ***
Check Relative Barrier Error
    Login To Deriv
    Check the Current Account Lands on Real Account
    Switch to Virtual Account and Verify Virtual Account is Displayed
    Check Relative Barrier Error
    