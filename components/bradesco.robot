*** Settings ***
Resource    ../resources/dependencies.robot

*** Keywords ***
Le Arquivo
    [Arguments]    &{data}
    ${txt_obj}    Get File    files/input/${data}[txt_origem].txt
    ${line}    Get Line    ${txt_obj}    0
    Log To Console    ${line}

valida ini_arquivo
    [Arguments]    &{data}
    &{json_obj}    Load JSON from file    layout/${data}[layout_origem].json
    # ${fields}    Get values from JSON    ${json_obj}    $.records[0].fields[0].description
    @{fields}    Get values from JSON    ${json_obj}    $.records[0].fields[*]
    # Log To Console    ${fields}
    # Log To Console    ${fields}
    # ${size}    Get Length    ${fields}
    # Log To Console    N Campos: ${size}

    ${num_field}    Set Variable    ${1}

    FOR    ${field}    IN    @{fields}
        Log To Console    Campo Nº ${num_field}: ${field.default}
        # Log To Console    ${field.description}
        ${num_field}    Evaluate    ${num_field} + 1
    END