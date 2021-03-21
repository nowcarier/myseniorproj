import cv2
from cv2 import data
import imutils
import numpy as np
from numpy.core.numeric import count_nonzero
from scipy.sparse import csr_matrix, vstack
import matplotlib.pyplot as plt
# import sys
# np.set_printoptions(threshold=sys.maxsize)

cap = cv2.imread('dataSet/on.jpg')
cap2 = cv2.imread('dataSet/Off.jpg')
# print('cap.shape', cap.shape)
hsv = cv2.cvtColor(cap, cv2.COLOR_BGR2HSV)
hsv2 = cv2.cvtColor(cap2, cv2.COLOR_BGR2HSV)

## mask of green (36,25,25) ~ (86, 255,255)
# mask = cv2.inRange(hsv, (36, 25, 25), (86, 255,255))
mask = cv2.inRange(hsv, (36, 25, 25), (70, 255,255))
mask2 = cv2.inRange(hsv2, (36, 25, 25), (70, 255,255))

# print('mask', min(min(mask.tolist())))
print(mask)
m1 = csr_matrix(mask)
# print(m1)

gray = cv2.cvtColor(cap, cv2.COLOR_BGR2GRAY)
gray2 = cv2.cvtColor(cap2, cv2.COLOR_BGR2GRAY)
# print(type(gray))
# print(max(max(gray.tolist())))
# print('mask.size', mask.size)
# print('mask.shape', mask.shape)
## slice the green
imask = mask<1
imask2 = mask2<1

# print("imask.nonzero()", imask.nonzero())
green = cap.copy()
green2 = cap2.copy()

green[imask] = 0
green2[imask2] = 0

# cv2.imshow('gray', gray)
print(imask.nonzero())
cc =[]
for ccg in gray[imask.nonzero()] :
    cc.append(ccg)
# print(max(cc))
cc2 = []
for ccg2 in gray2[imask2.nonzero()] :
    cc2.append(ccg2)

count = count_nonzero(green)
# print('count pixel: ', count)


plt.hist(cc, bins=256, color="blue")
plt.hist(cc2, bins=256, color="green")
plt.show()

n1 = len(cc)
n2 = len(cc2)
acc=[]
accX = np.arange(100.5, 230.5, 1)
for xi in accX:
    TP = np.count_nonzero(cc2< xi)
    FP = np.count_nonzero(cc<= xi)
    TN = np.count_nonzero(cc>xi)
    FN = np.count_nonzero(cc2>=xi)
    #see confuse matrix
    acc.append((TP+TN)/(n1+n2))
plt.plot(accX,acc)
xx = (max(acc))
plt.scatter(accX[acc.index(xx)], xx)
print(xx, accX[acc.index(xx)])
plt.show()
# green = imutils.resize(green, width=650)
# cap2 = imutils.resize(cap, width=650)
# cv2.imshow('image witout green', green)
# cv2.imshow('original image', cap2)
cv2.waitKey(0)
cv2.destroyAllWindows()
