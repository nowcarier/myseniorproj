import numpy as np
import cv2 

drawing = False
point = (0,0)

def mouse_drawing(event, x, y, flags, params):
     global point, drawing
     if event == cv2.EVENT_LBUTTONDOWN:
        drawing = True
        point= (x, y)
        print(point)
cap = cv2.VideoCapture(0)
cv2.namedWindow("Frame")
cv2.setMouseCallback("Frame", mouse_drawing)

while True:
   _, frame = cap.read()
   if drawing :
      cv2.rectangle(frame,point,(point[0]+80, point[1]+80),(0,0,255),0)

   cv2.imshow("Frame", frame)
   key = cv2.waitKey(1) & 0xFF
	# if the `q` key is pressed, break from the lop
   if key == ord("q"):
	   break

cap.release()
cv2.destroyAllWindows()