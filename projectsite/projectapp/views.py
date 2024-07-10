from django.shortcuts import get_object_or_404, render, redirect
from django.db.models import Prefetch
from django.contrib.auth import logout
from django.contrib.auth.decorators import login_required, user_passes_test
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth import login, authenticate
from django.contrib import messages
from django.core.mail import send_mail, EmailMessage
from django.http import HttpResponse
from django.conf import settings
from django.dispatch import receiver
# from allauth.account.signals import user_signed_up
from django.views.decorators.csrf import csrf_protect
from django.urls import reverse
from django.http import Http404
from django.views.generic import ListView, DetailView, CreateView, UpdateView, DeleteView
from .models import SchoolYear, GradeLevel, Student, Subject, AcademicRecord, ParentGuardian, Form137, School, StudentYearInfo, TotalGradeSubject, Section, Teacher, StudentInfo
from django.urls import reverse_lazy
from .forms import StudentForm, ParentGuardianForm, GradeLevelForm, SubjectForm, SchoolYearForm, SectionForm, TeacherForm, StudentInfoForm, ParentGuardianForm
from django.db.models import Q 
from django.http import JsonResponse
from django.views.decorators.http import require_POST
from django.db import transaction
from datetime import date
from django.views.decorators.http import require_http_methods
from django.views import View
from django.views.decorators.csrf import csrf_exempt

from django.core.paginator import Paginator


# def email_verification_required(request):
#     return render(request, 'account/verified_email_required.html')


# def email_verified_required(view_func):
#     def wrapped_view(request, *args, **kwargs):
#         if EmailAddress.objects.filter(user=request.user, verified=True).exists():
#             return view_func(request, *args, **kwargs)
#         else:
#             return redirect(reverse('email_verification_required'))
#     return wrapped_view

def is_superuser(user):
    return user.is_superuser

def login_view(request):
    if request.user.is_authenticated:
         return redirect('home')
    if request.method == 'POST':
        form = AuthenticationForm(request, data=request.POST)
        if form.is_valid():
            username = form.cleaned_data.get('username')
            password = form.cleaned_data.get('password')
            user = authenticate(request, username=username, password=password)
            if user is not None:
                login(request, user)
                return redirect('home')
            else:
                messages.error(request, 'Invalid username or password.')
    else:
        form = AuthenticationForm()
    return render(request, 'login.html', {'form': form})

@login_required
def home(request):
    return render(request, 'index.html')


def logout_view(request):
    logout(request)
    return redirect('/')


# class CustomConfirmEmailView(ConfirmEmailView):
#     def get(self, *args, **kwargs):
#         try:
#             response = super().get(*args, **kwargs)
#             confirmation = self.get_object()
#             user = confirmation.email_address.user
#             if confirmation.email_address.email == user.email:
#                 print(f"User {user.email} has confirmed their email address.")
#             return response
#         except Http404:
#             return HttpResponse("Email confirmation not found.", status=404)
        
# @csrf_protect
# @receiver(user_signed_up)
# def send_verification_email(request, user, **kwargs):
#     verification_url = request.build_absolute_uri(reverse('account_email_verification_sent'))
#     subject = 'Verify Your Email Address'
#     message = f'Please click on the link below to verify your email address:\n\n{verification_url}'
#     email = EmailMessage(
#         subject,
#         message,
#         settings.EMAIL_HOST_USER,
#         [user.email],
#     )

#     try:
#         email.send()
#         message = "Verification email sent successfully."
#     except Exception as e:
#         message = f"Failed to send verification email. Error: {str(e)}"

#     return render(request, 'account/verification_sent.html', {'message': message})



@login_required
def student_list(request):
    students = Student.objects.all()
    parent_guardians = ParentGuardian.objects.all()
    school_years = SchoolYear.objects.all()
    grade_levels = GradeLevel.objects.all()
    search_query = request.GET.get('search')
    
    if search_query:
        students = students.filter(
            Q(first_name__icontains=search_query) |
            Q(last_name__icontains=search_query) |
            Q(lrn__icontains=search_query) |
            Q(parent_guardians__first_name__icontains=search_query) |  
            Q(parent_guardians__last_name__icontains=search_query)
        )
    
    paginator = Paginator(students, 10) 
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    
    context = {
        'students': page_obj,
        'parent_guardians': parent_guardians,
        'school_years': school_years,
        'grade_levels': grade_levels,
        'paginator': paginator,
        'page_obj': page_obj,
        'is_paginated': page_obj.has_other_pages(),
    }
    return render(request, 'student/student_list.html', context)

@login_required
def allStudent_list(request):
    student_infos = StudentInfo.objects.all()
    parent_guardians = ParentGuardian.objects.all()
    grade_level_filter = request.GET.get('grade_level')
    school_level_filter = request.GET.get('school_year')
    search_query = request.GET.get('search')
    if grade_level_filter:
        student_infos = student_infos.filter(grade_level_id=grade_level_filter)
    if school_level_filter:
        student_infos = student_infos.filter(school_year_id=school_level_filter)

    if search_query:
        student_infos = student_infos.filter(
            Q(student__first_name__icontains=search_query) |
            Q(student__last_name__icontains=search_query) |
            Q(student__lrn__icontains=search_query)
        )

    paginator = Paginator(student_infos, 10) 
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    grade_levels = GradeLevel.objects.all()
    school_years = SchoolYear.objects.all()
    students = [info.student for info in student_infos]
    allStudents = Student.objects.all()
    sections = Section.objects.all()
    
    context = {
        'student_infos': page_obj,
        'grade_levels': grade_levels,
        'students': students,
        'school_years': school_years,
        'allStudents': allStudents,
        'sections': sections,
        'parent_guardians': parent_guardians,
        'page_obj': page_obj,
        'is_paginated': page_obj.has_other_pages(),
    }
    return render(request, 'student/all_student_list.html', context)


@user_passes_test(is_superuser)
@login_required
def add_generic_student(request):
    if request.method == 'POST':
        student_form = StudentInfoForm(request.POST)
        students = Student.objects.all()
        if student_form.is_valid():
            student_form.save()
            return JsonResponse({'success': True})
        
        errors = {
            'errors': student_form.errors,
        }
        return JsonResponse(errors, status=400)
    student_form = StudentInfoForm()
    return render(request, 'student/studentinfo_add_modal.html', {
        'student_form': student_form, 'students': students,
    })


class PrintStudentListView(ListView):
    model = Student
    template_name = 'student/print_student.html'
    context_object_name = 'students'
    paginate_by = 16

    def get_queryset(self):
        queryset = Student.objects.all()
        
        # Filter by school year
        school_year_id = self.request.GET.get('school_year')
        if school_year_id:
            student_infos = StudentInfo.objects.filter(school_year__id=school_year_id).values_list('student_id', flat=True)
            queryset = queryset.filter(id__in=student_infos)
        
        # Filter by grade level
        grade_level_id = self.request.GET.get('grade_level')
        if grade_level_id:
            queryset = queryset.filter(studentinfo__grade_level__id=grade_level_id)
        
        return queryset.distinct()

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        students = self.get_queryset()
        
        # Calculate age for each student and store it in a dictionary
        student_ages = []
        for student in students:
            birth_date = student.birth_date
            age_years = self.calculate_age(birth_date)
            
            if age_years == 0:
                today = date.today()
                age_delta = today - birth_date
                age_months = age_delta.days // 30
                age_days = age_delta.days % 30
            else:
                age_months = None
                age_days = None
            
            student_ages.append({
                'student': student,
                'age_years': age_years,
                'age_months': age_months,
                'age_days': age_days
            })

        # Fetch selected school year and grade level for display in context
        school_year_id = self.request.GET.get('school_year')
        if school_year_id:
            school_year = get_object_or_404(SchoolYear, id=school_year_id)
        else:
            school_year = None
        
        grade_level_id = self.request.GET.get('grade_level')
        if grade_level_id:
            grade_level = get_object_or_404(GradeLevel, id=grade_level_id)
        else:
            grade_level = None

        context['student_ages'] = student_ages
        context['school'] = { 'address': 'Km.5 Tiniguiban Hi-Way, Puerto Princesa City', 'contact_number': 'Tel. # (048) 434 - 0041'}
        context['school_year'] = school_year
        context['grade_level_selected'] = grade_level
        context['school_years'] = SchoolYear.objects.all()
        context['grade_levels'] = GradeLevel.objects.all()
        return context

    def calculate_age(self, birth_date):
        today = date.today()
        age = today.year - birth_date.year - ((today.month, today.day) < (birth_date.month, birth_date.day))
        return age

@login_required
def dashboard(request):
    return render(request, 'dashboard.html')

@user_passes_test(is_superuser)
@login_required
def student_update(request, student_id):
    student = get_object_or_404(Student, id=student_id)
    if request.method == 'POST':
        if request.user.is_superuser:
            form = StudentForm(request.POST, instance=student)
            if form.is_valid():
                form.save()
                messages.success(request, 'Student edited successfully!')
                return redirect('student-list')
        else:
            messages.error(request, 'You do not have permission to edit student records.')
            form = StudentForm(instance=student)
    else:
        form = StudentForm(instance=student)
        if not request.user.is_superuser:
            for field in form.fields.values():
                field.widget.attrs['readonly'] = True

    return render(request, 'student/student_update.html', {'form': form})


@user_passes_test(is_superuser)
@login_required
def add_student(request):
    if request.method == 'POST':
        student_form = ParentGuardianForm(request.POST)
        if student_form.is_valid():
            student = student_form.save()
            response = {
                'success': True,
                'student_id': student.id,
                'student_name': f"{student.first_name} {student.middle_name} {student.last_name}"
            }
            return JsonResponse(response)
        
        errors = {'errors': student_form.errors}
        return JsonResponse(errors, status=400)
    
    return JsonResponse({'error': 'Invalid request'}, status=400)

class StudentDeleteView(DeleteView):
    model = Student
    template_name = 'student/student_confirm_delete.html'
    context_object_name = 'student'
    
    def get_success_url(self):
        return reverse('student-list')

    def delete(self, request, *args, **kwargs):
        response = super().delete(request, *args, **kwargs)
        return response


@login_required
def subject_list(request):
    search_query = request.GET.get('search', '')
    grade_level_id = request.GET.get('grade_level', '')

    subjects = Subject.objects.all()
    if search_query:
        subjects = subjects.filter(name__icontains=search_query)
    if grade_level_id:
        subjects = subjects.filter(grade_level_id=grade_level_id)

    grade_levels = GradeLevel.objects.all()

    return render(request, 'maintenance/subject_list.html', {
        'subjects': subjects,
        'grade_levels': grade_levels,
        'subject_form': SubjectForm(),
        'form_title': 'Add Subject',
        'submit_label': 'Add Subject',
    })

@user_passes_test(is_superuser)
@login_required
def add_subject(request):
    if request.method == 'POST':
        form = SubjectForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('subject-list')
    else:
        form = SubjectForm()
    submit_label = 'Add Subject'  
    return render(request, 'maintenance/subject_list.html', {
        'subject_form': form,
        'submit_label': submit_label,
        'form_title': 'Add Subject'  
    })


@user_passes_test(is_superuser)
@login_required
def update_subject(request, pk):
    subject = get_object_or_404(Subject, pk=pk)
    if request.method == 'POST':
        form = SubjectForm(request.POST, instance=subject)
        if form.is_valid():
            form.save()
            return redirect('subject-list')
    else:
        form = SubjectForm(instance=subject)
    submit_label = 'Update subject' 
    return render(request, 'maintenance/subject_list.html', {
        'subject_form': form,
        'submit_label': submit_label,
        'form_title': 'Edit subject'  
    })

# class SchoolYearListView(ListView):
#     model = SchoolYear
#     template_name = 'grades/schoolyear_list.html'
#     context_object_name = 'schoolyears'

@login_required
def grade_list(request):
    grades = GradeLevel.objects.order_by('id')
    grade_form = GradeLevelForm()
    submit_label = 'Add Grade'  
    return render(request, 'maintenance/gradelevel_list.html', {
        'grades': grades,
        'grade_form': grade_form,
        'submit_label': submit_label,
        'form_title': 'Add Grade'  
    })


@user_passes_test(is_superuser)
@login_required
def add_grade(request):
    if request.method == 'POST':
        form = GradeLevelForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('grade-level')
    else:
        form = GradeLevelForm()
    submit_label = 'Add Grade'  
    return render(request, 'maintenance/gradelevel_list.html', {
        'grade_form': form,
        'submit_label': submit_label,
        'form_title': 'Add Grade'  
    })

@user_passes_test(is_superuser)
@login_required
def update_grade(request, pk):
    grade = get_object_or_404(GradeLevel, pk=pk)
    if request.method == 'POST':
        form = GradeLevelForm(request.POST, instance=grade)
        if form.is_valid():
            form.save()
            return redirect('grade-level')
    else:
        form = GradeLevelForm(instance=grade)
    submit_label = 'Update Grade' 
    return render(request, 'maintenance/gradelevel_list.html', {
        'grade_form': form,
        'submit_label': submit_label,
        'form_title': 'Edit Grade'  
    })

@login_required
def student_report(request):
    students = Student.objects.all()
    grade_levels = GradeLevel.objects.all()
    search_query = request.GET.get('search')

    if search_query:
        students = students.filter(
            Q(first_name__icontains=search_query) |
            Q(last_name__icontains=search_query) |
            Q(lrn__icontains=search_query)
        )
    context = {
        'students': students,
        'grade_levels': grade_levels,
    }
    return render(request, 'report/student_record.html', context)

@login_required
def student_report_card(request):
    student_year_infos = StudentYearInfo.objects.all()
    grade_levels = GradeLevel.objects.all()
    search_query = request.GET.get('search')

    context = {
        'student_year_infos': student_year_infos,
        'grade_levels': grade_levels,
    }
    return render(request, 'report/student_report_card.html', context)

@login_required
def student_record_view(request, id):
    student_infos = get_object_or_404(StudentYearInfo, id=id)
    school_years = SchoolYear.objects.all()
    grade_levels = GradeLevel.objects.all()
    total_grade_subjects = TotalGradeSubject.objects.all()
    context = {
        'student_info': student_infos,
        'school_years': school_years,
        'grade_levels': grade_levels,
        'total_grade_subjects': total_grade_subjects,
    }
    return render(request, 'report/student_info.html', context)

@login_required
def student_form137(request, pk):
    student = get_object_or_404(Student, pk=pk)
    context = {
        'student': student,
    }
    return render(request, 'report/form137.html', context)

@login_required
def school_year(request):
    school_years = SchoolYear.objects.all()
    school_year_form = SchoolYearForm()
    submit_label = 'Add School Year'  
    return render(request, 'maintenance/school_year.html', {
        'school_years': school_years,
        'school_year_form': school_year_form,
        'submit_label': submit_label,
        'form_title': 'Add School Year',
    })


@user_passes_test(is_superuser)
@login_required
def add_year(request):
    if request.method == 'POST':
        form = SchoolYearForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('schoolyear-list')
    else:
        form = SchoolYearForm()
    submit_label = 'Add Year'
    return render(request, 'maintenance/school_year.html', {
        'school_year_form': form,
        'submit_label': submit_label,
        'form_title': 'Add School Year',
        'school_years': SchoolYear.objects.all()
    })

@user_passes_test(is_superuser)
@login_required
def update_year(request, pk):
    year = get_object_or_404(SchoolYear, pk=pk)
    if request.method == 'POST':
        form = SchoolYearForm(request.POST, instance=year)
        if form.is_valid():
            form.save()
            return redirect('schoolyear-list')
    else:
        form = SchoolYearForm(instance=year)
    submit_label = 'Update Grade' 
    return render(request, 'maintenance/school_year.html', {
        'grade_form': form,
        'submit_label': submit_label,
        'form_title': 'Edit School Year'  
    })

@login_required
def section_list(request):
    sections = Section.objects.all()
    grade_levels = GradeLevel.objects.all()
    advisers = Teacher.objects.all()
    grade_level_filter = request.GET.get('grade_level')
    default_grade_level_id = 1  
    
    if grade_level_filter:
        sections = sections.filter(grade_level_id=grade_level_filter)
    else:
        sections = sections.filter(grade_level_id=default_grade_level_id)
    
    section_form = SectionForm()
    submit_label = 'Add Section'  
    return render(request, 'maintenance/section_list.html', {
        'sections': sections,
        'advisers': advisers,
        'section_form': section_form,
        'submit_label': submit_label,
        'form_title': 'Add Section',
        'grade_levels': grade_levels,
        'default_grade_level_id': default_grade_level_id,
    })

@user_passes_test(is_superuser)
@login_required
def add_section(request):
    if request.method == 'POST':
        section_form = SectionForm(request.POST)
        if section_form.is_valid():
            section_form.save()
            return redirect('section-list')
    else:
        section_form = SectionForm()
    submit_label = 'Add Section'  

    return render(request, 'maintenance/section_list.html', {
        'section_form': section_form,
        'submit_label': submit_label,
        'form_title': 'Add Section'  
    })

@user_passes_test(is_superuser)
@login_required
def update_section(request, pk):
    section = get_object_or_404(Section, pk=pk)
    if request.method == 'POST':
        section_form = SectionForm(request.POST, instance=section)
        if section_form.is_valid():
            section_form.save()
            return redirect('section-list')
    else:
        section_form = SubjectForm(instance=section)
    submit_label = 'Update section' 
    return render(request, 'maintenance/section_list.html', {
        'section_form': section_form,
        'submit_label': submit_label,
        'form_title': 'Edit Section'  
    })

@login_required
def teacher_list(request):
    teachers = Teacher.objects.all()
    search_query = request.GET.get('search')

    if search_query:
        teachers = teachers.filter(
            Q(first_name__icontains=search_query) |
            Q(last_name__icontains=search_query) 
        )
    paginator = Paginator(teachers, 10) 
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)

    context = {
        'teachers': page_obj,
        'page_obj': page_obj,
        'is_paginated': page_obj.has_other_pages(),
    }
    return render(request, 'maintenance/teacher_list.html', context)

@user_passes_test(is_superuser)
@login_required
def add_teacher(request):
    if request.method == 'POST':
        teacher_form = TeacherForm(request.POST)
        if teacher_form.is_valid():
            teacher = teacher_form.save()
            return JsonResponse({'success': True})
        else:
            errors = {
                'errors': teacher_form.errors,
            }
            return JsonResponse(errors, status=400)

    teacher_form = TeacherForm()
    return render(request, 'maintenance/teacher_add_modal.html', {
        'teacher_form': teacher_form,
    })


@user_passes_test(is_superuser)
@login_required
def update_teacher(request, pk):
    teacher = get_object_or_404(Teacher, pk=pk)
    if request.method == 'POST':
        teacher_form = TeacherForm(request.POST, instance=teacher)
        if teacher_form.is_valid():
            teacher_form.save()
            return JsonResponse({'status': 1})  
        else:
            errors = teacher_form.errors.as_json()
            return JsonResponse({'status': 0, 'errors': errors})  
    else:
        teacher_data = {
            'first_name': teacher.first_name,
            'middle_name': teacher.middle_name,
            'last_name': teacher.last_name,
            'address': teacher.address,
            'contact_information': teacher.contact_information
        }
        return JsonResponse(teacher_data)  


@user_passes_test(is_superuser)
@login_required
def add_parent(request):
    if request.method == 'POST':
        form = ParentGuardianForm(request.POST)
        if form.is_valid():
            parent = form.save()
            response = {
                'success': True,
                'parent_id': parent.id,
                'parent_name': f"{parent.first_name} {parent.middle_name} {parent.last_name}"
            }
            return JsonResponse(response)
        
        errors = {'errors': form.errors}
        return JsonResponse(errors, status=400)
    
    return JsonResponse({'error': 'Invalid request'}, status=400)

@login_required
def parent_list(request):
    parents = ParentGuardian.objects.all()
    search_query = request.GET.get('search')
    if search_query:
        parents = parents.filter(
            Q(first_name__icontains=search_query) |
            Q(last_name__icontains=search_query)
        )
    paginator = Paginator(parents, 10) 
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
       
    context = {
        'parents' : page_obj,
        'page_obj': page_obj,
        'is_paginated': page_obj.has_other_pages(),

        }
    return render(request, 'maintenance/parent_list.html', context)


def update_parent(request, pk):
    parent = get_object_or_404(ParentGuardian, pk=pk)

    if request.method == 'POST':
        form = ParentGuardianForm(request.POST, instance=parent)
        if form.is_valid():
            form.save()
            return JsonResponse({'status': 1})  
        else:
            errors = form.errors.as_json()
            return JsonResponse({'status': 0, 'errors': errors})  
    else:
        parent_data = {
            'first_name': parent.first_name,
            'middle_name': parent.middle_name,
            'last_name': parent.last_name,
            'address': parent.address,
            'contact_information': parent.contact_information
        }
        return JsonResponse(parent_data)  
    
@csrf_exempt
def delete_parent(request):
    if request.method == 'POST' and request.user.is_superuser:
        parent_id = request.POST.get('id')
        parent = get_object_or_404(ParentGuardian, id=parent_id)
        parent.delete()
        return JsonResponse(1, safe=False) 
    return JsonResponse(0, safe=False) 

@csrf_exempt
def delete_teacher(request):
    if request.method == 'POST' and request.user.is_superuser:
        teacher_id = request.POST.get('id')
        teacher = get_object_or_404(Teacher, id=teacher_id)
        teacher.delete()
        return JsonResponse(1, safe=False) 
    return JsonResponse(0, safe=False) 

