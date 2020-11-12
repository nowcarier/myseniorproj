from django.urls import path
from .views import UserRecordView, tutorial_detail
from django.conf.urls import url 
from . import views

app_name = 'api'
urlpatterns = [
    path('user/', UserRecordView.as_view(), name='users'),
    url(r'^tutorials/(?P<pk>[a-z,0-9]+)$', views.tutorial_detail),
    # path('getData/', views.tutorial_detail, name='getdata'),
    path('testGetData', views.testGetData, name='testGetData'),
    path('dashboard', views.dashboard, name='testGetData')
]