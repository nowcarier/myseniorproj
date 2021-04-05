# -*- encoding: utf-8 -*-
"""
License: MIT
Copyright (c) 2019 - present AppSeed.us
"""

from django.contrib import admin
from .models import Detail, Event

# Register your models here.
admin.site.register(Detail)
admin.site.register(Event)