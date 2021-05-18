# EyesLibrary for Robot Framework

#### Table of Contents

- [Disclaimer](#Disclaimer)
- [Assumptions](#Assumptions)
- [Introduction](#Introduction)
- [Requirements](#Requirements)
- [Installation](#Installation)
- [Execute](#Execute)
- [Directory Layout](#Directory%20Layout)
- [Usage](#Usage)
- [Running the Demo](#Running%20the%20Demo)
- [Things to Note When Using Applitools](#Things%20to%20Note%20When%20Using%20Applitools)
- [Getting Help](#Getting%20Help)
- [Credits](#Credits)

## Disclaimer
This example's sole purpose is to show you how to implement the Applitools Python Selenium SDK into Robot. Robot like Cucumber is an abstraction library on top of Selenium Python. The Applitools Selenium Python SDK is fully compatible with Robot. However, it's up to you the individual utilizing Robot to update your framework to incorporate the available Eyes SDK methods Applitools provides. 

With that said, as mentioned this is only an example and **it will not be maintained or supported by myself or individuals at Applitools**. Feel free to clone it, fork it and do what you will with this example. Happy testing!

## Assumption
* You have created an account on Applitools and have a corresponding API Key.
* You are familiar with the Robot framework and Selenium.
* You are familiar with Appium and have **all the required Appium dependencies** installed. 

## Introduction

This library is a clone of [EyesLibrary](https://joel-oliveira.github.io/EyesLibrary/) and the great work they did. I removed some existing capabilities to make this a leaner minimal viable product. It's been updated to work with the latest dependency versions in setup.py and to use the Applitools Ultra Fast Grid. 
In order to use EyesLibrary4-4.20, you are required to [sign up](https://applitools.com/sign-up/) for a free account with Applitools. See the [Usage](https://github.com/joel-oliveira/EyesLibrary#usage) section.

- Information about EyesLibrary keywords can be found on the [Keyword Documentation](https://joel-oliveira.github.io/EyesLibrary/) page.

- The [Applitools Documentation](https://pypi.org/project/eyes-selenium/) may be consulted in order to understand how Eyes works.

- More information about the SeleniumLibrary can be found on the [SeleniumLibrary Repo](https://github.com/robotframework/SeleniumLibrary) and in the [Keyword Documentation](http://robotframework.org/SeleniumLibrary/SeleniumLibrary.html).

- More information about the AppiumLibrary can be found on the [AppiumLibrary Repo](https://github.com/serhatbolsu/robotframework-appiumlibrary) and in the [Keyword Documentation](http://serhatbolsu.github.io/robotframework-appiumlibrary/AppiumLibrary.html).

## Requirements

The following versions were used to test the library:

* robotframework >= 3.2.1
* eyes-selenium >= 4.20.0
* robotframework-seleniumlibrary
* robotframework-appiumlibrary
* robotframework-debuglibrary

## Installation

python setup.py install
Alternatively you could download the source code, package it and install using next commands:

    python setup.py sdist
    pip install dist/robotframework-eyeslibrary4-4.20.tar.gz        
    
* Note: The zipped package can be shared with users and installed in other locations.

* The resources folder you will see additional files where you can change the settings of your choosing.
* Set your Applitools API Key and Server URL in the tests > acceptance > resources > common.robot file.

## Execute
* Run Example: `robot tests/acceptance/web.robot`

* Note: You can toggle the web.robot test to use both the ClassicRunner and the Ultra Fast Grid by changing the runner variable. The UFG browsers can be changed in the EyesLibrary > resources > variables.py file. Any Changes to any files in the EyesLibrary folder, you will need to rebuild the package by running the steps in the Installation section. 

Default Browsers Set:

`   conf.add_browser(1200, 800, BrowserType.CHROME)         # Linux Desktop
    conf.add_browser(1200, 800, BrowserType.SAFARI)         # Mac OS Desktop
    conf.add_browser(1200, 800, BrowserType.FIREFOX)        # Linux Desktop
    conf.add_browser(1200, 800, BrowserType.EDGE_CHROMIUM)  # Linux Windows 10
    conf.add_browser(800, 800, BrowserType.EDGE_CHROMIUM)  # Linux Windows 10
    conf.add_browser(IosDeviceInfo(IosDeviceName.iPhone_X, ScreenOrientation.PORTRAIT))  # iOS iPhone X simulator
    conf.add_device_emulation(DeviceName.Nexus_10, ScreenOrientation.PORTRAIT)  # Linux Chrome Desktop
`

* Note: Currently, only the web.robot, android_app.robot, android_browser.robot, ios_app.robot and ios_browser.robot tests work.

## Directory Layout

**EyesLibrary/**

&ensp;&ensp;The Robot Framework Python Library that makes use of the Applitools Eyes Python SDK

**tests/acceptance/**

&ensp;&ensp;Test files to display what the keywords from EyesLibrary accomplish

**docs/**

&ensp;&ensp;Documentation for the EyesLibrary: Keyword Documentation and ChangeLog

## Usage

You must create a [free account](https://applitools.com/sign-up/) with Applitools in order to run
EyesLibrary and return results.

Then, to use the library, follow [EyesLibrary Keyword Documentation](https://joel-oliveira.github.io/EyesLibrary/).

This is a Robot Framework library. If you're not familiarized with Robot Framework, 
please consult [Robot Framework User Guide](http://code.google.com/p/robotframework/wiki/UserGuide).

## Running the Demo

At _tests/acceptance_ directory, you can find Robot Framework tests for:

- Web
- Android Browser
- iOS Browser
- iOS Native App

Before running the tests, your Applitools API Key must be set in _tests/acceptance/resources/common.robot_, by replacing "YourApplitoolsApiKey" with your own key.

When running the mobile tests, you must replace the variables within _tests/acceptance/resources/mobile.robot_ with your own, as well as the ones in _tests/acceptance/resources/android.robot_ or _tests/acceptance/resources/ios.robot_, according to the OS in use.

For instance, you may want to use a different Remote URL than the one provided in the variables. So, if you are working with [TestingBot](https://testingbot.com/), for example, you'd have to replace the Remote URL variable in _tests/acceptance/resources/mobile.robot_:

    ${REMOTE URL}          http://${CREDENTIALS}@hub.testingbot.com/wd/hub

Before running the Android Hybrid App tests, you need to install the Demo App (APK found at _tests/resources_) in your device.

For in depth detail on how the keywords function, read the Keyword documentation found here: [Keyword Documentation](https://joel-oliveira.github.io/EyesLibrary/)

**Remember to include your Applitools API key otherwise the
test will not run.** To run a test, open a command prompt within the _tests/acceptance_ folder and run:

    robot FILENAME.robot

For example, to run the Test Suite for Web:

    robot web.robot

**Note:** It is assumed that anyone who wants to use this demo is already able to execute robot tests using SeleniumLibrary (for web tests) and/or AppiumLibrary (for mobile tests). The browser used to navigate with SeleniumLibrary is Google Chrome.

## Things to Note When Using Applitools

- The tests will be accepted automatically by Applitools Eyes after the first run because a new baseline is being created. A second test run will show a comparison between screens.
- Changing the Applitools baseline parameters will create a new baseline, that is automatically accepted on the first run. (For more information, read the article: [What is a ‘baseline’ and how is a baseline created?](https://help.applitools.com/hc/en-us/articles/360007188691-What-is-a-baseline-and-how-is-a-baseline-created-)
- The viewport size should not be set to greater values than the maximum size of the device's window.
(For more information on using viewports, consult [Using viewports in Eyes](https://applitools.com/docs/topics/general-concepts/using-viewports-in-eyes.html))

## Getting Help

To be defined. It might be helpful to read [Applitools Documentation](https://applitools.com/docs).

## Credits

EyesLibrary was forked from [Robot-AppEyes](https://github.com/NaviNet/Robot-AppEyes) on version 1.2.

Robot-AppEyes authors:

- [Thomas Armstrong](https://github.com/tbarmstrong)
- [Simon McMorran](https://github.com/SIMcM)
- [Gareth Nixon](https://github.com/GarethNixon)
- [Adam Simmons](https://github.com/adamsimmons)

EyesLibrary then emerged as an independent library from the original one, on version 2.0.
