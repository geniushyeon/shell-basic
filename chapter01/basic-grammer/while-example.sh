#!/bin/bash

num=0

while [ $num -lt 3 ]
do
  echo $num
  num=$((num+1)) # while문 사용 시 변수가 조건에 맞도록 증가식 넣어주기
done
