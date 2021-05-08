import time
from imutils import contours
from numpy.core.numeric import count_nonzero
from skimage import measure
import numpy as np
import argparse
import imutils
import cv2
import matplotlib.pyplot as plt
from SendData import *
sendData = SendData()


class Projector():
    toCheckProjOn = 0
    toCheckProjOff = 0

    def projector(self, frames):
        hsv = cv2.cvtColor(frames, cv2.COLOR_BGR2HSV)
        boundaries = [
            ([100, 0, 0], [240, 255, 255]),
        ]
        for (lower, upper) in boundaries:
            # create NumPy arrays from the boundaries
            lower = np.array(lower, dtype="uint8")
            upper = np.array(upper, dtype="uint8")
            # find the colors within the specified boundaries and apply
            # the mask
            mask = cv2.inRange(hsv, lower, upper)
            # output = cv2.bitwise_and(frame, frame, mask = mask)
            # show the images

        # all = cv2.threshold(blue_channel, 0, 255, cv2.THRESH_BINARY)[1]
        # all_Threshold_pixels = cv2.countNonZero(thresh)
        # alls = cv2.countNonZero(all)
        # # print('alls:', alls)
        labels = measure.label(mask, background=0)
        mask = np.zeros(mask.shape, dtype="uint8")
        for label in np.unique(labels):
            # if this is the background label, ignore it
            if label == 0:
                continue
            labelMask = np.zeros(mask.shape, dtype="uint8")
            labelMask[labels == label] = 255
            numPixels = cv2.countNonZero(labelMask)
            # print('num_pixels:', numPixels)

            # if the number of pixels in the component is sufficiently
            # large, then add it to our mask of "large blobs"
            if numPixels > 2000:
                mask = cv2.add(mask, labelMask)

        cnts = cv2.findContours(mask.copy(), cv2.RETR_EXTERNAL,
                                cv2.CHAIN_APPROX_SIMPLE)

        if cnts[1] is None:
            status = 'off'
        else:
            status = 'on'
            cnts = cnts[0]
            cnts = contours.sort_contours(cnts)[0]
            # loop over the contours
            for (i, c) in enumerate(cnts):
                # draw on the image
                (x, y, w, h) = cv2.boundingRect(c)
                ((cX, cY), radius) = cv2.minEnclosingCircle(c)
                cv2.circle(frames, (int(cX), int(cY)), int(radius),
                           (0, 0, 255), 3)
        frames = imutils.resize(frames, width=250)
        cv2.imshow('Projector', frames)
        deviceName = 'Projector'
        if status == 'off':
            Projector.toCheckProjOff += 1
            if Projector.toCheckProjOff == 1:
                sendData.sendData(deviceName, status)
                Projector.toCheckProjOn = 0
        if status == 'on':
            Projector.toCheckProjOn += 1
            if Projector.toCheckProjOn == 1:
                sendData.sendData(deviceName, status)
                Projector.toCheckProjOff = 0

        return status
