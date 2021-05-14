import time
from datetime import datetime


def create_batch_id():
    timestamp = int(time.mktime(datetime.now().timetuple()))
    return str(timestamp)


def init():
    global eyes
    global driver
    global batches
    global batchname
    global batchsequencename
    global batchid
    global stitchcontent

    eyes = None
    driver = None
    batches = []
    batchname = "ROBOT"
    batchsequencename = batchname
    batchid = create_batch_id
    stitchcontent = False
