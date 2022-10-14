*** Settings ***
Resource    ../config.robot
Resource    log.robot

*** Keywords ***
Valida Numero Campos
    [Documentation]    Keyword compara número de campos obtidos com esperado.
    ...                ${campos} - Recebe lista com conteúdo dos campos.
    ...                ${num_esperado} - Número esperado de campos para comparação.
    [Arguments]    ${campos}    ${num_esperado}

    ${num_obtido}    Get Length    ${campos}

    Log Console And Report    *** Nº Campo(s) Obtido(s): ${num_obtido} | Nº Campo(s) Esperado(s): ${num_esperado}

    IF    ${num_obtido} == ${num_esperado}
        Passed Log    *** Nº de campo(s) igual ao esperado!
    ELSE
        Failure Log    *** Nº de campo(s) diferente do esperado!
    END

Valida Campos ini_arquivo
    [Documentation]    Percorre campos do ini_arquivo validando:
    ...                - Tamnho do campo (length);
    ...                - Valor padrão (default).
    [Arguments]    ${layout_campos}    ${ini_arquivo}

    FOR    ${layout_campo}    IN    @{layout_campos}
        ${start_position}    Set Variable    ${layout_campo.start_position}

        # IF    "${layout_campo.description}" == "CODIGO DO BANCO NA COMPENSACAO"    
            ${start_position}    Evaluate    ${start_position} - 1
        # END

        ${length}    Evaluate    ${start_position} + ${layout_campo.length}
        ${campo_ini_arquivo}    Get Substring    ${ini_arquivo}    ${start_position}    ${length}

        IF    "${layout_campo.default}" == "None"
            ${campo_ini_arquivo}    Set Variable    None 
        END

        IF    "${campo_ini_arquivo}" == "${layout_campo.default}"
            Passed Log    *** ${layout_campo.description} validado com sucesso!
        ELSE
            Failure Log    *** ${layout_campo.description} diferente do esperado! | Valor Obtido: ${campo_ini_arquivo} | Valor Esperado: ${layout_campo.default}
        END
    END