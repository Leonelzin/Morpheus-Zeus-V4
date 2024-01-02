*** Settings ***
Library             Browser
Resource            ../../../resources/common.resource
Resource            ../../../resources/fiber.resource
Resource            ../../../resources/pages/network/operation_mode.resource

Suite Setup         Run keywords
...                     Setup browser    url=${DUT_LOGIN_WEBPAGE_URL}
...                     AND    Login to DUT    language=english
...                     AND    Access Operation Mode network settings page
Test Teardown       Run keyword if test failed
...                     Run keywords
...                     Clear browser storages
...                     AND    Login to DUT    language=english
...                     AND    Access Operation Mode network settings page

Force Tags          lang-en    operation-mode


*** Test Cases ***
Factory default settings are correct
    [Tags]    robot:continue-on-failure    smoke
    Page inner title should be "Operation mode"
    Page inner subtitle should be "Bridge: interconnects all network interfaces, single IP address.\nRouter: operates as an access point, managing IP addresses."

    ${str}    Get Text    xpath=/html/body/div/div[3]/div/div[2]/div 
    @{str_list}    Split String    ${str}    \n
    Log To Console    ${str_list}
    Log To Console    ${str_list}[0]
    Equipment name input should be enabled 
    Equipment name should be "ap1800ax"
 
    Network operation select title should be "Network operation"
    Network operation select option should be "Bridge"

    Save settings button text should be "SAVE"

Two Network operation are available: Bridge and Router
    [Tags]    robot:continue-on-failure    smoke
    There should be "2" network operation available
    Network Operation "Bridge" should be available
    Network Operation "Router" should be available

Validate form interaction after select network operation
    [Tags]    robot:continue-on-failure    smoke
    Operation NAT toggle switch text should be "Enable NAT"
    Operation NAT toggle switch should be on
