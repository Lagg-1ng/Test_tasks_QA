*** Settings ***
Library    Process    #built-in library
Library    SerialLibrary    #external 3rd-party library

Test Setup    Run Keywords
...           Open Serial Port

Test Teardown    Delete All Ports

*** Variables ***
${esp32_dev_path}    /dev/ttyUSB0    #dev path for serial communication

*** Test Cases ***

Test LED Switch Off
    Turn LED Off
    ${led_state_gpio}=    Get LED State
    Should Be Equal As Integers    ${led_state_gpio}    0

Test LED Switch On
    Turn LED On
    ${led_state_gpio}=    Get LED State
    Should Be Equal As Integers    ${led_state_gpio}    1

*** Keywords ***
Turn LED On
    Write Data    0x31    #0x31 is ascii '1'

Turn LED Off
    Write Data    0x30    #0x31 is ascii '0'

Get LED State
    ${result}=    Run Process    gpio    read    0
    Log    all output: ${result.stdout}
    [Return]    ${result.stdout}

Open Serial Port
    Add Port   ${esp32_dev_path}
    ...        baudrate=115200
    ...        bytesize=8
    ...        parity=N
    ...        stopbits=1
    ...        timeout=999
    ...    

#Ру версия

*** Settings ***
Suite Setup    Log    Suite setup           # Запускается перед тест-сьютом
Suite Teardown    Log    Suite teardown     # Запускается после тест-сьюта
Test Setup    Log    Test setup             # Запускается перед тест-кейсом
Test Teardown    Log    Test teardown       # Запускается после тест-кейса

*** Test Cases ***
Test Case Pass Example    # Пример успешного тест-кейса
    ${hello_world}=    Set Variable    Hello    # Встроенное ключевое слово Set Variable для создания переменной
    ${hello_world}=    Add Word To String  ${hello_world}  world    # Кастомное ключевое слово для добавления слова к строке
    Should Be Equal As Strings  ${hello_world}    Hello world    # Сравнение строк, в данном случае возвращает Pass

Test Case Fail Example    # Пример зафейленного тест-кейса
    ${hello_world}=    Set Variable    Goodbye
    ${hello_world}=    Add Word To String  ${hello_world}  world
    Should Be Equal As Strings  ${hello_world}    Hello world    # Сравнение строк, в данном случае возвращает Fail

*** Keywords ***
Add Word To String    # Новое ключевое слово
    [Arguments]    ${string}    ${word}    # Принимает на входе два аргумента
    ${string}=  Catenate    ${string}   ${word}    # Встроенное ключевое слово для соединения строк
    [Return]    ${string}    # Возвращает строку с добавленным словом

    