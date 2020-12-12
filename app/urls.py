# -*- encoding: utf-8 -*-
"""
License: MIT
Copyright (c) 2019 - present AppSeed.us
"""

from django.urls import path, re_path
from app import views
from .views import UserRecordView
from django.conf.urls import url 

app_name = 'api'
urlpatterns = [
    # Matches any html file - to be used for gentella
    # Avoid using your .html in your resources.
    # Or create a separate django app.
    re_path(r'^.*\.html', views.pages, name='pages'),

    # The home page
    path('', views.index, name='home'),
    path('testGetData', views.PutData, name='testGetData'),
    path('data', views.getDetail, name='getDetail'),
    path('user/', UserRecordView.as_view(), name='users'),
    url( r'^approve/(?P<pk>[0-9]+)$', views.approve, name='approve'),
]
