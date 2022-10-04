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
    [Arguments]    ${layout_campo}    ${row_ini_arquivo}

    IF    "${layout_campo.description}" == "CODIGO DO BANCO NA COMPENSACAO"
        Log Console And Report    *** Início validação do campo CODIGO DO BANCO NA COMPENSACAO

        ${start_position}    Set Variable    ${layout_campo.start_position}
        ${start_position}    Evaluate    ${start_position} - 1
        ${length}    Set Variable    ${layout_campo.length}
        ${campo_1}    Get Substring    ${row_ini_arquivo}    ${start_position}    ${length}

        IF    "${campo_1}" == "${layout_campo.default}"
            Passed Log    *** Campo um validado com sucesso!
        ELSE
            Failure Log    *** Campo diferente do esperado! | Valor Obtido: ${campo_1} | Valor Esperado: ${layout_campo.default}
        END

        Log Console And Report    *** Fim validação do campo CODIGO DO BANCO NA COMPENSACAO

    ELSE IF    "${layout_campo.description}" == "USO EXCLUSIVO FEBRABAN / CNAB"
        Log Console And Report    *** Início validação do campo USO EXCLUSIVO FEBRABAN / CNAB

        ${start_position}    Set Variable    ${layout_campo.start_position}
        ${start_position}    Evaluate    ${start_position} - 1
        ${length}    Set Variable    ${layout_campo.length}
        ${campo_1}    Get Substring    ${row_ini_arquivo}    ${start_position}    ${length}

        IF    "${campo_1}" == "${layout_campo.default}"
            Passed Log    *** Campo um validado com sucesso!
        ELSE
            Failure Log    *** Campo diferente do esperado! | Valor Obtido: ${campo_1} | Valor Esperado: ${layout_campo.default}
        END

        Log Console And Report    *** Fim validação do campo USO EXCLUSIVO FEBRABAN / CNAB
    ELSE
        Failure Log    *** Campo Description: ${layout_campo.description} não existe!
    END

# Valida Itens Campo ini_arquivo
#     [Arguments]    ${layout_campo}    ${row_ini_arquivo}
    
    