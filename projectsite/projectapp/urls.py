from django.urls import path
from . import views

urlpatterns = [
    path('logout/', views.logout_view, name='logout'),
    path('', views.login_view, name='login'),
    path('home/', views.home, name='home'),
    # path('accounts/confirm-email/<str:key>/', views.CustomConfirmEmailView.as_view(), name='account_confirm_email'),
    # path('send-verification/', views.send_verification_email, name='send_verification_email'),  
    # path('email_verification_required/', views.email_verification_required, name='email_verification_required'),
    path('student/', views.student_list, name='student-list'),
    path('dashboard/', views.dashboard, name='dashboard'),
    path('student/edit/<int:student_id>/', views.student_update, name='student-update'),
    path('student/add/', views.add_student, name='student-add'),
    path('student/print/', views.PrintStudentListView.as_view(), name='student-print'),
    path('student/<int:pk>/delete/', views.StudentDeleteView.as_view(), name='student-delete'),
    path('gradelevel/', views.grade_list, name='grade-level'),
    path('gradelevel/add/', views.add_grade, name='grade-add'),
    path('grade/<int:pk>/update/', views.update_grade, name='grade-update'),
    path('subject/', views.subject_list, name='subject-list'),
    path('subject/add/', views.add_subject, name='subject-add'),
    path('subject/<int:pk>/update/', views.update_subject, name='subject-update'),
    path('report/form137/', views.student_report, name='student_record'),
    path('report/<int:pk>/form137/', views.student_form137, name='student-report-print'),
    path('schoolyear/', views.school_year, name='schoolyear-list'),
    path('schoolyear/add/', views.add_year, name='year-add'),
    path('schoolyear/<int:pk>/update/', views.update_year, name='year-update'),
    path('section/', views.section_list, name='section-list'),
    path('section/add/', views.add_section, name='section-add'),
    path('section/<int:pk>/update/', views.update_section, name='section-update'),
    path('teacher/', views.teacher_list, name='teacher-list'),
    path('teacher/add', views.add_teacher, name='teacher-add'),
    path('teacher/<int:pk>/update/', views.update_teacher, name='teacher-update'),
    path('allStudent/', views.allStudent_list, name='allStudent-list'),
    path('student/generic/add', views.add_generic_student, name='allStudent-add'),
    path('parent/add', views.add_parent, name='parent-add'),
    path('parent/', views.parent_list, name='parent-list'),
    path('parent/update/<int:pk>/', views.update_parent, name='parent-update'),
    path('parentguardian/delete/', views.delete_parent, name='parent-delete'),
    path('teacher/delete/', views.delete_teacher, name='teacher-delete'),
    path('user/', views.user_list, name='user-list'),
    path('user/add/', views.user_add, name='user-add'),
    path('user/update/<int:pk>/', views.user_update, name='user-update'),
    path('invalid/', views.custom_page, name='custom_page'),
    path('student-academic/<int:student_id>/', views.student_academic_record, name='student_academic_record'),
    path('fetch_student_grade/<int:grade_id>/', views.fetch_student_grade, name='fetch_student_grade'),
    path('update_student_grade/<int:grade_id>/', views.update_student_grade, name='update_student_grade'),
    path('delete_student_grade/<int:grade_id>/', views.delete_student_grade, name='delete_student_grade'),

]
    

    # path('student-academic/add/', views.add_student_grade, name='student-grade-add')



