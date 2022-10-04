*** Settings ***
Resource    ../config.robot
Resource    log.robot

*** Keywords ***
Ler ini_arquivo
    [Arguments]    ${arquivo}
    ${obj_txt}    Get File    files/input/${arquivo}.txt
    ${linha_ini_arquivo}    Get Line    ${obj_txt}    0
    [Return]    ${linha_ini_arquivo}