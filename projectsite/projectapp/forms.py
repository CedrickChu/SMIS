# forms.py
from django import forms
from .models import User, UserProfile, Student, Subject, GradeLevel, SchoolYear, ParentGuardian, Section
from django.contrib.auth.forms import UserCreationForm


class CustomUserCreationForm(UserCreationForm):
    class Meta:
        model = User
        fields = ['email', 'username', 'phone', 'password1', 'password2']

    def __init__(self, *args, **kwargs):
        super(CustomUserCreationForm, self).__init__(*args, **kwargs)
        self.fields['email'].widget.attrs.update({'class': 'form-control'})
        self.fields['username'].widget.attrs.update({'class': 'form-control'})
        self.fields['phone'].widget.attrs.update({'class': 'form-control'})
        self.fields['password1'].widget.attrs.update({'class': 'form-control'})
        self.fields['password2'].widget.attrs.update({'class': 'form-control'})

class UserAndProfileForm(forms.ModelForm):
    username = forms.CharField(max_length=150, required=True)
    email = forms.EmailField(required=True)
    first_name = forms.CharField(max_length=30, required=False)
    last_name = forms.CharField(max_length=30, required=False)
    address = forms.CharField(max_length=255, required=False)
    city = forms.CharField(max_length=100, required=False)
    country = forms.CharField(max_length=100, required=False)
    postal_code = forms.CharField(max_length=20, required=False)
    about_me = forms.CharField(widget=forms.Textarea, required=False)
    profile_image = forms.ImageField(required=False)

    class Meta:
        model = UserProfile
        fields = ['first_name', 'last_name', 'address', 'city', 'country', 'postal_code', 'about_me', 'profile_image']

class UserProfileForm(forms.ModelForm):
    class Meta:
        model = UserProfile
        fields = ['first_name', 'last_name']

    def __init__(self, *args, **kwargs):
        super(UserProfileForm, self).__init__(*args, **kwargs)
        self.fields['first_name'].widget.attrs.update({'class': 'form-control'})
        self.fields['last_name'].widget.attrs.update({'class': 'form-control'})

class StudentForm(forms.ModelForm):
    class Meta:
        model = Student
        fields = '__all__'
        widgets = {
            'lrn': forms.TextInput(attrs={'class': 'form-control'}),
            'first_name': forms.TextInput(attrs={'class': 'form-control'}),
            'middle_name': forms.TextInput(attrs={'class': 'form-control'}),
            'last_name': forms.TextInput(attrs={'class': 'form-control'}),
            'birth_date': forms.DateInput(attrs={'class': 'form-control', 'type': 'date'}),
            'place_of_birth': forms.Textarea(attrs={'class': 'form-control'}),
            'grade_level': forms.Select(attrs={'class': 'form-control', 'style': 'height:40px;'}),
            'gender': forms.Select(attrs={'class': 'form-control', 'style': 'height:40px;'}),
            'address': forms.Textarea(attrs={'class': 'form-control'}),
            'parent_guardians': forms.Select(attrs={'class': 'form-control', 'style': 'height:40px;'}),
        }
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['parent_guardians'].required = False


class SubjectForm(forms.ModelForm):
    class Meta:
        model = Subject
        fields = ['name', 'grade_level']

    def __init__(self, *args, **kwargs):
        super(SubjectForm, self).__init__(*args, **kwargs)
        self.fields['grade_level'].queryset = GradeLevel.objects.all()  
        self.fields['grade_level'].label = 'Grade Level'  

class SchoolYearForm(forms.ModelForm):
    class Meta:
        model = SchoolYear
        fields = ['year', 'start_date', 'end_date']
        widgets = {
            'start_date': forms.DateInput(attrs={'type': 'date'}),
            'end_date': forms.DateInput(attrs={'type': 'date'}),
        }

class ParentGuardianForm(forms.ModelForm):
    class Meta:
        model = ParentGuardian
        fields = '__all__'

class GradeLevelForm(forms.ModelForm):
    class Meta:
        model = GradeLevel
        fields = '__all__'

class SubjectForm(forms.ModelForm):
    class Meta:
        model = Subject
        fields = '__all__'
        
class SectionForm(forms.ModelForm):
    class Meta:
        model = Section
        fields = '__all__'   
   
class LogoutForm(forms.Form):
    pass




