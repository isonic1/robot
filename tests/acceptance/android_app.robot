*** Settings ***
Library                AppiumLibrary
Library                EyesLibrary
Resource               resources/common.robot
Resource               resources/mobile.robot
Resource               resources/android.robot

*** Variables ***
&{NEXT PAGE BUTTON}    xpath=//android.widget.ImageView[@content-desc="next page"]

*** Test Cases ***
Check Window
    [Setup]               Setup                            Android App - Check Window
    Check Eyes Window     Hello World    enable_eyes_log=${true}
    [Teardown]            Teardown

*** Keywords ***
Setup
    [Arguments]           ${test name}
    Open Application      remote_url=${REMOTE URL}
    ...                   app=${APP}
    ...                   nativeWebScreenshot=true
    ...                   deviceName=${DEVICE NAME}
    ...                   platformName=${PLATFORM NAME}
    ...                   automationName=UiAutomator2
    Open Eyes Session     ${API KEY}                       EyesLibrary                                   ${test name}    AppiumLibrary    enable_eyes_log=${true}

Teardown
    Close Application
    Close Eyes Session
