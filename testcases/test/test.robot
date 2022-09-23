*** Settings ***
Library    SeleniumLibrary


*** Test Cases ***
Open Deriv
     Open Browser    https://www.deriv.com    chrome
     Close Browser
