from django.db.models import fields
from app.models import Detail
from django.contrib.auth.models import User
from rest_framework import serializers
from rest_framework.validators import UniqueTogetherValidator


class UserSerializer(serializers.ModelSerializer):

    def create(self, validated_data):
        user = User.objects.create_user(**validated_data)
        return user

    class Meta:
        model = User
        fields = (
            'id',
            'username',
            'first_name',
            'last_name',
            'email',
            'password',
            'is_active'
        )
        validators = [
            UniqueTogetherValidator(
                queryset=User.objects.all(),
                fields=["username", "email"]
            )
        ]

class DetailSerializer(serializers.ModelSerializer):

    class Meta:
        model = Detail
        fields = (
            'air_conditioner_status',
            'light_status',
            'projector_status',
            'datetime'
        )