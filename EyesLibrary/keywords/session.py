#!/usr/bin/env python

from __future__ import absolute_import
import os
#import six.moves.http_client
import base64
from selenium import webdriver
from robot.libraries.BuiltIn import BuiltIn
from applitools.selenium import (
    Target,
    Region,
    Eyes,
    StdoutLogger,
    logger,
    DeviceName,
    FileLogger,
    BrowserType,
    Configuration,
    IosDeviceInfo,
    IosDeviceName,
    ScreenOrientation,
    positioning,
    StitchMode,
    MatchLevel,
    BatchInfo,
    ClassicRunner,
    VisualGridRunner
)

from applitools.selenium.webelement import EyesWebElement
from robot.api import logger as loggerRobot
from datetime import datetime
from ..version import __version__
from EyesLibrary.resources import variables, utils


class SessionKeywords(object):

    library_arguments = {}

    def open_eyes_session(
        self,
        runner=None,
        apikey=None,
        appname=None,
        testname=None,
        library=None,
        width=None,
        height=None,
        matchlevel=None,
        enable_eyes_log=None,
        batch=None,
        serverurl=None,
        force_full_page_screenshot=None
    ):
        """
        Starts a session (=test) with Applitools.

        Some of the following arguments may also be defined on library import.
        See `Before running tests` or `Importing`.

            | =Arguments=                       | =Description=
            | Runner (str)                      | *Mandatory* - ClassicRunner or VisualGridRunner                                                                                             |                                                                                                              |
            | API Key (str)                     | *Mandatory* - User's Applitools Eyes key                                                                                                    |
            | Application Name (str)            | *Mandatory* - The name of the application under test                                                                                        |
            | Test Name (str)                   | *Mandatory* - The test name                                                                                                                 |  
            | Library (str)                     | Library to test (Either SeleniumLibrary or AppiumLibrary)                                                                                   |
            | Width (int)                       | The width of the browser window e.g. 1280                                                                                                   |
            | Height (int)                      | The height of the browser window e.g. 1000                                                                                                  |
            | Match Level (str)                 | The match level for the comparison of this test's checkpoints - can be STRICT, LAYOUT, CONTENT or EXACT                                     |
            | Enable Eyes Log (bool)            | Determines if the trace logs of Applitools Eyes SDK are activated for this session                                                          |
            | Batch (str or BatchInfo)          | The desired batch. See `Group tests into batches`                                                                                           |
            | Server URL (str)                  | The URL of the Eyes server. If not provided then your test will run on the public cloud                                                     |
            | Force Full Page Screenshot (bool) | Will force the browser to take a screenshot of whole page                                                                                   |
            | Stitch Mode (str)                 | Type of stitching used for full page screenshots - can be CSS or SCROLL                                                                     |

        *Mandatory Arguments:* They may be defined through this keyword, or when importing the library.
        In order to run a test, provide at least the API Key, Application Name and Test Name.
 
        When opening the session on a mobile browser or hybrid app, the context must be set to WEBVIEW in order to retrieve the correct viewport size. Geolocation of the device may have to be set after switching context.

        *Example:*                                                                                                                                                                                                                               
            | Open Eyes Session | YourApplitoolsKey | AppName | TestName | SeleniumLibrary | 1024 | 768 | OSOverrideName | BrowserOverrideName | layout | ${true} | batchname=BatchName | serverurl=https://myserver.com |
        """

        if appname is None:
            appname = self.library_arguments["appname"]
        if testname is None:
            testname = self.library_arguments["testname"]
        if apikey is None:
            apikey = self.library_arguments["apikey"]
        if library is None:
            library = self.library_arguments["library"]
        if matchlevel is None:
            matchlevel = self.library_arguments["matchlevel"]
        if enable_eyes_log is None:
            enable_eyes_log = self.library_arguments["enable_eyes_log"]
        if serverurl is None:
            serverurl = self.library_arguments["serverurl"]
        if runner is None:
            runner = self.library_arguments["runner"]

        mode = None

        if runner is None or runner == 'ClassicRunner':
            print("\nRunning ClassicRunner...\n")
            mode = ClassicRunner()

        if runner == 'VisualGridRunner':
            print("\nRunning VisualGridRunner...\n")
            mode = VisualGridRunner(variables.concurrency)

        variables.eyes = Eyes(mode)

        try:
            libraryInstance = BuiltIn().get_library_instance(library)

            if library == "AppiumLibrary":
                driver = libraryInstance._current_application()
            else:
                driver = libraryInstance.driver
        except RuntimeError:
            raise Exception("%s instance not found" % library)

        # utils.manage_logging(enable_eyes_log)

        if enable_eyes_log is not None:
            logger.set_logger(StdoutLogger(True))

        if batch is not None:
            new_batch = BatchInfo(batch)
            sequence_name = batch
        else:
            new_batch = BatchInfo(variables.batch_default_name)
            sequence_name = variables.batch_default_name

        new_batch.sequence_name = sequence_name
        new_batch.id = variables.batchid

        config = Configuration()
        config.api_key = apikey
        config.app_name = str(appname)
        config.test_name = str(testname)
        if width is not None and height is not None:
            config.set_viewport_size({'width': int(width), 'height': int(height)})
        config.batch = new_batch
        config.server_url = serverurl
        config.set_match_level(utils.get_match_level(matchlevel))
        config.force_full_page_screenshot = force_full_page_screenshot or True

        if runner == 'VisualGridRunner':
            config = variables.visual_grid_browsers(config)
            variables.eyes.set_configuration(config)
        else:
            variables.eyes.set_configuration(config)

        # print("\nMY CONFIG: %s\n" % config)

        variables.eyes.open(driver)

    def close_eyes_session(self, raise_exception=True):
        """
        Closes a session and returns the results of the session.
        If a test is running, aborts it. Otherwise, does nothing.

            | =Arguments=                  | =Description=                                                                                                           |
            | Enable Eyes Log (bool)       | The Eyes logs will not be included by default. To activate, pass 'True' in the variable                                 |
            | Enable HTTP Debug Log (bool) | The HTTP Debug logs will not be included by default. To activate, pass 'True' in the variable                           |
            | Raise Exception (bool)       | If you don't want an exception to be thrown if there are new, missing or mismatched steps, pass 'False' in the variable |

        *Example:*
            | Close Eyes Session | ${false} |                                 
        """

        try:
            variables.eyes.close_async()
            variables.eyes._runner.get_all_test_results(raise_exception)
        finally:
            variables.eyes.abort_if_not_closed()

