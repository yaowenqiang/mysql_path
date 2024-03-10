import os
import datetime
import time

END_MINUTE = 30
current_date = datetime.datetime.now()
current_date = current_date.minute
while current_date <= END_MINUTE:
    print(f'{datetime.datetime.now()}')
    process_list = os.system('ps -aux --sort=-pcpu')
    print(process_list)
    current_date = datetime.datetime.now()
    current_date = current_date.minute
    time.sleep(1)
