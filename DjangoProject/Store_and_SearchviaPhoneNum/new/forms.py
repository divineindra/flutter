from new.models import Data

from django.forms import ModelForm

class StdForm(ModelForm):
    class Meta:
        model=Data
        fields= '__all__'
