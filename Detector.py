import time
from imutils import contours
from numpy.core.numeric import count_nonzero
from skimage import measure
import numpy as np
import argparse
import imutils
import cv2
from SendData import *
from Light import *
from Projector import *
import matplotlib.pyplot as plt

cap = cv2.VideoCapture(0)
if not cap.isOpened():
    print("Cannot open camera")
    exit()

toCheckLightOn = 0
toCheckLightOff = 0


sendData = SendData()
light = Light()
projector = Projector()


ret, img_raw = cap.read()
ROIs = cv2.selectROIs("Select Rois", img_raw)
print(ROIs.shape)
cv2.destroyWindow("Select Rois")

def getRectangle():
    list_of_img = []
    for rect in ROIs:
        list_of_img.append(rect[0])
        list_of_img.append(rect[1])
        list_of_img.append(rect[2])
        list_of_img.append(rect[3])
    return list_of_img


# get number of selectROIS
all_list_img_crop = len(getRectangle())
all_list_img_crop = int(all_list_img_crop/4)
print('Selected number:', all_list_img_crop)

while True:
    ret, frame = cap.read()
    ret, original = cap.read()
    # if frame is read correctly ret is True
    if not ret:
        print("Can't receive frame (stream end?). Exiting ...")
        break
    
    o = 0
    all_status = []
    for i in range(all_list_img_crop):
        frames = frame[int(getRectangle()[1+o]):int(getRectangle()[1+o]+getRectangle()[3+o]),
                       int(getRectangle()[0+o]):int(getRectangle()[0+o]+getRectangle()[2+o])]
        o += 4
        if i == all_list_img_crop -1 :
            projector.projector_detect(frames)
        else:
            deviceName = 'Light'
            light_status = light.light_detect(i, frames)
            all_status.append(light_status)
            display = imutils.resize(frames, width=250)
            cv2.putText(display, "status: {}".format(light_status), (10, 50),
                        cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 255), 2)
            cv2.putText(display, "Light No.: {}".format(i+1), (10, 80),
                        cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 255), 2)
            cv2.imshow("light number {}".format(i+1), display)

    if 'on' in all_status:
        toCheckLightOn += 1
        if toCheckLightOn == 1:
            sendData.sendData(deviceName, 'on')
            toCheckLightOff = 0

    check = 0
    for j in all_status:
        if j == 'off':
            check += 1
    if check == len(all_status):
        toCheckLightOff += 1
        if toCheckLightOff == 1:
            sendData.sendData(deviceName, light_status)
            toCheckLightOn = 0
    cv2.putText(display, "Selected number: {}".format(all_list_img_crop), (10, 20),
                cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 255), 2)
    cv2.imshow('original', original)

    if cv2.waitKey(1) == ord('q'):
        cap.release()
        cv2.destroyAllWindows()
        break
