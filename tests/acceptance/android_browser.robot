*** Settings ***
Library     AppiumLibrary
Library     EyesLibrary
Resource    resources/common.robot
Resource    resources/mobile.robot
Resource    resources/android.robot

*** Variable ***
&{LOGO}     css=img.lnXdpd                      xpath=//html/body/div[1]/div[2]/div/img
&{URLS}     google=https://www.google.com       w3=https://www.w3schools.com/tags/tryit.asp?filename=tryhtml_iframe

*** Test Cases ***
Check Window
    [Setup]                                         Setup                          Android - Check Window     ${URLS.google}
    Check Eyes Window                               Google Homepage
    [Teardown]                                      Teardown

Check Region
    [Setup]                                         Setup                            Android Browser - Check Region     ${URLS.google}
    ${location}=                                    Get Element Location             ${LOGO.xpath}
    Check Eyes Region                               ${location['x']}                 ${location['y']}       300     200     Google Region
    [Teardown]                                      Teardown

Check Region By Element
    [Setup]                                         Setup                             Android Browser - Check Region By Element        ${URLS.google}
    ${logo}=                                        Get Webelement                    ${LOGO.xpath}
    Check Eyes Region By Element                    ${logo}                           Google Logo
    [Teardown]                                      Teardown

Check Region By Selector
    [Setup]                                         Setup                             Android Browser - Check Region By Selector        ${URLS.google}
    Check Eyes Region By Selector                   ${LOGO.xpath}                     Google Logo               xpath
    [Teardown]                                      Teardown

Check iFrame
    [Setup]                                         Setup                             Android Browser - Check Region In Frame By Selector       ${URLS.w3}
    Check Eyes Region In Frame By Selector          iframeResult                      Frame Element
    [Teardown]                                      Teardown

*** Keywords ***
Setup
    [Arguments]                                     ${test name}        ${url}
    Open Application                                remote_url=${REMOTE URL}
    ...                                             platformName=${PLATFORM NAME}
    ...                                             deviceName=${DEVICE NAME}
    ...                                             browserName=Chrome
    ...                                             automationName=UiAutomator2
    Go To Url                                       ${url}
    Open Eyes Session     ${RUNNER}      ${API KEY}      Android Web Tests       ${test name}        library=AppiumLibrary       serverurl=${Server URL}     enable_eyes_log=${true}    batch=Robot Android

Teardown
    Close Application
    Close Eyes Session
