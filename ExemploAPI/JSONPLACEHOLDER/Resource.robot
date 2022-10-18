*** Settings ***
Library     RequestsLibrary
Library     Collections

*** Variable ***
${HOST}         https://jsonplaceholder.typicode.com/
${GET_COMMENTS}  /comments?name=id labore ex et quam laborum
${POST_USERS}    /users
${PUT_USERS}     /users/5

*** Keywords ***
#### DADO
Que esteja conectado no webservice do jsonplaceholder
    Conecta ao WebService

#### QUANDO
O usuario consultar os comentarios "${CEP_CONSULTADO}" 
    Realiza requisição dos COMENTARIOS  "${CEP_CONSULTADO}" 

Cadastrar um usuário "${BODY}" 
    Realiza requisição da criação dos USERS  "${BODY}" 
Atualizar um usuário "${BODY}" 
    Realiza requisição da atualização dos USERS  "${BODY}"     

#### ENTÃO
Deve ser mostrado a id "${ID}"
    Confere o status code       200
    Confere a ID do comentário     ${ID}
Deve ser mostrado a id do usuario "${ID}"
    Confere o status code       200
    Confere a ID do usuário     ${ID}

Deve ser mostrado a identificacao "${ID}"
    Confere o status code       201
    Confere a ID do usuário     ${ID}

Deve ser mostrado o nome do usuario "${NAME}"
    Confere o Nome do usuário     ${NAME}
Deve ser mostrado o autor "${POSTID}"
    Confere o Autor do comentário     ${POSTID}

Deve ser mostrada o nome "${NAME}"
    Confere o Nome do comentário     ${NAME}

Deve ser mostrado o email do autor "${EMAIL}"
    Confere o Email do comentário   ${EMAIL}

Deve ser mostrado o corpo do comentário "${BODY}"
    Confere o Body do comentário        ${BODY}

#### PASSOS    
Conecta ao WebService
    Create Session      host     ${HOST}
Realiza requisição dos COMENTARIOS
    [Arguments]     ${CEP_CONSULTADO}
    ${RESPOSTA}=        GET On Session  host  /${GET_COMMENTS}           
    #Log                 Resposta 01: ${RESPOSTA.status_code}
    Set Test Variable   ${RESPOSTA}

Confere o status code
    [Arguments]     ${STATUS_ESPERADO}
    Should Be Equal As Strings   ${RESPOSTA.status_code}  ${STATUS_ESPERADO}
   # Log             Status Code Retornado: ${RESPOSTA.status_code} -- Status Code Esperado: ${STATUS_ESPERADO}

Confere a ID do comentário
    [Arguments]         ${ID}
    #Log               ${RESPOSTA.json()}
    Dictionary Should Contain Item  ${RESPOSTA.json()[0]}  id   ${ID}

Confere a ID do usuário
    [Arguments]         ${ID}
    #BuiltIn.Log To Console               ${RESPOSTA.json()}
    Dictionary Should Contain Item  ${RESPOSTA.json()}  id   ${ID}
Confere o NOME do usuário
    [Arguments]         ${NAME}
    #BuiltIn.Log To Console               ${RESPOSTA.json()}
    Dictionary Should Contain Item  ${RESPOSTA.json()}  name   ${NAME}


Confere o Autor do comentário
    [Arguments]         ${POSTID}
    #Log               ${RESPOSTA.json()}
    Dictionary Should Contain Item  ${RESPOSTA.json()[0]}  postId   ${POSTID}

Confere o Nome do comentário
    [Arguments]         ${NAME}
    #Log               ${RESPOSTA.json()}
    Dictionary Should Contain Item  ${RESPOSTA.json()[0]}  name   ${NAME}

Confere o Email do comentário
    [Arguments]         ${EMAIL}
    #Log               ${RESPOSTA.json()}
    Dictionary Should Contain Item  ${RESPOSTA.json()[0]}  email   ${EMAIL}

Confere o Body do comentário
    [Arguments]         ${BODY}
    #Log               ${RESPOSTA.json()}
    Dictionary Should Contain Item  ${RESPOSTA.json()[0]}  body   ${BODY}
 
 # POST USERS

 Realiza requisição da criação dos USERS
    #BuiltIn.Log To Console    "Chegouaqui1" 
    [Arguments]     ${TESTE}
    #BuiltIn.Log To Console    "Chegouaqui2" ${TESTE}
    ${body}=    create dictionary     name=zequinha    username=Zeca    email=josemalty@gmail.com   phone=48988339048   website=www.qake.com   
    #BuiltIn.Log To Console    "Chegouaqui3" ${body}   
    ${RESPOSTA}=        POST On Session  host  /${POST_USERS}
    #BuiltIn.Log To Console    Resposta 03: ${RESPOSTA.status_code}
    BuiltIn.Log To Console    Resposta 04: ${RESPOSTA.json()}
    Set Test Variable   ${RESPOSTA}

#PUT USERS
Realiza requisição da atualização dos USERS
    #BuiltIn.Log To Console    "Chegouaqui1" 
    [Arguments]     ${TESTE}
    #BuiltIn.Log To Console    "Chegouaqui2" ${TESTE}
    ${body}=    create dictionary     name=zequinha_atualizado    username=Zeca    email=josemalty@gmail.com   phone=48988339048   website=www.qake.com   
    #BuiltIn.Log To Console    "Chegouaqui3" ${body}   
    ${RESPOSTA}=        PUT On Session  host  /${PUT_USERS}
    #BuiltIn.Log To Console    Resposta 03: ${RESPOSTA.status_code}
    BuiltIn.Log To Console    Resposta 05: ${RESPOSTA.json()}
    Set Test Variable   ${RESPOSTA}



#Post Request Test
 #     &{data}=    Create dictionary  title=Robotframework requests  body=This is a test!  userId=1
  #    ${resp}=    POST On Session    jsonplaceholder  /posts  json=${data}  expected_status=anything



Confere o status code created
    [Arguments]     ${STATUS_ESPERADO} 
    Log             Resposta 02: ${RESPOSTA.json()[0]}
    Should Be Equal As Strings   ${RESPOSTA.status_code}  ${STATUS_ESPERADO}
    Log             Status Code Retornado: ${RESPOSTA.status_code} -- Status Code Esperado: ${STATUS_ESPERADO}