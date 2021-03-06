*** Settings ***
Library                AppiumLibrary
Library                EyesLibrary
Resource               resources/common.robot
Resource               resources/mobile.robot
Resource               resources/android.robot

*** Variables ***
&{BUTTON}              id=click_me_btn

*** Test Cases ***
Check Window
    [Setup]               Setup                            Android App - Check Window
    Check Eyes Window     Hello World
    Click Element         ${BUTTON.id}
    Check Eyes Window     Click Me
    [Teardown]            Teardown

*** Keywords ***
Setup
    [Arguments]           ${test name}
    Open Application      remote_url=${REMOTE URL}
    ...                   app=${APP}
#    ...                   nativeWebScreenshot=true
    ...                   deviceName=${DEVICE NAME}
    ...                   platformName=${PLATFORM NAME}
    ...                   automationName=UiAutomator2
    Open Eyes Session     ${RUNNER}      ${API KEY}      Android Native Tests       ${test name}        library=AppiumLibrary       serverurl=${Server URL}     enable_eyes_log=${true}    batch=Robot Android

Teardown
    Close Application
    Close Eyes Session
