import time
from datetime import datetime
from applitools.selenium import ( Configuration,
                                  BrowserType,
                                  Configuration,
                                  IosDeviceInfo,
                                  IosDeviceName,
                                  ScreenOrientation
                                  )


def create_batch_id():
    timestamp = int(time.mktime(datetime.now().timetuple()))
    return str(timestamp)


def visual_grid_browsers():
    conf = Configuration()
    conf.environment_name = "Desktop"
    conf.add_browser(1200, 800, BrowserType.CHROME)  # Linux Desktop
    conf.add_browser(1200, 800, BrowserType.SAFARI)  # Mac OS Desktop
    conf.add_browser(1200, 800, BrowserType.FIREFOX) # Linux Desktop
    return conf


def init():
    global eyes
    global driver
    global batches
    global batchname
    global batchsequencename
    global batchid
    global stitchcontent
    global eyes_logs
    global concurrency

    eyes = None
    driver = None
    batches = []
    batchname = None
    batchsequencename = batchname
    batchid = create_batch_id
    stitchcontent = False
    eyes_logs = True
    concurrency = 10
