*** Settings ***
Resource    ../resources/dependencies.robot

*** Keywords ***
Valida ini_arquivo
    [Arguments]    &{data}
    &{json_obj}    Load JSON from file    layout/${data}[layout_origem].json
    # ${fields}    Get values from JSON    ${json_obj}    $.records[0].fields[0].description
    @{fields}    Get values from JSON    ${json_obj}    $.records[0].fields[*]

    Valida Numero Campos    ${fields}    ${data}[ini_arquivo_num_campos]

    ${row_ini_arquivo}    Ler ini_arquivo    ${data}[txt_origem]

    ${num_field}    Set Variable    ${1}

    FOR    ${field}    IN    @{fields}
        Valida Campos ini_arquivo    ${field}    ${row_ini_arquivo} 
        # Log To Console    Campo Nº ${num_field}: ${field.default}
        # # Log To Console    ${field.description}
        # ${num_field}    Evaluate    ${num_field} + 1
    END