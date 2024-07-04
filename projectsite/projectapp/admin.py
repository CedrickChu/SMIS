from django.contrib import admin
from django.contrib.auth.models import Group
from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import User, UserProfile, SchoolYear, GradeLevel, Student, Subject, AcademicRecord, ParentGuardian, School, Form137, Teacher, StudentYearInfo, TotalGradeSubject, Section
from .widgets import PastCustomDatePickerWidget
from django.db import models

class CustomUserAdmin(UserAdmin):
    model = User
    list_display = ['email', 'username', 'phone', 'is_active', 'is_staff']
    fieldsets = (
        (None, {'fields': ('email', 'password')}),
        ('Personal info', {'fields': ('username', 'phone', 'first_name', 'about')}),
        ('Permissions', {'fields': ('is_active', 'is_staff', 'is_superuser', 'groups', 'user_permissions')}),
        ('Important dates', {'fields': ('last_login', 'start_date')}),
    )
    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('email', 'username', 'phone', 'password1', 'password2'),
        }),
    )
    search_fields = ['email', 'username', 'phone']
    ordering = ['email']

admin.site.register(User, CustomUserAdmin)

@admin.register(UserProfile)
class UserProfileAdmin(admin.ModelAdmin):
    list_display = ('first_name', 'last_name', 'address', 'city', 'country', 'postal_code', 'about_me', 'profile_image')

admin.site.unregister(Group)
admin.site.register(SchoolYear)
admin.site.register(GradeLevel)
admin.site.register(Subject)
admin.site.register(Section)

admin.site.register(ParentGuardian)

@admin.register(Student)
class StudentAdmin(admin.ModelAdmin):
    formfield_overrides = {
        models.DateField: {'widget': PastCustomDatePickerWidget},
    }
    list_display = ['lrn','first_name', 'middle_name', 'last_name', 'birth_date', 'place_of_birth','grade_level','gender','address','promoted', ]
    search_fields = ['first_name', 'last_name']
    list_filter = ['grade_level', 'promoted']

    fieldsets = (
        (None, {
            'fields': ('lrn','first_name','middle_name', 'last_name', 'birth_date', 'place_of_birth','grade_level', 'gender','address','parent_guardians','promoted')
        }),
    )
@admin.register(School)
class SchoolAdmin(admin.ModelAdmin):
    list_display = ('name', 'address')
    search_fields = ('name', 'address')

@admin.register(AcademicRecord)
class AcademicRecordAdmin(admin.ModelAdmin):
    list_display = ('student', 'subject', 'school_year', 'grade')
    list_filter = ('school_year', 'subject')
    search_fields = ('student__first_name', 'student__last_name', 'subject__name')
    raw_id_fields = ('student', 'subject', 'school_year')

@admin.register(Form137)
class Form137Admin(admin.ModelAdmin):
    list_display = ('student', 'school')
    search_fields = ('student__first_name', 'student__last_name', 'school__name')
    raw_id_fields = ('student', 'school', 'records')

@admin.register(Teacher)
class TeacherAdmin(admin.ModelAdmin):
    list_display = ('first_name', 'middle_name', 'last_name', 'contact_information')
    search_fields = ('first_name', 'middle_name', 'last_name')
    ordering = ('last_name', 'first_name')

@admin.register(StudentYearInfo)
class StudentYearInfoAdmin(admin.ModelAdmin):
    list_display = ('student', 'school', 'grade_level', 'school_year', 'adviser', 'gen_ave', 'section', 'promoted')
    list_filter = ('grade_level', 'school_year', 'promoted','section')
    search_fields = ('student__first_name', 'student__last_name')
    ordering = ('-school_year', 'student__last_name', 'student__first_name')

@admin.register(TotalGradeSubject)
class TotalGradeSubjectAdmin(admin.ModelAdmin):
    list_display = ('STUDENT_ID', 'SUBJECT', 'SYI_ID', 'first_grading', 'second_grading', 'third_grading', 'fourth_grading', 'FINAL_GRADES', 'PASSED_FAILED')
    list_filter = ('SYI_ID__school_year', 'SYI_ID__student__last_name', 'SYI_ID__grade_level')
    search_fields = ('SYI_ID__student__first_name', 'SYI_ID__student__last_name', 'SUBJECT__name')
    ordering = ('-SYI_ID__school_year', 'SYI_ID__student__last_name', 'SYI_ID__student__first_name')