#!/bin/sh

# Usage: ./morning_beancount.sh 2022-04
# 2022-04-10.md:- 7.00
# 2022-04-11.md:- 6.50<br>

file_name=$1
rm -rf $file_name.bean
touch $file_name.bean

days=`grep "#早起" --with-filename $file_name-*.md | awk -F' ' '{print substr($1,1, 10)}'`
time=`grep "#早起" --with-filename $file_name-*.md | awk '{print substr($4,1,4)}'`
# \n 转为 space
days=`echo $days`
time=`echo $time`
# string to array
IFS=' ' read -r -a arr_day <<< $days
IFS=' ' read -r -a arr_time <<< $time

for index in "${!arr_day[@]}"
do
    echo "$index ${arr_day[index]}"
    bc_format=`echo -e "${arr_day[$index]} \* \"早起\" \"${arr_time[$index]}\" \\\n\r    Expenses:Exercise:早起 ${arr_time[$index]}TIME \\n\r\tEquity:Exercise "`
    echo $bc_format >> $file_name.bean
    echo -e " " >> $file_name.bean
done


sed -i 's/\\\*/*/g' $file_name.bean
# 2022-04-12 * "早起" "6.50"
#    Expenses:Exercise:早起                        6.50TIME
#    Equity:Exercise