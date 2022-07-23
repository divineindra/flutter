import re
from django.shortcuts import render
from django.shortcuts import redirect
from django.http import HttpResponse
from new.models import Data
from new.forms import StdForm


def home(request): 
   # vr=StdForm()
    if request.method== 'POST':
        vr=StdForm(request.POST) 
        try :
           if(vr.is_valid):
               vr.save()    
        except:
          return HttpResponse("<br><h1>Phone Number Already Exists. Bad Luck<h1>")
                  
    return render(request,"task1.html") 

def display(request):
   
    phoneno=request.GET.get('phone')
    lis=Data.objects.filter(phone=phoneno)
    if(len(lis)==0 and phoneno!= None):
         return redirect("errorss")
    else:
        if(len(lis)!=0):
           
            for dat in lis:
                a=dat.name
                b=dat.city
                c=dat.area
                d=dat.phone
                print(a,b,c,d)
            
            a={'names':lis}
            return render(request,"dispdata.html",a)
        
   
    
    return render(request,"display.html")

def errorss(request):
     return render(request,"error.html")

#def dispdata(request,l):
       
       #return HttpResponse("Error")
       #return render(request,"dispdata.html")


