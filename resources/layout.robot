*** Settings ***
Resource    ../config.robot
Resource    log.robot
Library    XML

*** Keywords ***
Valida Numero Campos
    [Documentation]    Keyword compara número de campos obtidos com esperado.
    ...                ${campos} - Recebe lista com conteúdo dos campos.
    ...                ${num_esperado} - Número esperado de campos para comparação.
    [Arguments]    ${campos}    ${num_esperado}

    ${num_obtido}    Get Length    ${campos}

    Log To Console    ************************************************
    Log Console And Report    *** Nº Campo(s) Obtido(s): ${num_obtido} | Nº Campo(s) Esperado(s): ${num_esperado}

    IF    ${num_obtido} == ${num_esperado}
        Passed Log    *** Nº de campo(s) igual ao esperado!
    ELSE
        Failure Log    *** Nº de campo(s) diferente do esperado!
    END

Valida Campos ini_arquivo
    [Documentation]    Percorre campos do ini_arquivo validando:
    ...                - Tamanho do campo (length);
    ...                - Formato do valor padrão (default);
    ...                - Valor padrão (default).
    [Arguments]    ${layout_campos}    ${ini_arquivo}

    ${num_campo}    Set Variable    1
    Log Console And Report    *** VALIDACAO INI_ARQUIVO ***

    FOR    ${layout_campo}    IN    @{layout_campos}
        Log Console And Report    ************************************************
        Log Console And Report    DESCRIPTION: ${layout_campo.description}
        Log Console And Report    Campo Nº ${num_campo}

        ${start_position}    Set Variable    ${layout_campo.start_position}
        ${start_position}    Evaluate    ${start_position} - 1

        ${length}    Evaluate    ${start_position} + ${layout_campo.length}
        ${campo_ini_arquivo}    Get Substring    ${ini_arquivo}    ${start_position}    ${length}

        # Caso o campo default do layout igual a null
        IF    "${layout_campo.default}" == "None"
            ${campo_ini_arquivo}    Set Variable    None 
        END

        # Valida tamanho do compo pelo formato definido no campo "format" do layout
        #IF    "${layout_campo.format}" == "DDMMYYYY" OR "${layout_campo.format}" == "hhmmss"
        IF    '${layout_campo.format}' == 'None'
            Log Console And Report    ---
            Passed Log    FORMAT passou!
            Log Console And Report    LAYOUT: None
           
        ELSE IF    '${layout_campo.format}' == 'DDMMYYYY' or '${layout_campo.format}' == 'hhmmss'
            # Verifica se o campo do ini_arquivo e numerico
            ${e_numero}    ${valor}   Run Keyword And Ignore Error    Convert To Number    ${campo_ini_arquivo}
            
            # Captura tamanho dos campos FORMAT do layout e ini_arquivo
            ${tamanho_string_layout}    Get Length    ${layout_campo.format}
            ${tamanho_string_ini_arquivo}    Get Length    ${campo_ini_arquivo}
 
            # Compara tamanho dos campos FORMAT do layout / ini_arquivo
            IF    ${tamanho_string_layout} == ${tamanho_string_ini_arquivo} and '${e_numero}' == 'PASS'
                Log Console And Report    ---
                Passed Log    FORMAT ${layout_campo.format} passou!
                Log Console And Report    LAYOUT: ${tamanho_string_layout} posicoes | E numerico
                Log Console And Report    INI_ARQUIVO: ${tamanho_string_layout} posicoes | E numerico 

            ELSE IF    ${tamanho_string_layout} == ${tamanho_string_ini_arquivo} and '${e_numero}' == 'FAIL' or_
                       ${tamanho_string_layout} != ${tamanho_string_ini_arquivo} and '${e_numero}' == 'FAIL'

                Failure Log    FORMAT ${layout_campo.format} falhou!
                Log Console And Report    ---
                Log Console And Report    FORMAT ${layout_campo.format} falhou!
                Log Console And Report    LAYOUT: ${tamanho_string_layout} posicoes | Nao e numerico
                Log Console And Report    INI_ARQUIVO: ${tamanho_string_layout} posicoes | Nao e numerico

            ELSE IF    ${tamanho_string_layout} != ${tamanho_string_ini_arquivo} and '${e_numero}' == 'PASS'
                Failure Log    FORMAT ${layout_campo.format} falhou!
                Log Console And Report    ---
                Log Console And Report    FORMAT ${layout_campo.format} falhou!
                Log Console And Report    LAYOUT: ${tamanho_string_layout} posicoes | E numerico
                Log Console And Report    INI_ARQUIVO: ${tamanho_string_layout} posicoes | E numerico
            END
        
        ELSE
            Log Console And Report    ---
            Passed Log    FORMAT passou!
            Log Console And Report    LAYOUT: ${layout_campo.format}
        END

        # Compara valor do campo default do layout com o valor do arquivo
        IF    "${campo_ini_arquivo}" == "${layout_campo.default}"
            Log Console And Report    ---
            Passed Log    DEFAULT passou!
            Log Console And Report    LAYOUT: ${layout_campo.default}
            Log Console And Report    INI_ARQUIVO: ${campo_ini_arquivo}
            #Passed Log    *** ${layout_campo.description} validado com sucesso!
        ELSE
            Log Console And Report    ---
            Failure Log    DEFAULT falhou!
            Log Console And Report    DEFAULT falhou!
            Log Console And Report    LAYOUT: ${layout_campo.default}
            Log Console And Report    INI_ARQUIVO: ${campo_ini_arquivo}
            # Failure Log    *** ${layout_campo.description} diferente do esperado! | Valor Obtido: ${campo_ini_arquivo} | Valor Esperado: ${layout_campo.default}
        END

        ${num_campo}    Evaluate    ${num_campo} + 1
    END

Valida Campos ini_lote
    [Documentation]    Percorre campos do ini_lote validando:
    ...                - Tamanho do campo (length);
    ...                - Formato do valor padrão (default);
    ...                - Valor padrão (default).
    [Arguments]    ${layout_campos}    ${ini_lote}