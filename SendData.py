import datetime
import requests

class SendData():
    # url = 'https://smartubuapp.herokuapp.com/get/PutData'
    url = "http://127.0.0.1:8000/get/PutData"
    def sendData(self ,deviceName, status):
        myobj = {
            'device_name' : deviceName,
            'status' : status,
            'datetime' : datetime.datetime.now().strftime("%A %d %B %Y %I:%M:%S%p")
        }
        sendToServer = requests.post(self.url, data=myobj)
        print(deviceName, status, ':', 'send to server success')