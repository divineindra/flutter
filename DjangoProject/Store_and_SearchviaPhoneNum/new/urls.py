from django.urls import path
from new import views


urlpatterns = [
    path("home", views.home, name="home"),
    path("display/",views.display, name="display"),
    path("errorss/", views.errorss, name="errorss"),
    #path("dispdata/",views.dispdata,name="dispdata")
]