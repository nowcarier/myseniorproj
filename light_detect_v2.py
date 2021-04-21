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

cap = cv2.VideoCapture(0)
# cap = cv2.VideoCapture("Lab1.avi")
if not cap.isOpened():
    print("Cannot open camera")
    exit()


device = None
toCheckOn = 0
toCheckOff = 0


def sendData(device):
    url = 'http://127.0.0.1:8000/get/PutData'
    myobj = {
        'air_conditioner_status': 'off',
        'light_status': device,
        'projector_status': 'off',
        'datetime': datetime.datetime.now().strftime("%A %d %B %Y %I:%M:%S%p")
    }
    sendToServer = requests.post(url, data=myobj)
    print('send data:',device, 'success!!')




ret, img_raw = cap.read()
ROIs = cv2.selectROIs("Select Rois", img_raw)


def getRectangle():
    list_of_img = []
    for rect in ROIs:
        list_of_img.append(rect[0])
        list_of_img.append(rect[1])
        list_of_img.append(rect[2])
        list_of_img.append(rect[3])
    return list_of_img

def color_to_gray(frames):
    gray = cv2.cvtColor(frames, cv2.COLOR_BGR2GRAY,)
    blurred = cv2.GaussianBlur(gray, (11, 11), 0)
    return blurred
    
# get number of selectROIS
all_list_img_crop = len(getRectangle())
all_list_img_crop = int(all_list_img_crop/4)
print('Selected number:', all_list_img_crop)

while True:
    ret, frame = cap.read()
    ret, display = cap.read()
    # if frame is read correctly ret is True
    if not ret:
        print("Can't receive frame (stream end?). Exiting ...")
        break

    o = 0
    for i in range(all_list_img_crop):
        frames = frame[int(getRectangle()[1+o]):int(getRectangle()[1+o]+getRectangle()[3+o]),
                       int(getRectangle()[0+o]):int(getRectangle()[0+o]+getRectangle()[2+o])]
        o += 4
        # #this is projector
        if i == all_list_img_crop -1:
            blue_channel = frames[:,:,0]
            blue_img = frames.copy()
            #green Ch
            blue_img [:,:,1] = 0
            #red Ch
            blue_img [:,:,2] = 0
            #blue Ch
            blue_img [:,:,0] = blue_channel
            thresh = cv2.threshold(blue_channel, 105, 255, cv2.THRESH_BINARY)[1]
            all = cv2.threshold(blue_channel, 0, 255, cv2.THRESH_BINARY)[1]
            all_Threshold_pixels = cv2.countNonZero(thresh)
            alls = cv2.countNonZero(all)
            # print('alls:', alls)
            cv2.imshow('thresh', thresh)
            thresh = cv2.erode(thresh, None, iterations=2)
            thresh = cv2.dilate(thresh, None, iterations=2)
            labels = measure.label(thresh, background=0)
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
                # sendData(device)
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
            cv2.imshow('blue_channel', blue_img)

        #this is light
        else:
            #Covert to gray and blur image
            blurred = color_to_gray(frames)
            # This operation takes any pixel value p >= 225 and sets it to 255 (white).
            # Pixel values < 225 are set to 0 (black).
            thresh = cv2.threshold(blurred, 202.5, 255, cv2.THRESH_BINARY)[1]
            thresh = cv2.erode(thresh, None, iterations=2)
            thresh = cv2.dilate(thresh, None, iterations=4)
            thresh_resize = imutils.resize(thresh, width=250)
            cv2.imshow("thresh {}".format(i+1), thresh_resize)
            shape_of_image = thresh.shape
            shape_of_image = list(shape_of_image)
            resolutions = shape_of_image[0]*shape_of_image[1]
            count_threshold = cv2.countNonZero(thresh)
            # print('resolutions', resolutions)
            # print('count_threshold', count_threshold)
            labels = measure.label(thresh, background=0)
            mask = np.zeros(thresh.shape, dtype="uint8")
            for label in np.unique(labels):
                # if this is the background label, ignore it
                if label == 0:
                    continue
                labelMask = np.zeros(thresh.shape, dtype="uint8")
                labelMask[labels == label] = 255
                numPixels = cv2.countNonZero(labelMask)  # หาค่าที่ไม่ใช่ 0
                # if the number of pixels in the component is sufficiently
                # large, then add it to our mask of "large blobs"
                if numPixels > 800:
                    mask = cv2.add(mask, labelMask)
                # print('mask:', cv2.countNonZero(mask))
            cnts = cv2.findContours(
                mask.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

                
            if cnts[1] is None:
                device = 'off'

            else:
                device = 'on'
            
            if device == 'off':
                toCheckOff += 1
                if toCheckOff == 1:
                    sendData(device)
                    toCheckOn = 0
            if device == 'on':
                toCheckOn += 1
                if toCheckOn == 1:
                    sendData(device)
                    toCheckOff = 0
            
            frames = imutils.resize(frames, width=250)
            cv2.putText(frames, "Light Status: {}".format(device), (10, 20),
                        cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 255), 2)
            cv2.putText(frames, "%: {0:.2f}".format((count_threshold/resolutions)*100), (10, 50),
                        cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 255), 2)
            cv2.putText(frames, "Light No.: {}".format(i+1), (10, 80),
                        cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 255), 2)
            cv2.imshow("light number {}".format(i+1), frames)

    cv2.putText(display, "Selected number: {}".format(all_list_img_crop-1), (10, 20),
                cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 255), 2)
    cv2.imshow('display', display)

    if cv2.waitKey(1) == ord('q'):
        cap.release()
        cv2.destroyAllWindows()
        break
