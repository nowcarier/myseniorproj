# -*- encoding: utf-8 -*-
"""
License: MIT
Copyright (c) 2019 - present AppSeed.us
"""

from django.contrib import admin
from .models import Light, Air, Projector

# Register your models here.
admin.site.register(Light)
admin.site.register(Air)
admin.site.register(Projector)