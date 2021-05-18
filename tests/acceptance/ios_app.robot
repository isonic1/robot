*** Settings ***
Library      AppiumLibrary
Library      EyesLibrary
Resource     resources/common.robot
Resource     resources/ios.robot
Resource     resources/mobile.robot

*** Variables ***
&{BUTTON}    xpath=//XCUIElementTypeStaticText[@name="Click me!"]

*** Test Cases ***
Check Window
    [Tags]                test
    [Setup]               Setup                                                                                          iOS App - Check Window
    Check Eyes Window     Hello World
    Click Element         ${BUTTON.xpath}
    Check Eyes Window     Click Me
    [Teardown]            Teardown

*** Keywords ***
Setup
    [Arguments]           ${test name}
    Open Application      remote_url=${REMOTE URL}
    ...                   platformName=${PLATFORM NAME}
    ...                   platformVersion=${PLATFORM VERSION}
    ...                   deviceName=${DEVICE NAME}
    ...                   app=${APP}
    ...                   automationName=XCUITest
    ...                   showXcodeLog=${True}
    ...                   waitForQuiescence=${False}
    ...                   commandTimeouts=220000
    ...                   osname=iOS
#    Open Eyes Session     ${API KEY}         EyesLibrary                 ${test name}    AppiumLibrary    enable_eyes_log=${true}
    Open Eyes Session     ${RUNNER}      ${API KEY}      iOS Native Tests       ${test name}        library=AppiumLibrary       serverurl=${Server URL}     enable_eyes_log=${true}    batch=Robot iOS

Teardown
    Close Application
    Close Eyes Session
