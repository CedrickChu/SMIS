# forms.py
from django import forms
from .models import User, Student, Subject, GradeLevel, SchoolYear, ParentGuardian, Section, Teacher, StudentInfo
from django.contrib.auth.forms import UserCreationForm, UserChangeForm
from django.core.exceptions import ValidationError



class UserRegistrationForm(UserCreationForm):
    class Meta:
        model = User
        fields = ['username', 'first_name', 'last_name', 'is_superuser', 'password1', 'password2']

    def __init__(self, *args, **kwargs):
        self.instance = kwargs.get('instance')
        super(UserRegistrationForm, self).__init__(*args, **kwargs)
        
        if self.instance and self.instance.pk:
            self.fields['password1'].required = False
            self.fields['password2'].required = False

    def clean_username(self):
        username = self.cleaned_data.get('username')
        if User.objects.filter(username=username).exclude(pk=self.instance.pk).exists():
            raise forms.ValidationError("User with this Username already exists.")
        return username

    def clean_password2(self):
        password1 = self.cleaned_data.get("password1")
        password2 = self.cleaned_data.get("password2")
        if password1 and password2 and password1 != password2:
            raise forms.ValidationError("Passwords don't match")
        return password2

    def save(self, commit=True):
        user = super(UserRegistrationForm, self).save(commit=False)
        if self.cleaned_data.get('password1'):
            user.set_password(self.cleaned_data['password1'])
        if commit:
            user.save()
        return user


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
            'gender': forms.Select(attrs={'class': 'form-control', 'style': 'height:40px;'}),
            'address': forms.Textarea(attrs={'class': 'form-control'}),
            'parent_guardians': forms.Select(attrs={'class': 'form-control', 'style': 'height:40px;'}),
        }




class SubjectForm(forms.ModelForm):
    class Meta:
        model = Subject
        fields = ['name', 'grade_level']

    def __init__(self, *args, **kwargs):
        super(SubjectForm, self).__init__(*args, **kwargs)
        self.fields['grade_level'].queryset = GradeLevel.objects.all()  
        self.fields['grade_level'].label = 'Grade Level'  

class SchoolYearForm(forms.ModelForm):
    STATUS_CHOICES = (
        (True, 'Active'),
        (False, 'Inactive'),
    )

    status = forms.ChoiceField(choices=STATUS_CHOICES)

    class Meta:
        model = SchoolYear
        fields = ['year', 'start_date', 'end_date', 'status']


        widgets = {
            'start_date': forms.DateInput(attrs={'type': 'date'}),
            'end_date': forms.DateInput(attrs={'type': 'date'}),
        }

class ParentGuardianForm(forms.ModelForm):
    class Meta:
        model = ParentGuardian
        fields = '__all__'
        widgets = {
            'first_name': forms.TextInput(attrs={'class': 'form-control'}),
            'middle_name': forms.TextInput(attrs={'class': 'form-control'}),
            'last_name': forms.TextInput(attrs={'class': 'form-control'}),
            'address': forms.Textarea(attrs={'class': 'form-control'}),
            'contact_information': forms.Textarea(attrs={'class': 'form-control'}),
        }

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

class TeacherForm(forms.ModelForm):
    class Meta:
        model = Teacher
        fields = '__all__'
        widgets = {
            'first_name': forms.TextInput(attrs={'class': 'form-control'}),
            'middle_name': forms.TextInput(attrs={'class': 'form-control'}),
            'last_name': forms.TextInput(attrs={'class': 'form-control'}),
            'address': forms.Textarea(attrs={'class': 'form-control'}),
            'contact_information': forms.Textarea(attrs={'class': 'form-control'}),
        }
   

class StudentInfoForm(forms.ModelForm):
    class Meta:
        model = StudentInfo
        fields = '__all__'   

class LogoutForm(forms.Form):
    pass


class GradeLevelFilterForm(forms.Form):
    grade_level = forms.ModelChoiceField(queryset=GradeLevel.objects.all(), required=True, label='Grade Level')