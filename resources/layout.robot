*** Settings ***
Resource    ../config.robot
Resource    log.robot

*** Keywords ***
Valida Numero Campos
    [Arguments]    ${campos}    ${num_esperado}
    ${num_obtido}    Get Length    ${campos}
    Run Keyword And Continue On Failure    Should Be Equal As Integers    first    second