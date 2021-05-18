import time
from datetime import datetime
from applitools.selenium import (
                                 BrowserType,
                                 IosDeviceInfo,
                                 IosDeviceName,
                                 ScreenOrientation,
                                 DeviceName
                                )


def create_batch_id():
    timestamp = int(time.mktime(datetime.now().timetuple()))
    return str(timestamp)


def visual_grid_browsers(conf):
    conf.add_browser(1200, 800, BrowserType.CHROME)         # Linux Desktop
    conf.add_browser(1200, 800, BrowserType.SAFARI)         # Mac OS Desktop
    conf.add_browser(1200, 800, BrowserType.FIREFOX)        # Linux Desktop
    conf.add_browser(1200, 800, BrowserType.EDGE_CHROMIUM)  # Linux Windows 10
    conf.add_browser(800, 800, BrowserType.EDGE_CHROMIUM)  # Linux Windows 10
    conf.add_browser(IosDeviceInfo(IosDeviceName.iPhone_X, ScreenOrientation.PORTRAIT))  # iOS iPhone X simulator
    conf.add_device_emulation(DeviceName.Nexus_10, ScreenOrientation.PORTRAIT)  # Linux Chrome Desktop
    return conf


def init():
    global eyes
    global driver
    global batch_default_name
    global batchid
    global eyes_logs
    global concurrency
    global stitchcontent

    eyes = None
    driver = None
    batch_default_name = "My Robot Tests"
    batchid = create_batch_id
    eyes_logs = True
    concurrency = 10
    stitchcontent = None
