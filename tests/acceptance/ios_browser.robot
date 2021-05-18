*** Settings ***
Library     AppiumLibrary
Library     EyesLibrary
Resource    resources/common.robot
Resource    resources/ios.robot
Resource    resources/mobile.robot
Library     DebugLibrary

*** Variable ***
&{LOGO}     css=#logo                      xpath=//html/body/div[1]/div[2]/div/img     id=logo
&{URLS}     google=https://www.google.com       w3=https://www.w3schools.com/tags/tryit.asp?filename=tryhtml_iframe

*** Test Cases ***
Check Window
    [Setup]                                         Setup                          iOS - Check Window     ${URLS.google}
    Check Eyes Window                               Google Homepage
    [Teardown]                                      Teardown

#Check Region
#    [Setup]                                         Setup                            iOS Browser - Check Region     ${URLS.google}
#    Wait Until Element Is Visible                   ${LOGO.xpath}                      15
#    ${location}=                                    Get Element Location             ${LOGO.xpath}
#    Check Eyes Region                               ${location['x']}                 ${location['y']}       300     200     Google Region
#    [Teardown]                                      Teardown

#Check Region By Element
#    [Setup]                                         Setup                             iOS Browser - Check Region By Element        ${URLS.google}
#    ${logo}=                                        Get Webelement                    ${LOGO.xpath}
#    Check Eyes Region By Element                    ${logo}                           Google Logo
#    [Teardown]                                      Teardown
#
#Check Region By Selector
#    [Setup]                                         Setup                             iOS Browser - Check Region By Selector        ${URLS.google}
#    Check Eyes Region By Selector                   ${LOGO.xpath}                     Google Logo               xpath
#    [Teardown]                                      Teardown
#
#Check iFrame
#    [Setup]                                         Setup                             iOS Browser - Check Region In Frame By Selector       ${URLS.w3}
#    Check Eyes Region In Frame By Selector          iframeResult                      Frame Element
#    [Teardown]                                      Teardown


*** Keywords ***
Setup
    [Arguments]                               ${test name}      ${url}
    Open Application                          remote_url=${REMOTE URL}
    ...                                       platformName=${PLATFORM NAME}
    ...                                       platformVersion=${PLATFORM VERSION}
    ...                                       deviceName=${DEVICE NAME}
    ...                                       browserName=Safari
    ...                                       automationName=XCUITest
    Go To Url                                 ${url}
    Debug
#    Switch To Context                         WEBVIEW
    Open Eyes Session     ${RUNNER}      ${API KEY}      iOS Web Tests       ${test name}        library=AppiumLibrary       serverurl=${Server URL}     enable_eyes_log=${true}    batch=Robot iOS

Teardown
    Close Application
    Close Eyes Session
