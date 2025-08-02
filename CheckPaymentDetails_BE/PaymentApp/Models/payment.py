from django.db import models
from django.db.models.constraints import UniqueConstraint

# https://docs.djangoproject.com/en/5.2/ref/models/fields/
# https://blog.naver.com/mym0404/221545140685

from PaymentApp.Models.account import Account

class Payment(models.Model):
    payment_id = models.AutoField(primary_key=True)
    payment_day = models.DateTimeField()
    account_id = models.ForeignKey(Account, on_delete=models.CASCADE, related_name='rnaccid', db_column='account_id')
    # If Unique Key Type = CHAR, add to field=
    account_number = models.ForeignKey(Account, on_delete=models.CASCADE, related_name='rnaccnum', db_column='account_number', to_field='account_number')
    payed_place = models.CharField(max_length=30)
    amount = models.IntegerField()
    balance = models.IntegerField()

    class Meta:
        db_table = 'payment'