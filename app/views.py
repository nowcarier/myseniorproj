# -*- encoding: utf-8 -*-
"""
Copyright (c) 2019 - present AppSeed.us
"""

from django.contrib.auth.decorators import login_required
from django.shortcuts import render, get_object_or_404, redirect
from django.template import loader
from django.http import HttpResponse
from rest_framework.response import Response
from django import template
from django.views.decorators.csrf import csrf_exempt
from app.models import Detail
from rest_framework.views import APIView
from rest_framework.permissions import IsAdminUser
from .serializers import DetailSerializer, UserSerializer
from rest_framework import status
from django.contrib.auth.models import User
from rest_framework.decorators import api_view
from django.http.response import JsonResponse
from rest_framework.parsers import JSONParser 


class UserRecordView(APIView):
    """
    API View to create or get a list of all the registered
    users. GET request returns the registered users whereas
    a POST request allows to create a new user.
    """
    permission_classes = [IsAdminUser]

    def get(self, format=None):
        users = User.objects.all()
        serializer = UserSerializer(users, many=True)
        print(serializer.data)
        return Response(serializer.data)

    def delete(self, format=None):
        users = User.objects.all()
        serializer = UserSerializer(users, many=True)
        users.all().delete()
        return JsonResponse({'message': 'Tutorial was deleted successfully!'}, status=status.HTTP_204_NO_CONTENT)

    @csrf_exempt
    def post(self, request):
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(
                serializer.data,
                status=status.HTTP_201_CREATED
            )
        return Response(
            {
                "error": True,
                "error_msg": serializer.error_messages,
            },
            status=status.HTTP_400_BAD_REQUEST
        )
@csrf_exempt
@api_view(['GET', 'PATCH', 'DELETE'])
def approve(request, pk):
    try: 
        user = User.objects.get(pk=pk) 
    except User.DoesNotExist: 
        return JsonResponse({'message': 'The tutorial does not exist'}, status=status.HTTP_404_NOT_FOUND) 
    
    if request.method == 'GET': 
        user_serializer = UserSerializer(user) 
        return JsonResponse(user_serializer.data)

    elif request.method == 'PATCH': 
        user_data = JSONParser().parse(request) 
        user_serializer = UserSerializer(user, data=user_data) 
        if user_serializer.is_valid(): 
            user_serializer.save() 
            return JsonResponse(user_serializer.data) 
        return JsonResponse(user_serializer.errors, status=status.HTTP_400_BAD_REQUEST) 

@csrf_exempt
@login_required(login_url="/login/")
def index(request):
    device = Detail.objects.all()
    serializer = DetailSerializer(device, many=True)
    users = User.objects.all()
    serializerUsers = UserSerializer(users, many=True)
    users = serializerUsers.data
    devices = serializer.data
    countUser = len(users)
    context = {
        'device': devices,
        'countUser': countUser,
        'users': users
    }
    context['segment'] = 'index'
    html_template = loader.get_template( 'index.html')
    return HttpResponse(html_template.render(context, request))

@login_required(login_url="/login/")
def pages(request):
    context = {}
    # All resource paths end in .html.
    # Pick out the html file name from the url. And load that template.
    try:
        
        load_template      = request.path.split('/')[-1]
        context['segment'] = load_template
        
        html_template = loader.get_template( load_template )
        return HttpResponse(html_template.render(context, request))
        
    except template.TemplateDoesNotExist:

        html_template = loader.get_template( 'page-404.html' )
        return HttpResponse(html_template.render(context, request))

    except:
    
        html_template = loader.get_template( 'page-500.html' )
        return HttpResponse(html_template.render(context, request))

@csrf_exempt
def PutData(request):
    if request.method == 'POST':
        air_conditioner_status =  str(request.POST['air_conditioner_status'])
        light_status = str(request.POST['light_status'])
        projector_status = str(request.POST['projector_status'])
        datetime = str(request.POST['datetime'])
        ins = Detail(air_conditioner_status = air_conditioner_status, light_status =  light_status, projector_status = projector_status, datetime = datetime)
        ins.save()


def getDetail(self, format=None):
    users = Detail.objects.all()
    serializer = DetailSerializer(users, many=True)
    print(serializer.data)
    return Response(serializer.data) 




 