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

Check Multiple Contract Parameter
    Wait Until Page Contains Element  ${account_info}  200
    Click Element  ${account_info}

    # Click on Markets dropdown
    Click Element  //div[@class='cq-symbol-select-btn']
    Sleep    2

    # Click on Synthetic Indices
    Wait Until Page Contains Element  //div[contains(text(), 'Synthetic Indices') and contains(@class, 'sc-mcd__filter__item ')]  200 
    Click Element  //div[contains(text(), 'Synthetic Indices') and contains(@class, 'sc-mcd__filter__item ')]

    # Click on Volatility 50 Index
    Wait Until Page Contains Element  //div[contains(@class, 'sc-mcd__item sc-mcd__item--R_50 ')]  200 
    Click Element  //div[contains(@class, 'sc-mcd__item sc-mcd__item--R_50 ')]
    Sleep    2

    # Check if there is notification. If true, close notification
    ${status}=    Run Keyword And Return Status  Page Should Contain Element    //button[@class='notification__close-button']
    IF  ${status} is True
        Click Element    //button[@class='notification__close-button']       
    END 

    # Click on Trade types dropdown
    Wait Until Page Contains Element  //div[@data-testid='dt_contract_dropdown']  200
    Click Element  //div[@data-testid='dt_contract_dropdown']
    Sleep    2

    # Click on Multiplier
    Wait Until Page Contains Element  //div[@id='dt_contract_multiplier_item']  200
    Click Element  //div[@id='dt_contract_multiplier_item']
    Sleep    2

    # Only stake is allowed. Should not have payout option
    Wait Until Page Contains Element  //div[@class='trade-container__fieldset-header trade-container__fieldset-header--inline']  200
    
    # Only deal cancellation or take profit / stop loss is allowed
    Wait Until Element Is Visible  //label[contains(.,'Stop loss')]/span[@class='dc-checkbox__box']  200
    Checkbox Should Not Be Selected  //label[contains(.,'Stop loss')]/span[@class='dc-checkbox__box']
    Select Checkbox  //label[contains(.,'Stop loss')]/span[@class='dc-checkbox__box']
    Checkbox Should Be Selected  //label[contains(.,'Stop loss')]/span[@class='dc-checkbox__box']
    Wait Until Element Is Visible  //input[@id='dt_cancellation-checkbox_input'] 200
    Select Checkbox  //input[@id='dt_cancellation-checkbox_input']
    Checkbox Should Be Selected  //input[@id='dt_cancellation-checkbox_input']

    # Check multiplier value selection should have x20, x40, x60, x100, x200
    Click Element  //div[@id='dropdown-display']
    Page Should Contain Element  //div[@id='20')]
    Page Should Contain Element  //div[@id='40')]
    Page Should Contain Element  //div[@id='60')]
    Page Should Contain Element  //div[@id='100')]
    Page Should Contain Element  //div[@id='120')]


*** Test Cases ***
Check Multiple Contract Parameter
    Login To Deriv
    Check the Current Account Lands on Real Account
    Switch to Virtual Account and Verify Virtual Account is Displayed
    Check Multiple Contract Parameter
    