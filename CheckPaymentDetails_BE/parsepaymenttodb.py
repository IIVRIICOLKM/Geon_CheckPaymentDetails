from paymentprocessing import get_messages, preprocessing_date, messages_to_columned_datas
import pymysql
from datetime import datetime
from dotenv import load_dotenv
import os

load_dotenv()
db_name = os.getenv('DB_NAME')

# acc_infos -> 계좌 번호 등의 정보 저장
def set_account_table(acc_nums, acc_infos_in_db):
    acc_result, acc_registered_at, acc_updated_at = [], datetime.now(), datetime.now()

    if len(acc_infos_in_db) == 0:
        id = 1
        for acc_num in acc_nums:
            acc_result.append([id, acc_num])
            id += 1
    else:
        # DB에 선저장된 데이터 검사
        id = len(acc_infos_in_db) + 1
        for acc_num in acc_nums:
            for acc_info_in_db in acc_infos_in_db:
                if acc_num == acc_info_in_db[1]:
                    break
                if acc_info_in_db[0] == len(acc_infos_in_db):
                    acc_result.append([id, acc_num])
    return acc_result

def parse_payment_to_database(table, acc_nums, address):
    mysql_conn = pymysql.connect(host=os.getenv('DB_HOST'), user=os.getenv('DB_USER'), password=os.getenv('DB_PASSWORD'), db=db_name)
    mysql_cur = mysql_conn.cursor()

    try:
        mysql_cur.execute(f'select * from {db_name}.account;')
        acc_infos_in_db = mysql_cur.fetchall()

        mysql_cur.execute(f'select bank_id from {db_name}.bank where phone_num={address};')
        _bank_id = mysql_cur.fetchone()
        _bank_id = _bank_id[0]

        acc_result = set_account_table(acc_nums, acc_infos_in_db)

        for row in acc_result:
            _id, _acc_num = row[0], row[1]

            mysql_cur.execute(
                f'insert into {db_name}.account (account_id, account_number, bank_id, account_registered_at, account_updated_at)'
                f'values {_id, _acc_num, _bank_id, str(datetime.now()), str(datetime.now())};')

        # 업데이트 정보 : 모듈 분리 예정
        if acc_result == []:
            mysql_cur.execute(f'update {db_name}.account set account_updated_at = "{datetime.now()}";')

        mysql_cur.execute(f'truncate {db_name}.payment;')

        for row in table:
            _payment_day = str(row[0])
            _account_number = row[1]

            mysql_cur.execute(f'select account_id from {db_name}.account where account_number="{_account_number}";')
            _account_id = mysql_cur.fetchone()
            _account_id = _account_id[0]

            _payed_place = row[2]
            _amount = row[3]
            _balance = row[4]

            mysql_cur.execute(f'insert into {db_name}.payment (payment_day, account_id, account_number, payed_place, amount, balance) '
                              f'values {_payment_day, _account_id, _account_number, _payed_place, _amount, _balance};')
        mysql_conn.commit()
    except Exception as e:
        print(e)
        mysql_conn.commit()

if __name__ == '__main__':
    messages = get_messages('sms_backup_20250729.csv')
    messages = preprocessing_date(messages)
    # 단일 은행의 전화번호만 가져온다고 가정하기
    address = messages[0][2]
    payment_table, acc_nums = messages_to_columned_datas(messages)
    parse_payment_to_database(payment_table, acc_nums, address)