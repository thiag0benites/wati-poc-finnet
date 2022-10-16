*** Settings ***
Resource    ../resources/dependencies.robot

*** Keywords ***
Valida ini_arquivo
    [Arguments]    &{data}
    # Leitura do layout
    &{json_obj}    Load JSON from file    layout/${data}[layout_origem].json
    
    # Leitura dos campos ini_arquivo do layout (linha 1 do arquivo origem)
    @{layout_campos_ini_arquivo}    Get values from JSON    ${json_obj}    $.records[0].fields[*]
    # Valida numero de campos gerenciador = layout
    Valida Numero Campos    ${layout_campos_ini_arquivo}    ${data}[ini_arquivo_num_campos]

    # Arquivo alvo da validação
    ${origem_ini_arquivo}    Ler ini_arquivo    ${data}[arquivo_origem]
    Valida Campos ini_arquivo    ${layout_campos_ini_arquivo}    ${origem_ini_arquivo} 
    

Valida ini_lote
    [Arguments]    &{data}
    # Leitura do layout
    &{json_obj}    Load JSON from file    layout/${data}[layout_origem].json

    # Leitura dos campos ini_lote do layout (linha 2 do arquivo origem)
    @{layout_campos_ini_lote}    Get values from JSON    ${json_obj}    $.records[1].fields[*]

    Valida Numero Campos    ${layout_campos_ini_lote}    ${data}[ini_lote_num_campos]
    # Arquivo alvo da validação
    ${origem_ini_lote}    Ler ini_arquivo    ${data}[arquivo_origem]
    Valida Campos ini_lote    ${layout_campos_ini_lote}    ${origem_ini_lote}