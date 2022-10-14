*** Settings ***
Resource    ../resources/dependencies.robot

*** Keywords ***
Valida ini_arquivo
    [Arguments]    &{data}
    # Leitura do ini_arquivo do Layout
    &{json_obj}    Load JSON from file    layout/${data}[layout_origem].json
    # ${fields}    Get values from JSON    ${json_obj}    $.records[0].fields[0].description
    @{layout_campos}    Get values from JSON    ${json_obj}    $.records[0].fields[*]

    Valida Numero Campos    ${layout_campos}    ${data}[ini_arquivo_num_campos]

    # Arquivo alvo da validação
    ${ini_arquivo}    Ler ini_arquivo    ${data}[txt_origem]
    Valida Campos ini_arquivo    ${layout_campos}    ${ini_arquivo} 