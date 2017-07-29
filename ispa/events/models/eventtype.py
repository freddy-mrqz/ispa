from django.db import models

from core.models import BaseModel

class EventType(BaseModel):

    REQUIRED = 'REQUIRED'
    OPTIONAL = 'OPTIONAL'

    MEETING = 3
    EVENT = 8
    SEMESTER = 5
