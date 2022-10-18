*** Settings ***
Library     RequestsLibrary
Library     Collections

*** Variable ***
${HOST}         https://webmaniabr.com/api/1/cep
${APP_KEY}      njMf2EiyQ17g6C3vLUxk1yEsWTforVqf
${APP_SECRET}   EgpTuUcM93IqHY8icgR3cK6Cn4bOlkQwSlfLd6ryMjrhhwMW


*** Keywords ***
#### DADO
Que esteja conectado no webservice de consultas de CEP
    Conecta ao WebService

#### QUANDO
O usuário consultar o CEP "${CEP_CONSULTADO}"   
    Realiza requisição do CEP   ${CEP_CONSULTADO}

#### ENTÃO
Deve ser mostrado o endereço "${ENDERECO}"
    Confere o status code       200
    Confere endereço do CEP     ${ENDERECO}

Deve ser mostrado o bairro "${BAIRRO}"
    Confere bairro do CEP       ${BAIRRO}

Deve ser mostrada a cidade "${CIDADE}"  
    Confere cidade do CEP       ${CIDADE}

Deve ser mostrada a UF "${UF}"  
    Confere UF do CEP       ${UF}    

Deve ser mostrado o CEP "${CEP}"
    Confere CEP       ${CEP}

Nenhum dado deve ser mostrado para o ERROR "${ERROR}"
    Confere o status code       200
   # Confere endereço do CEP     ${EMPTY}
   # Confere bairro do CEP       ${EMPTY}
  #  Confere cidade do CEP       ${EMPTY}
  #  Confere UF do CEP           ${EMPTY}
  #  Confere CEP                 ${CEP}
    Confere que o CEP é invalido      ${ERROR}
  #  Confere que a resposta esta vazio  ${EMPTY}

#### PASSOS    
Conecta ao WebService
    Create Session      consultaCEP     ${HOST}

Realiza requisição do CEP
    [Arguments]         ${CEP_DESEJADO}
    ${RESPOSTA}=        Get Request  consultaCEP  /${CEP_DESEJADO}/?app_key=${APP_KEY}&app_secret=${APP_SECRET}            
    Log                 Resposta: ${RESPOSTA.text}
    Set Test Variable   ${RESPOSTA}

Confere o status code
    [Arguments]     ${STATUS_ESPERADO}
    Should Be Equal As Strings   ${RESPOSTA.status_code}  ${STATUS_ESPERADO}
    Log             Status Code Retornado: ${RESPOSTA.status_code} -- Status Code Esperado: ${STATUS_ESPERADO}

Confere endereço do CEP
    [Arguments]         ${ENDERECO}
    Dictionary Should Contain Item  ${RESPOSTA.json()}  endereco   ${ENDERECO}

Confere bairro do CEP
    [Arguments]         ${BAIRRO}
    Dictionary Should Contain Item  ${RESPOSTA.json()}  bairro   ${BAIRRO}

Confere cidade do CEP
    [Arguments]         ${CIDADE}
    Dictionary Should Contain Item  ${RESPOSTA.json()}  cidade   ${CIDADE}    

Confere UF do CEP
    [Arguments]         ${UF}
    Dictionary Should Contain Item  ${RESPOSTA.json()}  uf   ${UF}    

Confere CEP
    [Arguments]         ${CEP}
    Dictionary Should Contain Item  ${RESPOSTA.json()}  cep   ${CEP}         

Confere que o CEP é invalido
    [Arguments]         ${ERROR}
    BuiltIn.Log To Console   "Oi Douglas"
    BuiltIn.Log To Console   ${RESPOSTA.json()}
    BuiltIn.Log To Console   ${ERROR}
    Dictionary Should Not Contain Key  ${RESPOSTA.json()}  cep 
    Dictionary Should Contain Item  ${RESPOSTA.json()}  error   ${ERROR}
    
    
Confere2 que nao tem CEP
    [Arguments]         ${CEP}
    Dictionary Should Not Contain Value  ${RESPOSTA.json()}  cep   ${CEP}   

Confere que a resposta esta vazio
    [Arguments]         ${CEP}
   # Log To Console ${resp.json()}
 #  Log To Console ${RESPOSTA.json()}
  #  Log To Console "OI"
    BuiltIn.Log To Console   ${RESPOSTA.json()}
    Dictionary Should Be Empty     ""