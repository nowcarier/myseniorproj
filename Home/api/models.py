from django.db import models

# Create your models here.
class Users(models.Model):
    username = models.CharField(max_length=70, blank=False, default='')
    first_name = models.CharField(max_length=200,blank=False, default='')
    last_name = models.CharField(max_length=200,blank=False, default='')
    email = models.CharField(max_length=200,blank=False, default='')
    password = models.CharField(max_length=200,blank=False, default='')
    published = models.BooleanField(default=False)

class Detail(models.Model):
    device_name = models.CharField(max_length=200,blank=False, default='')
    device_status = models.CharField(max_length=200,blank=False, default='')
    datetime = models.CharField(max_length=200,blank=False, default='')
    def __str__(self):
        return self.device_name
