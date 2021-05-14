import time
from datetime import datetime


def create_batch_id():
    timestamp = int(time.mktime(datetime.now().timetuple()))
    return str(timestamp)

# def visual_grid_browsers():
#


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
