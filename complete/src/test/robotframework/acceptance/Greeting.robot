*** Settings ***
Documentation    This is a sample integration test
Library    RequestsLibrary

*** Test Cases ***
Integration Test
    [Tags]    DEBUG
    OpenConnection    http://localhost:8080
    ${rsp}=    Get Request    test    /greeting?name=abc
    Should Be Equal As Numbers    ${rsp.status_code}    200
    #Dictionary Should Contain Value    ${rsp.json()["content"]}    abc
    Log    ${rsp.json()}
    Should Contain    ${rsp.json()["content"]}    abc
    CloseConnection

*** Keywords ***
OpenConnection
    [Arguments]    ${url}
    [Documentation]    Test Connection
    Comment    检查服务器连接是否正常
    Create Session    test    ${url}    timeout=60    verify=True
    ${addr}=    Get Request    test    /
    Should Be Equal As Numbers    ${addr.status_code}    200

CloseConnection
    [Documentation]    Close All Connection
    Comment    释放服务器连接
    Delete All Sessions
    Comment    关闭所有打开的浏览器