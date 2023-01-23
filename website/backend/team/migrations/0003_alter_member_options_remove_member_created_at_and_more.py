# Generated by Django 4.0.5 on 2022-06-13 05:03

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone
import django_extensions.db.fields


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('team', '0002_auto_20210914_1501'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='member',
            options={'get_latest_by': 'modified'},
        ),
        migrations.RemoveField(
            model_name='member',
            name='created_at',
        ),
        migrations.RemoveField(
            model_name='member',
            name='updated_at',
        ),
        migrations.AddField(
            model_name='member',
            name='author',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='member_create', to=settings.AUTH_USER_MODEL, verbose_name='author'),
        ),
        migrations.AddField(
            model_name='member',
            name='created',
            field=django_extensions.db.fields.CreationDateTimeField(auto_now_add=True, default=django.utils.timezone.now, verbose_name='created'),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='member',
            name='linked_in',
            field=models.TextField(blank=True, max_length=255, null=True),
        ),
        migrations.AddField(
            model_name='member',
            name='modified',
            field=django_extensions.db.fields.ModificationDateTimeField(auto_now=True, verbose_name='modified'),
        ),
        migrations.AddField(
            model_name='member',
            name='twitter',
            field=models.TextField(blank=True, max_length=255, null=True),
        ),
        migrations.AddField(
            model_name='member',
            name='updated_by',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='member_update', to=settings.AUTH_USER_MODEL, verbose_name='last updated by'),
        ),
    ]