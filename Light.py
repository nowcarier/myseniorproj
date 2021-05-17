import time
from imutils import contours
from numpy.core.numeric import count_nonzero
from skimage import measure
import numpy as np
import argparse
import imutils
import cv2
import matplotlib.pyplot as plt

class Light():
    def light_detect(self, i, frames):
        gray = cv2.cvtColor(frames, cv2.COLOR_BGR2GRAY,)
        blurred = cv2.GaussianBlur(gray, (11, 11), 0)
        # This operation takes any pixel value p >= 225 and sets it to 255 (white).
        # Pixel values < 225 are set to 0 (black).
        thresh = cv2.threshold(blurred, 202.5, 255, cv2.THRESH_BINARY)[1]
        # cv2.imshow("thresh {}".format(i+1), thresh)
        # shape_of_image = thresh.shape
        shape_of_image = list(thresh.shape)
        resolutions = shape_of_image[0]*shape_of_image[1]
        thresh_resize = imutils.resize(thresh, width=250)
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
            light_status = 'off'
        else:
            light_status = 'on'
        return light_status