#!/bin/bash

source ./ENV/bin/activate
export DJANGO_SETTINGS_MODULE=chronam.settings
django-admin.py load_batch /opt/chronam/data/batches/batch_txa_batt_ver58