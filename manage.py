#!/usr/bin/env python
import os
import sys

# First row points to wrong python location, is actually another in vagrant box
# Might need to fix this if the django. commands here are needed
if __name__ == "__main__":
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "mysite.settings")

    from django.core.management import execute_from_command_line

    execute_from_command_line(sys.argv)
