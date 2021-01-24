import time
from imutils import contours
from numpy.core.numeric import count_nonzero
from skimage import measure
import numpy as np
import argparse
import imutils
import cv2
import requests
import datetime
import matplotlib.pyplot as plt

# cap = cv2.VideoCapture(0)
cap = cv2.VideoCapture("Lab1.avi")
if not cap.isOpened():
    print("Cannot open camera")
    exit()

list_points = {}
ss = 0
select = []
device = ""
a = 0


def sendData():
    url = 'http://192.168.43.85/get/testGetData'
    myobj = {
        'air_conditioner_status': 'off',
        'light_status': device,
        'projector_status': 'off',
        'datetime': datetime.datetime.now().strftime("%A %d %B %Y %I:%M:%S%p")
    }
    sendToServer = requests.post(url, data=myobj)
    print('send data:', device, 'success!!')


draw = True
r = None
img_raw = None
while draw == True:
    a = False
    ret, img_raw = cap.read()
    break

ROIs = cv2.selectROIs("Select Rois", img_raw)
list_of_img = []
for rect in ROIs:
    x1 = rect[0]
    y1 = rect[1]
    x2 = rect[2]
    y2 = rect[3]
    list_of_img.append(x1)
    list_of_img.append(y1)
    list_of_img.append(x2)
    list_of_img.append(y2)

all_list_img_crop = len(list_of_img)
all_list_img_crop = int(all_list_img_crop/4)
print('Selected number:', all_list_img_crop)

while True:
    # for i in range(1):
    ret, frame = cap.read()
    ret, display = cap.read()
    # if frame is read correctly ret is True
    if not ret:
        print("Can't receive frame (stream end?). Exiting ...")
        break
    
    # frame = frame[int(list_of_img[1]):int(list_of_img[1]+list_of_img[3]), int(list_of_img[0]):int(list_of_img[0]+list_of_img[2])]
    o = 0
    for i in range(all_list_img_crop):
        frames = frame[int(list_of_img[1+o]):int(list_of_img[1+o]+list_of_img[3+o]), int(list_of_img[0+o]):int(list_of_img[0+o]+list_of_img[2+o])]
        x = (list_of_img[0+o] + list_of_img[2+o])
        y = (list_of_img[1+o] + list_of_img[3+o])
        o += 4
        allpix = x*y
        # print('frame', frames.size)
        frames = imutils.resize(frames, width=350)
        gray = cv2.cvtColor(frames, cv2.COLOR_BGR2GRAY,)
        blurred = cv2.GaussianBlur(gray, (11, 11), 0)
        thresh = cv2.threshold(blurred, 225, 255, cv2.THRESH_BINARY)[1]
        all_Threshold_pixels = cv2.countNonZero(thresh)
        # print('all_Threshold_pixels', all_Threshold_pixels)
        thresh = cv2.erode(thresh, None, iterations=2)
        thresh = cv2.dilate(thresh, None, iterations=4)
        labels = measure.label(thresh, neighbors=8, background=0)
        mask = np.zeros(thresh.shape, dtype="uint8")
        for label in np.unique(labels):
            # if this is the background label, ignore it
            if label == 0:
                continue
            labelMask = np.zeros(thresh.shape, dtype="uint8")
            labelMask[labels == label] = 255
            # นับจำนวนพิกเซลที่ไม่ใช่ศูนย์ใน labelMask
            numPixels = cv2.countNonZero(labelMask)  # หาค่าที่ไม่ใช่ 0
            # if the number of pixels in the component is sufficiently
            # large, then add it to our mask of "large blobs"
            if numPixels > 200:
                mask = cv2.add(mask, labelMask)
        cnts = cv2.findContours(
            mask.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
        if cnts[1] is None:
            device = 'off'
        else:
            device = 'on'
        
        cv2.putText(frames, "Light Status: {}".format(device), (10, 20),
                cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 255), 2)
        cv2.putText(frames, "%: {}".format((all_Threshold_pixels/allpix)*100), (10, 50),
                cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 255), 2)
        cv2.putText(frames, "Light No.: {}".format(i+1), (10, 80),
                cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 255), 2)
        
        cv2.imshow("light number {}".format(i+1), frames)
    cv2.putText(display, "Selected number: {}".format(all_list_img_crop), (10, 20),
                cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 255), 2)
    cv2.imshow('display', display)

    if cv2.waitKey(1) == ord('q'):
        cap.release()
        cv2.destroyAllWindows()
        break