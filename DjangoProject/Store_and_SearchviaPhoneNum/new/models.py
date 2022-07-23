from django.db import models
class Data(models.Model):
    name = models.CharField(max_length=30)
    phone = models.IntegerField(unique=True)
    area = models.CharField(max_length=30)
    city = models.CharField(max_length=30)
    def __str__(self):
    
        return self.name+" "+str(self.phone)
    




# Create your models here.
