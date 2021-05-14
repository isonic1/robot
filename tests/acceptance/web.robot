*** Settings ***
Resource    resources/common.robot
Library     DateTime
Library     SeleniumLibrary
Library     EyesLibrary               ${API KEY}                 EyesLibrary
Library     DebugLibrary

*** Variables ***
&{LOGO}     css=img.lnXdpd                      xpath=//html/body/div[1]/div[2]/div/img
&{URLS}     google=https://www.google.com       w3=https://www.w3schools.com/tags/tryit.asp?filename=tryhtml_iframe

*** Test Cases ***
Check Window
    [Setup]                                   Setup                          Web - Check Window     ${URLS.google}
#    Debug
    Check Eyes Window                         Google Homepage
    [Teardown]                                Teardown

Check Region
    [Setup]                                   Setup                          Web - Check Region By Coordinates     ${URLS.google}
    ${x}=                                     Get Horizontal Position        ${LOGO.xpath}
    ${y}=                                     Get Vertical Position          ${LOGO.xpath}
    Check Eyes Region                         ${x}                           ${y}                   400         200         Google Logo Coordinates
    [Teardown]                                Teardown

Check Region By Element
    [Setup]                                   Setup                           Web - Check Region By Element     ${URLS.google}
    #Debug
    ${logo}=                                  Get WebElement                  ${LOGO.xpath}
    Check Eyes Region By Element              ${logo}                         Google Logo Element
    [Teardown]                                Teardown

Check Region By Selector
    [Setup]                                   Setup                           Web - Check Region By Selector     ${URLS.google}
    Check Eyes Region By Selector             ${LOGO.css}                     Google Logo Selector               css
    [Teardown]                                Teardown

Check iFrame
    [Setup]                                   Setup                            Web - Check Region iFrame                ${URLS.w3}
    Check Eyes Region In Frame By Selector    iframeResult                     Frame Elements
    [Teardown]                                Teardown

*** Keywords ***

Setup
    [Arguments]                 ${test name}          ${url}
    Open Browser                ${url}                gc
    Open Eyes Session           ClassicRunner         ${API KEY}            Web Tests     ${test name}        width=1200      height=600      matchlevel=strict       enable_eyes_log=${true}        batch=Robot     batchsequencename=ROBOT

Teardown
    Close All Browsers
    Close Eyes Session
