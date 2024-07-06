from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, PermissionsMixin
from django.utils import timezone
from django.core.exceptions import ValidationError
from django.core.validators import RegexValidator

class CustomAccountManager(BaseUserManager):
    def create_user(self, email, username, password=None, **extra_fields):
        user = self.model(
            email=self.normalize_email(email),
            username=username,
            phone=extra_fields.get('phone', ''),
        )
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, username, password=None, **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)

        if extra_fields.get('is_staff') is not True:
            raise ValueError('Superuser must have is_staff=True.')
        if extra_fields.get('is_superuser') is not True:
            raise ValueError('Superuser must have is_superuser=True.')

        return self.create_user(email, username, password, **extra_fields)

class User(AbstractBaseUser, PermissionsMixin):
    email = models.EmailField(('email address'), unique=True)
    username = models.CharField(max_length=150, blank=True, unique=True)
    first_name = models.CharField(max_length=150, blank=True)
    phone_regex = RegexValidator(regex=r'^\+?1?\d{9,14}$', message="Phone number must be in the format: '+999999999'. Up to 14 digits allowed.")
    phone = models.CharField(validators=[phone_regex], max_length=15, unique=True)
    first_login = models.BooleanField(default=False)
    start_date = models.DateTimeField(default=timezone.now)
    about = models.TextField(('about'), max_length=500, blank=True)
    is_staff = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True)
    objects = CustomAccountManager()
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['username', 'phone']

    groups = models.ManyToManyField(
        'auth.Group',
        verbose_name=('groups'),
        blank=True,
        help_text=('The groups this user belongs to. A user will get all permissions granted to these groups.'),
        related_name='newuser_set',
        related_query_name='newuser',
    )
    user_permissions = models.ManyToManyField(
        'auth.Permission',
        verbose_name=('user permissions'),
        blank=True,
        help_text=('Specific permissions for this user.'),
        related_name='newuser_set',
        related_query_name='newuser',
    )

    def __str__(self):
        return self.email

    def get_email_field_name(self):
        return self.email

    def has_perm(self, perm, obj=None):
        return self.is_staff

    def has_module_perms(self, app_label):
        return self.is_staff

class UserProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, primary_key=True)
    first_name = models.CharField(max_length=150, blank=True, null=True)
    last_name = models.CharField(max_length=150, blank=True, null=True)
    address = models.CharField(max_length=255, blank=True, null=True)
    city = models.CharField(max_length=150, blank=True, null=True)
    country = models.CharField(max_length=150, blank=True, null=True)
    postal_code = models.IntegerField(blank=True, null=True)
    about_me = models.TextField(blank=True, null=True)
    profile_image = models.ImageField(upload_to='profile_images', blank=True, null=True)

    def __str__(self):
        return self.user.username

class SchoolYear(models.Model):
    year = models.CharField(max_length=9)
    start_date = models.DateField()
    end_date = models.DateField()
    status = models.BooleanField(default=False, help_text='Is this the current school year?')

    def __str__(self):
        return f"{self.year} ({self.start_date.year}-{self.end_date.year})"

class GradeLevel(models.Model):
    name = models.CharField(max_length=50) 

    def __str__(self):
        return self.name

class ParentGuardian(models.Model):
    first_name = models.CharField(max_length=100)
    middle_name = models.CharField(max_length=100, null=True)
    last_name = models.CharField(max_length=100)
    address = models.TextField(help_text='Full Address')
    contact_information = models.CharField(max_length=100, null=True)

    def __str__(self):
        return f"{self.first_name} {self.last_name}"

class School(models.Model):
    name = models.CharField(max_length=100)
    address = models.TextField()

    def __str__(self):
        return self.name
    
class Teacher(models.Model):
    first_name = models.CharField(max_length=100)
    middle_name = models.CharField(max_length=100, null=True)
    last_name = models.CharField(max_length=100)
    address = models.TextField(help_text='Full Address')
    contact_information = models.CharField(max_length=100, null=True)

    def __str__(self):
        return f"{self.first_name} {self.last_name}"
    
class Section(models.Model):
    name = models.CharField(max_length=100)
    grade_level = models.ForeignKey(GradeLevel, on_delete=models.CASCADE)
    adviser = models.OneToOneField(Teacher, on_delete=models.CASCADE)


    def __str__(self):
        return self.name
    
class Student(models.Model):
    lrn = models.CharField(max_length=20, unique=True, help_text='Learner Reference Number', null=True)
    first_name = models.CharField(max_length=50)
    middle_name = models.CharField(max_length=50, null=True)
    last_name = models.CharField(max_length=50)
    birth_date = models.DateField()
    place_of_birth = models.TextField(help_text='Birth Address')
    gender = models.CharField(max_length=10, choices=[('M', 'Male'), ('F', 'Female')], default='M')
    address = models.TextField(help_text='Full Address')
    parent_guardians = models.ForeignKey(ParentGuardian,  on_delete=models.SET_NULL, null=True, help_text='List of Parents/Guardians')
    promoted = models.BooleanField(default=False)

    def __str__(self):
        return f"{self.first_name} {self.last_name}"
    
class StudentInfo(models.Model):
    student = models.ForeignKey(Student, on_delete=models.CASCADE)
    school_year = models.ForeignKey(SchoolYear, on_delete=models.CASCADE)
    section = models.ForeignKey(Section, on_delete=models.CASCADE)
    grade_level = models.ForeignKey(GradeLevel, on_delete=models.SET_NULL, null=True)

class Subject(models.Model):
    name = models.CharField(max_length=100)
    grade_level = models.ForeignKey(GradeLevel, on_delete=models.CASCADE)

    def __str__(self):
        return self.name

    
class StudentYearInfo(models.Model):
    student = models.ForeignKey(Student, on_delete=models.CASCADE)
    school = models.ForeignKey(School, on_delete=models.CASCADE)
    grade_level = models.ForeignKey(GradeLevel, on_delete=models.CASCADE, related_name='current_grade_level')
    school_year = models.ForeignKey(SchoolYear, on_delete=models.CASCADE)
    adviser = models.ForeignKey(Teacher, on_delete=models.CASCADE)
    gen_ave = models.DecimalField(max_digits=5, decimal_places=2, null=True, blank=True)
    to_be_classified = models.ForeignKey(GradeLevel, on_delete=models.CASCADE, related_name='next_grade_level')
    tdays_of_classes = models.IntegerField(null=True, blank=True)
    tdays_of_present = models.IntegerField(null=True, blank=True)
    section = models.ForeignKey(Section, on_delete=models.CASCADE, null=True)
    promoted = models.BooleanField(default=False)
    class Meta:
        verbose_name = 'Student Year Information'
        verbose_name_plural = 'Student Year Information'

    def __str__(self):
        return f'{self.student} - Grade {self.grade_level} - {self.school_year}'
       
class TotalGradeSubject(models.Model):
    TGS_ID = models.AutoField(primary_key=True)
    STUDENT_ID = models.ForeignKey(Student, on_delete=models.CASCADE)
    SYI_ID = models.ForeignKey(StudentYearInfo, on_delete=models.CASCADE)
    SUBJECT = models.ForeignKey(Subject, on_delete=models.CASCADE)
    first_grading = models.DecimalField(max_digits=5, decimal_places=2, null=True, blank=True)
    second_grading = models.DecimalField(max_digits=5, decimal_places=2, null=True, blank=True)
    third_grading = models.DecimalField(max_digits=5, decimal_places=2, null=True, blank=True)
    fourth_grading = models.DecimalField(max_digits=5, decimal_places=2, null=True, blank=True)
    FINAL_GRADES = models.DecimalField(max_digits=5, decimal_places=2, null=True, blank=True)
    PASSED_FAILED = models.CharField(max_length=20, null=True, blank=True)

    class Meta:
        verbose_name = 'Total Grade Subject'
        verbose_name_plural = 'Total Grade Subjects'

    def __str__(self):
        return f'{self.STUDENT_ID} - {self.SUBJECT} - {self.SYI_ID.school_year}'

class AcademicRecord(models.Model):
    student = models.ForeignKey(Student, on_delete=models.CASCADE)
    school_year = models.ForeignKey(SchoolYear, on_delete=models.CASCADE)
    subject = models.ForeignKey(Subject, on_delete=models.CASCADE)
    grade = models.DecimalField(max_digits=5, decimal_places=2, null=True, blank=True)

    def __str__(self):
        return f"{self.student} - {self.subject} - {self.school_year}"
    

    
class Form137(models.Model):
    student = models.OneToOneField(Student, on_delete=models.CASCADE)
    school = models.ForeignKey(School, on_delete=models.CASCADE)
    records = models.ManyToManyField(AcademicRecord, blank=True)

    def __str__(self):
        return f"Form 137 - {self.student}"
    


class Payment(models.Model):
    payment_user = models.ForeignKey(User, on_delete=models.CASCADE)
    student = models.ForeignKey(Student, on_delete=models.CASCADE)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    date_paid = models.DateField(auto_now_add=True)
    payment_method = models.CharField(max_length=50)
    status = models.CharField(max_length=20, choices=[
        ('paid', 'Paid'),
        ('pending', 'Pending'),
        ('refunded', 'Refunded'),
    ])
    notes = models.TextField(blank=True)

    def __str__(self):
        return f"{self.student}'s Tuition Fee Payment"
    
class EventCategory(models.Model):
    name = models.CharField(max_length=200)

    def __str__(self):
        return self.name

class Event(models.Model):
    """
    Represents an event organized by the institution.
    
    Fields:
    - title: The title of the event.
    - category: The target audience or participants of the event.
    """
    title = models.CharField(max_length=200)
    note = models.CharField(max_length=500)
    color = models.CharField(max_length=20)
    category = models.ForeignKey(EventCategory, on_delete=models.CASCADE)
    start_date_time = models.DateTimeField()
    end_date_time = models.DateTimeField()

    def __str__(self):
        return self.title

