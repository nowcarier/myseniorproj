from .serializers import UserSerializer
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import IsAdminUser
from django.contrib.auth.models import User
from django.shortcuts import render
from django.http.response import JsonResponse
from rest_framework.decorators import api_view
from django.views.decorators.csrf import csrf_exempt
from django.http import HttpResponse
from api.models import Detail

def dashboard(request):

    device = Detail.objects.all()
    args = {
        'device': device
    }

    return render(request, 'api/template/pages/dashboard.html', args)

@csrf_exempt
def testGetData(request):
    if request.method == 'POST':
        device_name =  str(request.POST['device_name'])
        device_status = str(request.POST['device_status'])
        datetime = str(request.POST['datetime'])
        ins = Detail(device_name = device_name, device_status =  device_status, datetime = datetime)
        ins.save()
        
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
        return Response(serializer.data)

    def delete(self, format=None):
        users = User.objects.all()
        serializer = UserSerializer(users, many=True)
        users.all().delete()
        return JsonResponse({'message': 'Tutorial was deleted successfully!'}, status=status.HTTP_204_NO_CONTENT)
    

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
            

@api_view(['GET', 'PUT', 'DELETE'])
def tutorial_detail(request, pk):
    try: 
        users = User.objects.get(pk=pk) 
    except User.DoesNotExist: 
        return JsonResponse({'message': 'The users does not exist'}, status=status.HTTP_404_NOT_FOUND) 
 
    if request.method == 'GET': 
        serializer = UserSerializer(users)
        return Response(serializer.data)
    
    if request.method == 'DELETE':
        count = User.objects.get(pk=pk).delete()
        return JsonResponse({'message': '{} Tutorials were deleted successfully!'}, status=status.HTTP_204_NO_CONTENT)

