from imutils import contours
from skimage import measure
import numpy as np
import argparse
import imutils
import cv2
import requests

cap = cv2.VideoCapture(0)
if not cap.isOpened():
    print("Cannot open camera")
    exit()

drawing = False
point = (0,0)

def mouse_drawing(event, x, y, flags, params):
     global point, drawing
     if event == cv2.EVENT_LBUTTONDOWN:
        drawing = True
        point= (x, y)
        print(point, event, flags, params)

cv2.namedWindow("Frame")
cv2.setMouseCallback("Frame", mouse_drawing)

while True:
   _, frame = cap.read()
   if drawing :
      cv2.rectangle(frame,point,(point[0]+150, point[1]+150),(0,0,255),0)

   cv2.imshow("Frame", frame)
   key = cv2.waitKey(1) & 0xFF
	# if the `q` key is pressed, break from the lop
   if key == ord("q"):
       cv2.destroyWindow("Frame")
       break
device = ""
a = 0
while True:
    # Capture frame-by-frame
    ret, frame = cap.read()
    if drawing :
      cv2.rectangle(frame,point,(point[0]+150, point[1]+150),(0,0,255),0)
    cv2.imshow("select", frame)
    frame = frame[point[1]:point[1]+150, point[0]:point[0]+150]
    # if frame is read correctly ret is True
    if not ret:
        print("Can't receive frame (stream end?). Exiting ...")
        break
    # Our operations on the frame come here
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    blurred = cv2.GaussianBlur(gray, (11, 11), 0)

    thresh = cv2.threshold(blurred, 245, 255, cv2.THRESH_BINARY)[1]
    # perform a series of erosions and dilations to remove
    # any small blobs of noise from the thresholded image
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
        numPixels = cv2.countNonZero(labelMask)
        # if the number of pixels in the component is sufficiently
        # large, then add it to our mask of "large blobs"
        if numPixels > 300:
            mask = cv2.add(mask, labelMask)
    cnts = cv2.findContours(mask.copy(), cv2.RETR_EXTERNAL,
        cv2.CHAIN_APPROX_SIMPLE)

    if cnts[1] is None:
        device = 'off'
        # print('off')
    else:
        # print('on')
        device = 'on'
        cnts = cnts[0]
        cnts = contours.sort_contours(cnts)[0]
        # loop over the contours
        for (i, c) in enumerate(cnts):
            # draw the bright spot on the image
            (x, y, w, h) = cv2.boundingRect(c)
            ((cX, cY), radius) = cv2.minEnclosingCircle(c)
            cv2.circle(frame, (int(cX), int(cY)), int(radius),
                (0, 0, 255), 3)
            cv2.putText(frame, "#{}".format(i + 1), (x, y - 15),
                cv2.FONT_HERSHEY_SIMPLEX, 0.45, (0, 0, 255), 2)	
    cv2.putText(frame, "Light Status: {}".format(device), (10, 20),
		cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 255), 2)
    cv2.imshow('frame', frame)
    if cv2.waitKey(1) == ord('q'):
        break
# When everything done, release the capture

cap.release()
cv2.destroyAllWindows()