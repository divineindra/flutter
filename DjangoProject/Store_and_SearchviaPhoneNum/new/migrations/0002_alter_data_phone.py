# Generated by Django 4.0 on 2022-02-08 08:39

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('new', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='data',
            name='phone',
            field=models.IntegerField(unique=True),
        ),
    ]