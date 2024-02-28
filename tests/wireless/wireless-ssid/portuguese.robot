*** Settings ***
Library             Browser
Library             String
Resource            ../../../resources/common.resource
Resource            ../../../resources/fiber.resource
Resource            ../../../resources/pages/wireless/wireless_ssid.resource
Resource            ../../../resources/pages/network/operation_mode.resource


Suite Setup         Run keywords
...                     Setup browser    url=${DUT_LOGIN_WEBPAGE_URL}
...                     AND    Login to DUT    language=portuguese
...                     AND    Access Wireless SSID settings page
Test Teardown       Run keyword if test failed
...                     Run keywords
...                     Clear browser storages
...                     AND    Login to DUT    language=portuguese
...                     AND    Access Wireless SSID settings page

Force Tags          lang-pt    wireless-ssid    open-system


*** Test Cases ***
Factory Default settings for Wireless SSID are correct
    [Tags]    robot:continue-on-failure    smoke
    Page inner title Wireless SSID should be "Wireless SSID"
    Page inner subtitle Wireless SSID should be "Adicione, edite ou exclua as redes selecionadas"
    
    Add SSID settings button should be visible in table
    Add SSID settings button text should be "Adicionar"
    
    Wireless SSID table should be visible

    SSID header should be "Nome da Rede (SSID)" in table
    SSID should be "AP5400AX_7069" in table

    Frequency header should be "Frequência" in table
    Frequency should be "Dual band" in table

    Delete header should be visible in table

    Add SSID in table
    
    Page inner subtitle add new network should be "Adicionar nova rede"
    
    SSID input title should be "Nome da Rede (SSID)"
    SSID input text should be ""
    SSID placeholder should be "Nome da Rede (SSID)"
    SSID input should be enabled

    Authentication SSID title should be "Autenticação"
    Authentication SSID select should be enabled

    Open Authentication SSID selection dropdown menu
    Select Authentication SSID "Sistema Aberto"

    Frequency toggle text should be "Dual band"
    Frequency toggle should be enabled
    
    Advanced setting title should be "Configuração avançada"

    Isolate SSID checkbox text should be "Isolar SSID"
    Isolate SSID checkbox should be disabled

    Only Internet checkbox text should be "Somente Internet"
    Only Internet checkbox should be disabled

    Hide SSID checkbox text should be "Ocultar SSID"
    Hide SSID checkbox should be disabled

    Isolate customers checkbox text should be "Isolar clientes"
    Isolate customers checkbox should be disabled

    VLAN toggle text should be "VLAN"
    VLAN toggle should be disabled

    ACL title should be "Modo de controle de acesso"
    ACL select should be enabled

    Open ACL selection dropdown menu
    Select ACL "Disabled"

    Slider title for clients connected on the 2.4GHz frequency should be "Máximo de clientes conectados 2.4 GHz\n1\n128"
    Slider clients connected on the 2.4GHz frequency should be visible
    Slider input for clients connected on the 2.4GHz frequency should be "128"
    Slider input for clients connected on the 2.4GHz frequency should be enabled

    Minimum value of the slider for 2.4GHz clients connected should be 1
    Maximum value of the slider for 2.4GHz clients connected should be 128

    Slider title for clients connected on the 5GHz frequency should be "Máximo de clientes conectados 5 GHz\n1\n128"
    Slider input for clients connected on the 5GHz frequency should be "128"
    Slider input for clients connected on the 5GHz frequency should be enabled
    Slider clients connected on the 5GHz frequency should be visible

    Minimum value of the slider for 5GHz clients connected should be 1
    Maximum value of the slider for 5GHz clients connected should be 128

    Slider title for clients signal dBm should be "Mínimo de sinal do cliente (dBm)\n-100\n-20"
    Slider clients signal dBm should be visible
    Slider input for clients signal dBm should be "-90"
    Slider input for clients signal dBm should be enabled

    Minimum value of the slider for clients signal dBm should be -100
    Maximum value of the slider for clients signal dBm should be -20

    Add New Network settings button text should be "ADICIONAR NOVA REDE"
    Cancel settings button text should be "CANCELAR"
    [Teardown]    No operation

Validation of elements factory default with SSID on 2.4GHz and 5GHz frequencies
    [Tags]    robot:continue-on-failure    smoke
    Disable Frequency toggle
    
    Frequency 2.4GHz checkbox text should be "2.4 GHz"
    Frequency 2.4GHz checkbox should be visible
    Frequency 2.4GHz checkbox should be enabled

    Slider input for clients connected on the 2.4GHz frequency should be visible
    Slider clients connected on the 2.4GHz frequency should be visible

    Frequency 5GHz checkbox text should be "5 GHz"
    Frequency 5GHz checkbox should be visible
    Frequency 5GHz checkbox should be disabled

    Slider input for clients connected on the 5GHz frequency should be not visible
    Slider clients connected on the 5GHz frequency should be not visible
    [Teardown]    No operation

Validation of elements factory default when the VLAN toggle is enabled
    [Tags]    robot:continue-on-failure    smoke
    Enable VLAN toggle

    Slider input VLAN should be "2"
    Slider VLAN should be visible
    Slider input VLAN should be enabled

    Minimum value of the slider VLAN should be 1
    Maximum value of the slider VLAN should be 4094
    [Teardown]    No operation

Validation of ACL rules when allowing and blocked listed
    [Tags]    smoke
    [Documentation]    Attention, the equipment allowing and blocking options contain the same elements to be checked, so there is no need to map test cases for both.
    Open ACL selection dropdown menu
    Select ACL "Permitir Listados"
    
    Add ACL rule in table
    Add settings ACL rules button text should be "Modo de controle de acesso\nAdicionar"
    Add settings ACL rules button should be visible in table

    Wireless SSID ACL table should be visible

    Description header should be visible in table
    Description header should be "Descrição" in table
    Description input text should be ""
    Description input should be enabled

    MAC header should be visible in table
    MAC header should be "MAC" in table
    MAC input text should be ""
    MAC input should be enabled

    Delete settings ACL rules button should be visible in table
    
Five Wireless SSID Authentication are available: Open System, WPA-PSK, WPA2-PSK, WPA & WPA2
    [Tags]    smoke
    There should be "5" authentication SSID available
    Authentication SSID "Sistema Aberto" should be available
    Authentication SSID "WPA-PSK" should be available
    Authentication SSID "WPA2-PSK" should be available
    #Authentication SSID "WPA" should be available
    #Authentication SSID "WPA2" should be available
    [Teardown]    No operation

Three ACL rules are available: Disabled, Allow Listings & Listed Blocks
    [Tags]    smoke
    There should be "3" ACL available
    ACL "Desativado" should be available
    ACL "Permitir Listados" should be available
    ACL "Bloquear Listados" should be available
    [Teardown]    No operation