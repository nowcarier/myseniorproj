# -*- encoding: utf-8 -*-
"""
License: MIT
Copyright (c) 2019 - present AppSeed.us
"""

from django.db import models
from django.contrib.auth.models import User

# Create your models here.


class Detail(models.Model):
    # name = 'Electrical'
    id = models.AutoField(primary_key=True)
    air_conditioner_status = models.CharField(
        max_length=200, blank=False, default='')
    light_status = models.CharField(max_length=200, blank=False, default='')
    projector_status = models.CharField(
        max_length=200, blank=False, default='')
    datetime = models.CharField(max_length=200, blank=False, default='')
    timestamp = models.DateTimeField(auto_now_add=True, auto_now=False)


class Event(models.Model):
    uid = models.CharField(max_length=200)
    date = models.DateField()

class Light(models.Model):
    id = models.AutoField(primary_key=True)
    light_status = models.CharField(max_length=200, blank=False, default='')
    datetime = models.CharField(max_length=200, blank=False, default='')
    timestamp = models.DateTimeField(auto_now_add=True, auto_now=False)

class Air(models.Model):
    id = models.AutoField(primary_key=True)
    air_conditioner_status = models.CharField(
        max_length=200, blank=False, default='')
    datetime = models.CharField(max_length=200, blank=False, default='')
    timestamp = models.DateTimeField(auto_now_add=True, auto_now=False)

class Projector(models.Model):
    id = models.AutoField(primary_key=True)
    projector_status = models.CharField(
        max_length=200, blank=False, default='')
    datetime = models.CharField(max_length=200, blank=False, default='')
    timestamp = models.DateTimeField(auto_now_add=True, auto_now=False)
