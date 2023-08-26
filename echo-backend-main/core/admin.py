from django.contrib import admin
from . import models

@admin.register(models.User)
class UserAdmin(admin.ModelAdmin):
    list_display = ['first_name', 'last_name', 'email']
    ordering = ['user__first_name', 'user__last_name']