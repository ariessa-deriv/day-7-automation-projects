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

*** Test Cases ***
Login To Deriv
    Open Browser  https://app.deriv.com  chrome
    Maximize Browser Window
    Wait Until Page Contains Element  ${login_button}  60
    Click Element  ${login_button} 
    Wait Until Page Contains Element  ${email_field}  50
    Input Text  ${email_field}  ${email}
    Input Text  ${password_field}  ${password}
    Click Element  ${login_form_button}
    Wait Until Page Contains Element  ${account_info}  30