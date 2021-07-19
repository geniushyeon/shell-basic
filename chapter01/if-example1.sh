#!/bin/bash

value1=10
value2=10
# 한 줄로 사용할 경우에는 if [ $value1 = $value2 ]; then으로 표현 가능
# if [$value1 = $value2]로 쓰면 오류(공백이 없기 때문)
if [ $value1 = $value2 ]
then
  echo True
else 
  echo False
fi