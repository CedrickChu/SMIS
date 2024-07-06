# Generated by Django 5.0.6 on 2024-07-05 09:47

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('projectapp', '0003_eventcategory_event'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='student',
            name='grade_level',
        ),
        migrations.CreateModel(
            name='StudentInfo',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('grade_level', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='projectapp.gradelevel')),
                ('school_year', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='projectapp.schoolyear')),
                ('section', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='projectapp.section')),
                ('student', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='projectapp.student')),
            ],
        ),
    ]
