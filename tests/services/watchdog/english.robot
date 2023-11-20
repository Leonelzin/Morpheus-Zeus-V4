*** Settings ***
Library             Browser
Resource            ../../../resources/common.resource
Resource            ../../../resources/fiber.resource
Resource            ../../../resources/pages/services/watchdog.resource

Suite Setup         Run keywords
...                     Setup browser    url=${DUT_LOGIN_WEBPAGE_URL}
...                     AND    Set Viewport Size    1000    950
...                     AND    Login to DUT (English)
...                     AND    Go to DUT watchdog webpage
Test Teardown       Run keyword if test failed
...                     Run keywords
...                     Clear browser storages
...                     Login to DUT (English)
...                     Go to DUT watchdog webpage

Force Tags          lang-en   watchdog    smoke    header


*** Test Cases ***
Watchdog page title is visible
    Get Text    
    ...    ${WATCHDOG_PAGE_TITLE}    
    ...    ==    
    ...    Watchdog
    Get Text    
    ...    ${WATCHDOG_PAGE_SUBTITLE}    
    ...    ==    
    ...    Timer that triggers a system check in seconds due to supposed error condition.\n
 
Validating Toggle on the Watchdog page
    Watchdog toggle should not be enable
    Get Text    
    ...    ${WATCHDOG_PAGE_TOGGLE_TEXT}    
    ...    ==    
    ...    Enable Watchdog
   
Watchdog Address 1 is not editable
    Address 1 input should be disabled
    Get Text    
    ...    ${WATCHDOG_PAGE_ADDRESS_1_TEXT}    
    ...    ==    
    ...    Address 1
    Get Text    
    ...    ${WATCHDOG_PAGE_ADDRESS_1_INPUT}    
    ...    ==    
    ...    192.168.1.1

Watchdog Address 2 is not editable
    Address 2 input should be disabled
    Get Text    
    ...    ${WATCHDOG_PAGE_ADDRESS_2_TEXT}    
    ...    ==    
    ...    Address 2
   
Watchdog time is not editable
    Time 'seconds' input should be disabled
    Get Text    
    ...    ${WATCHDOG_PAGE_CHECK_TIME_TEXT}    
    ...    ==    
    ...    Check time (seconds)
    Get Text    
    ...    ${WATCHDOG_PAGE_CHECK_TIME_INPUT}    
    ...    ==    
    ...    30
    
Validating placeholder inputs with watchdog toggle enabled
    Enable Toggle Watchdog

    Clear Text    
    ...    ${WATCHDOG_PAGE_ADDRESS_1_INPUT}
    Get attribute    
    ...    ${WATCHDOG_PAGE_ADDRESS_1_INPUT}    
    ...    placeholder    
    ...    ==    
    ...    Domain or IP address

    Get attribute    
    ...    ${WATCHDOG_PAGE_ADDRESS_2_INPUT}    
    ...    placeholder    
    ...    ==    
    ...    Domain or IP address
 
    Clear Text    
    ...    ${WATCHDOG_PAGE_CHECK_TIME_INPUT}
    Get attribute    
    ...    ${WATCHDOG_PAGE_CHECK_TIME_INPUT}    
    ...    placeholder    
    ...    ==    
    ...    20 to 99999

Watchdog button is visible
    View element state    
    Get Text    
    ...    ${WATCHDOG_PAGE_SAVE_BUTTON_TEXT}    
    ...    ==    
    ...    SAVE
