# Generated by Django 3.1.7 on 2021-05-01 13:52

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Air',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('air_conditioner_status', models.CharField(default='', max_length=200)),
                ('datetime', models.CharField(default='', max_length=200)),
                ('timestamp', models.DateTimeField(auto_now_add=True)),
            ],
        ),
        migrations.CreateModel(
            name='Light',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('light_status', models.CharField(default='', max_length=200)),
                ('datetime', models.CharField(default='', max_length=200)),
                ('timestamp', models.DateTimeField(auto_now_add=True)),
            ],
        ),
        migrations.CreateModel(
            name='Projector',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('projector_status', models.CharField(default='', max_length=200)),
                ('datetime', models.CharField(default='', max_length=200)),
                ('timestamp', models.DateTimeField(auto_now_add=True)),
            ],
        ),
    ]
