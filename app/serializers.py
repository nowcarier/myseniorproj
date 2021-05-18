from django.db.models import fields
from app.models import Light, Air, Projector
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
            'is_active',
            'is_staff',
            'date_joined',
            'last_login'
        )
        validators = [
            UniqueTogetherValidator(
                queryset=User.objects.all(),
                fields=["username", "email"]
            )
        ]

class LightSerializer(serializers.ModelSerializer):

    class Meta:
        model = Light
        fields = (
            'id',
            'light_status',
            'datetime',
            'timestamp',
        )

class AirSerializer(serializers.ModelSerializer):

    class Meta:
        model = Air
        fields = (
            'id',
            'air_conditioner_status',
            'datetime',
            'timestamp',
        )

class ProjectorSerializer(serializers.ModelSerializer):

    class Meta:
        model = Projector
        fields = (
            'id',
            'projector_status',
            'datetime',
            'timestamp',
        )