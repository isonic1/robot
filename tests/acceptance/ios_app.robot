*** Settings ***
Library      AppiumLibrary
Library      EyesLibrary
Resource     resources/common.robot
Resource     resources/ios.robot
Resource     resources/mobile.robot

*** Variables ***
&{TITLE}    xpath=//XCUIElementTypeStaticText[@name="HELLO WORLD! "]

*** Test Cases ***
Check Window
    [Tags]                test
    [Setup]               Setup                                                                                          iOS App - Check Window
    Check Eyes Window     Hello World
    [Teardown]            Teardown

Is Session Open
    [Setup]               Setup                                                                                          iOS App - Opened Session
    ${is open}=           Eyes Session Is Open
    Should Be True        ${is open}
    [Teardown]            Teardown

*** Keywords ***
Setup
    [Arguments]           ${test name}
    Open Application      remote_url=${REMOTE URL}
    ...                   platformName=${PLATFORM NAME}
    ...                   platformVersion=${PLATFORM VERSION}
    ...                   deviceName=${DEVICE NAME}
    ...                   app=https://applitools.bintray.com/Examples/eyes-ios-hello-world.zip
    ...                   automationName=XCUITest
    ...                   showXcodeLog=${True}
    ...                   waitForQuiescence=${False}
    ...                   commandTimeouts=220000
    ...                   osname=iOS
    Open Eyes Session     ${API KEY}                                                                                                EyesLibrary                 ${test name}    AppiumLibrary    enable_eyes_log=${true}

Teardown
    Close Application
    Close Eyes Session
