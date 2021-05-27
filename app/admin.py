# -*- encoding: utf-8 -*-
"""
License: MIT
Copyright (c) 2019 - present AppSeed.us
"""

from django.contrib import admin
from .models import Detail, Event, Light, Air, Projector

# Register your models here.
admin.site.register(Detail)
admin.site.register(Event)
admin.site.register(Light)
admin.site.register(Air)
admin.site.register(Projector)