import time
from imutils import contours
from numpy.core.fromnumeric import shape
from numpy.core.numeric import count_nonzero
from skimage import measure
import numpy as np
# import sys
# np.set_printoptions(threshold=sys.maxsize)
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

device = ""
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
img_raw = None
while draw == True:
    a = False
    ret, img_raw = cap.read()
    break

# img_raw = cv2.imread('image/image800.jpg', cv2.IMREAD_UNCHANGED)
x1=x2=y1=y2=0
ROIs = cv2.selectROIs("Select Rois", img_raw)
for rect in ROIs:
    x1 = rect[0]
    y1 = rect[1]
    x2 = rect[2]
    y2 = rect[3]



while True:
    ret, frame = cap.read()
    cv2.imwrite('frame.png',frame)
    if not ret:
        print("Can't receive frame (stream end?). Exiting ...")
        break
    print('xy', ROIs)
    allpix = (x2-x1)*(y1-y2)
    print('allpix:', allpix)
    frame = frame[y1:y1+y2, x1:x1+x2]
    cv2.imshow('original', frame)
    blue_channel = frame[:,:,0]
    # print(blue_channel)
    cv2.imshow('blue_channel', blue_channel)
    blue_img = frame.copy()
    #green Ch
    blue_img [:,:,1] = 0
    #red Ch
    blue_img [:,:,2] = 0
    #blue Ch
    blue_img[:,:,0] = blue_channel
    thresh = cv2.threshold(blue_channel, 100, 255, cv2.THRESH_BINARY)[1]
    all = cv2.threshold(blue_channel, 0, 255, cv2.THRESH_BINARY)[1]
    all_Threshold_pixels = cv2.countNonZero(thresh)
    alls = cv2.countNonZero(all)
    print('alls:', alls)
    cv2.imshow('thresh', thresh)
    thresh = cv2.erode(thresh, None, iterations=2)
    thresh = cv2.dilate(thresh, None, iterations=2)
    labels = measure.label(thresh, neighbors=8, background=0)
    mask = np.zeros(thresh.shape, dtype="uint8")
    mask_Threshold_pixels = None
    for label in np.unique(labels):
        # if this is the background label, ignore it
        if label == 0:
            continue
        labelMask = np.zeros(thresh.shape, dtype="uint8")
        labelMask[labels == label] = 255
        numPixels = cv2.countNonZero(labelMask)
        # print('num_pixels:', numPixels)
        
        # if the number of pixels in the component is sufficiently
        # large, then add it to our mask of "large blobs"
        if numPixels > 2000:
            mask = cv2.add(mask, labelMask)
            # mask_Threshold_pixels = cv2.countNonZero(mask)
            # print('mask_Threshold_pixels:', mask_Threshold_pixels)
    cnts = cv2.findContours(mask.copy(), cv2.RETR_EXTERNAL,
        cv2.CHAIN_APPROX_SIMPLE)

    if cnts[1] is None:
        device = 'off'

    else:
        device = 'on'
        cnts = cnts[0]
        cnts = contours.sort_contours(cnts)[0]
        # loop over the contours
        for (i, c) in enumerate(cnts):
            # draw on the image
            (x, y, w, h) = cv2.boundingRect(c)
            ((cX, cY), radius) = cv2.minEnclosingCircle(c)
            cv2.circle(blue_img, (int(cX), int(cY)), int(radius),
                (0, 0, 255), 3)
    cv2.putText(blue_img, "%: {}".format((all_Threshold_pixels/alls)*100), (10, 50),
                cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 255), 2)
    cv2.imshow('blue_img', blue_img)
    # cv2.imwrite('cv2-blue-channel.png',blue_img)
    if cv2.waitKey(1) == ord('q'):
        cap.release()
        cv2.destroyAllWindows()
        break

