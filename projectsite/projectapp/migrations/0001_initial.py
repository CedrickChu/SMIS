# Generated by Django 5.0.6 on 2024-07-03 07:33

import django.core.validators
import django.db.models.deletion
import django.utils.timezone
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('auth', '0012_alter_user_first_name_max_length'),
    ]

    operations = [
        migrations.CreateModel(
            name='User',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('password', models.CharField(max_length=128, verbose_name='password')),
                ('last_login', models.DateTimeField(blank=True, null=True, verbose_name='last login')),
                ('is_superuser', models.BooleanField(default=False, help_text='Designates that this user has all permissions without explicitly assigning them.', verbose_name='superuser status')),
                ('email', models.EmailField(max_length=254, unique=True, verbose_name='email address')),
                ('username', models.CharField(blank=True, max_length=150, unique=True)),
                ('first_name', models.CharField(blank=True, max_length=150)),
                ('phone', models.CharField(max_length=15, unique=True, validators=[django.core.validators.RegexValidator(message="Phone number must be in the format: '+999999999'. Up to 14 digits allowed.", regex='^\\+?1?\\d{9,14}$')])),
                ('first_login', models.BooleanField(default=False)),
                ('start_date', models.DateTimeField(default=django.utils.timezone.now)),
                ('about', models.TextField(blank=True, max_length=500, verbose_name='about')),
                ('is_staff', models.BooleanField(default=False)),
                ('is_active', models.BooleanField(default=True)),
                ('groups', models.ManyToManyField(blank=True, help_text='The groups this user belongs to. A user will get all permissions granted to these groups.', related_name='newuser_set', related_query_name='newuser', to='auth.group', verbose_name='groups')),
                ('user_permissions', models.ManyToManyField(blank=True, help_text='Specific permissions for this user.', related_name='newuser_set', related_query_name='newuser', to='auth.permission', verbose_name='user permissions')),
            ],
            options={
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='GradeLevel',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=50)),
            ],
        ),
        migrations.CreateModel(
            name='ParentGuardian',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('first_name', models.CharField(max_length=100)),
                ('middle_name', models.CharField(max_length=100, null=True)),
                ('last_name', models.CharField(max_length=100)),
                ('address', models.TextField(help_text='Full Address')),
            ],
        ),
        migrations.CreateModel(
            name='School',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('address', models.TextField()),
            ],
        ),
        migrations.CreateModel(
            name='SchoolYear',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('year', models.CharField(max_length=9)),
                ('start_date', models.DateField()),
                ('end_date', models.DateField()),
            ],
        ),
        migrations.CreateModel(
            name='UserProfile',
            fields=[
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, primary_key=True, serialize=False, to=settings.AUTH_USER_MODEL)),
                ('first_name', models.CharField(blank=True, max_length=150, null=True)),
                ('last_name', models.CharField(blank=True, max_length=150, null=True)),
                ('address', models.CharField(blank=True, max_length=255, null=True)),
                ('city', models.CharField(blank=True, max_length=150, null=True)),
                ('country', models.CharField(blank=True, max_length=150, null=True)),
                ('postal_code', models.IntegerField(blank=True, null=True)),
                ('about_me', models.TextField(blank=True, null=True)),
                ('profile_image', models.ImageField(blank=True, null=True, upload_to='profile_images')),
            ],
        ),
        migrations.CreateModel(
            name='AcademicRecord',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('grade', models.DecimalField(blank=True, decimal_places=2, max_digits=5, null=True)),
                ('school_year', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='projectapp.schoolyear')),
            ],
        ),
        migrations.CreateModel(
            name='Section',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('grade_level', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='projectapp.gradelevel')),
            ],
        ),
        migrations.CreateModel(
            name='Adviser',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('first_name', models.CharField(max_length=100)),
                ('middle_name', models.CharField(blank=True, max_length=100, null=True)),
                ('last_name', models.CharField(max_length=100)),
                ('grade_level', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='projectapp.gradelevel')),
                ('school_year', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='projectapp.schoolyear')),
                ('Section', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='projectapp.section')),
            ],
        ),
        migrations.CreateModel(
            name='Student',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('lrn', models.CharField(help_text='Learner Reference Number', max_length=20, null=True, unique=True)),
                ('first_name', models.CharField(max_length=50)),
                ('middle_name', models.CharField(max_length=50, null=True)),
                ('last_name', models.CharField(max_length=50)),
                ('birth_date', models.DateField()),
                ('place_of_birth', models.TextField(help_text='Birth Address')),
                ('gender', models.CharField(choices=[('M', 'Male'), ('F', 'Female')], default='M', max_length=10)),
                ('address', models.TextField(help_text='Full Address')),
                ('promoted', models.BooleanField(default=False)),
                ('grade_level', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='projectapp.gradelevel')),
                ('parent_guardians', models.ForeignKey(help_text='List of Parents/Guardians', null=True, on_delete=django.db.models.deletion.SET_NULL, to='projectapp.parentguardian')),
            ],
        ),
        migrations.CreateModel(
            name='Form137',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('records', models.ManyToManyField(blank=True, to='projectapp.academicrecord')),
                ('school', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='projectapp.school')),
                ('student', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to='projectapp.student')),
            ],
        ),
        migrations.AddField(
            model_name='academicrecord',
            name='student',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='projectapp.student'),
        ),
        migrations.CreateModel(
            name='StudentYearInfo',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('gen_ave', models.DecimalField(blank=True, decimal_places=2, max_digits=5, null=True)),
                ('tdays_of_classes', models.IntegerField(blank=True, null=True)),
                ('tdays_of_present', models.IntegerField(blank=True, null=True)),
                ('promoted', models.BooleanField(default=False)),
                ('adviser', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='projectapp.adviser')),
                ('grade_level', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='current_grade_level', to='projectapp.gradelevel')),
                ('school', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='projectapp.school')),
                ('school_year', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='projectapp.schoolyear')),
                ('section', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='projectapp.section')),
                ('student', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='projectapp.student')),
                ('to_be_classified', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='next_grade_level', to='projectapp.gradelevel')),
            ],
            options={
                'verbose_name': 'Student Year Information',
                'verbose_name_plural': 'Student Year Information',
            },
        ),
        migrations.CreateModel(
            name='Subject',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('grade_level', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='projectapp.gradelevel')),
            ],
        ),
        migrations.AddField(
            model_name='academicrecord',
            name='subject',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='projectapp.subject'),
        ),
        migrations.CreateModel(
            name='TotalGradeSubject',
            fields=[
                ('TGS_ID', models.AutoField(primary_key=True, serialize=False)),
                ('first_grading', models.DecimalField(blank=True, decimal_places=2, max_digits=5, null=True)),
                ('second_grading', models.DecimalField(blank=True, decimal_places=2, max_digits=5, null=True)),
                ('third_grading', models.DecimalField(blank=True, decimal_places=2, max_digits=5, null=True)),
                ('fourth_grading', models.DecimalField(blank=True, decimal_places=2, max_digits=5, null=True)),
                ('FINAL_GRADES', models.DecimalField(blank=True, decimal_places=2, max_digits=5, null=True)),
                ('PASSED_FAILED', models.CharField(blank=True, max_length=20, null=True)),
                ('STUDENT_ID', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='projectapp.student')),
                ('SUBJECT', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='projectapp.subject')),
                ('SYI_ID', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='projectapp.studentyearinfo')),
            ],
            options={
                'verbose_name': 'Total Grade Subject',
                'verbose_name_plural': 'Total Grade Subjects',
            },
        ),
    ]
