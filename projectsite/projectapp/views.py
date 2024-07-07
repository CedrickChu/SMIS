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
    search_query = request.GET.get('search')
    
    if search_query:
        students = students.filter(
            Q(first_name__icontains=search_query) |
            Q(last_name__icontains=search_query) |
            Q(lrn__icontains=search_query) |
            Q(parent_guardians__first_name__icontains=search_query) |  
            Q(parent_guardians__last_name__icontains=search_query)
        )
        
    context = {
        'students': students,
        'parent_guardians': parent_guardians
    }
    return render(request, 'student/student_list.html', context)

@login_required
def allStudent_list(request):
    student_infos = StudentInfo.objects.all()
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
    grade_levels = GradeLevel.objects.all()
    school_years = SchoolYear.objects.all()
    students = [info.student for info in student_infos]
    allStudents = Student.objects.all()
    sections = Section.objects.all()
    
    context = {
        'student_infos': student_infos,
        'grade_levels': grade_levels,
        'students': students,
        'school_years': school_years,
        'allStudents': allStudents,
        'sections': sections,
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

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        students = self.get_queryset()
        # Calculate age for each student and store it in a dictionary
        student_ages = []
        for student in students:
            birth_date = student.birth_date
            age = self.calculate_age(birth_date)
            student_ages.append({
                'student': student,
                'age': age
            })
        
        context['student_ages'] = student_ages
        context['school'] = { 'address': 'Km.5 Tiniguiban Hi-Way, Puerto Princesa City', 'contact_number': 'Tel. # (048) 434 - 0041'}
        context['grade_level'] = 'Grade Level'
        context['school_year'] = 'School Year'
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
        student_form = StudentForm(request.POST)
        if student_form.is_valid():
            student_form.save()
            return JsonResponse({'success': True})
        
        errors = {'errors': student_form.errors}
        return JsonResponse(errors, status=400)

    student_form = StudentForm()
    parent_guardians = ParentGuardian.objects.all()
    return render(request, 'student/student_add_modal.html', {
        'student_form': student_form,
        'parent_guardians': parent_guardians,
    })

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
    context = {
        'teachers': teachers,
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
def update_teacher(request, teacher_id):
    teacher = get_object_or_404(Teacher, id=teacher_id)
    if request.method == 'POST':
        teacher_form = TeacherForm(request.POST, instance=teacher)
        if teacher_form.is_valid():
            teacher_form.save()
            return JsonResponse({'success': True})
        else:
            errors = {
                'errors': teacher_form.errors,
            }
            return JsonResponse(errors, status=400)

    teacher_form = TeacherForm(instance=teacher)
    return render(request, 'maintenance/teacher_update_modal.html', {
        'teacher': teacher,
        'teacher_form': teacher_form,
    })


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