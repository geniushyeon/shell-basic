# 쉘 스크립트 기초 문법(2)
## 1. 조건문
### 1.1. if문
#### 1.1.1. 기본 사용법
- 조건식 앞뒤로는 반드시 대괄호[] 사용
- 대괄호와 조건식 사이에는 반드시 한 칸의 공백 둘 것
```text
if [첫번째조건식]
then
  수행문
elif [두번째조건식]
then
  수행문
else
  수행문
fi
```
- 조건식 타입

|조건식 타입|설명|
|-|-|
|if [ $변수 연산자 $변수 ]; then|일반적인 조건식 타입으로 두 변수의 값을 비교할 때 쓰임|
|if [ $변수 연산자 조건값 ]; then|조건값이 고정되어 있을 경우 변수와 조건값을 비교할 때 사용|
|if [ 연산자 $변수 ]; then|변수의 값이 문자열이거나 디렉토리와 같은 경우일 때 주로 사용|
|if [ 조건식 ] 연산자 [ 조건식 ]; then|여러 개의 조건식을 AND나 OR로 복합 연산할 때 사용|
> 쉘 스크립트에서 세미콜론의 사용: 문법이나 명령어 또는 구문이 완료되어 다음 줄로 넘길 경우에 사용
#### 1.1.2. 예제1) 조건식 타입 - if [ $변수 연산자 변수 ]; then
```bash
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
```
#### 1.1.3. 예제2) 조건식 타입 - if [ $변수 연산자 조건값 ]; then
조건값이 고정되어 있을 경우 사용하는 예제로, 변수와 조건값을 비교할 때 주로 사용
```bash
#!/bin/bash

value=0

if [ $value = 0 ]
then 
  echo True
else
  echo False
fi
```
#### 1.1.4. 예제3) 조건식 타입 - if [ 연산자 $변수 ]; then
변수가 문자열이거나 디렉토리 혹은 파일과 같은 객체형일 때 주로 사용
- 연산자 `-z`: 변수에 저장된 값의 길이가 0인지를 비교하여 0이면 True, 그렇지 않으면 False 리턴
```bash
#!/bin/bash

value=""

if [ -z $value ]
then
  echo True
else
  echo False
fi
```
#### 1.1.5. 조건식 타입 - if [ 조건식 ] 연산자 [ 조건식 ]; then
여러 개의 조건식을 AND나 OR과 같은 논리 연산자에 의한 복합 연산을 할 경우 주로 사용
- `-gt`: A가 B보다 큰가?
- `-lt`: A가 B보다 작은가?
```bash
#!/bin/bash

value=5
if [ $value -gt 0 ] && [ $value -lt 10 ]
then
  echo True
else
  echo False
fi
```
### 1.2. switch-case문
변수의 값에 따라 분기를 해야 하는 경우 주로 사용
#### 1.2.1. 기본 사용법
```text
case $변수 in
  조건값1)
  수행문1 ;;
  조건값2)
  수행문2 ;;
  조건값3)
  수행문3 ;;
  *) 
  수행문4
esac
```
#### 1.2.2. 예제
```bash
#!/bin/bash

case $1 in
  start)
  echo "Start"
  ;;
  stop)
  echo "Stop"
  ;;
  restart)
  echo "Restart"
  ;;
  help)
  echo "Help"
  ;;
  *)
  echo "Please input sub command"
esac

$ sh case-example.sh
Please input sub command
$ sh case-example.sh start
Start
```
## 2. 반복문
### 2.1. for문
#### 2.1.1. 기본 사용법
1. for ... in: 리스트나 배열과 같은 특정 범위의 값들을 하나씩 꺼내어 변수에 저장하고, 리스트나 배열의 해당 값을 모두 사용할 때까지 특정 수행문을 처리하는 방식
```bash
for 변수 in [범위(리스트 또는 배열, 묶음 등)]
do
  반복할 수행문
done
```
2. java나 C언어와 같이 초기값이 특정 조건에 해당할 때까지 값을 증가시키면서 특정 수행문을 반복하는 방법
```bash
for ((변수=초기값; 조건식; 증가값))
do
  반복할 수행문
done
```
#### 2.1.2. 예제1
for문에 반복할 값의 범위를 숫자로 사용
```bash
#!/bin/bash

for num in 1 2 3
do
  echo $num;
done

$ sh for-example1.sh
1
2
3
```
#### 2.1.3. 예제2
반복할 값의 범위를 변수에 저장 후 for문 사용
```bash
#!/bin/bash

numbers="1 2 3"

for num in $numbers
do
  echo $num;
done
```
#### 2.1.4. 예제3) 범위를 디렉토리로 사용할 경우
```bash
# 환경변수를 사용하여 디렉토리 경로를 for문에 사용
#!/bin/bash

for file in $HOME/*
do
  echo $file;
done
```
#### 2.1.5. 예제4) 범위를 중괄호를 사용하여 나타낼 경우
반복문의 범위값을 사용할 때 연속된 숫자를 나열할 경우, 중괄호(`{}`)를 사용하여 초기값과 마지막값을 입력하고 중간에 생략한다는 의미의 ..을 이용하면, 모든 숫자를 나열하지 않아도 되므로 좀 더 효율적으로 반복문을 사용할 수 있다.
```bash
#!/bin/bash

for num in {1..5}
do
  echo $num
done
$ sh for-example4.sh
1
2
3
4
5
```
#### 2.1.6. 예제5) 범위를 배열로 사용할 경우
- 범위를 배열로 사용할 경우, 배열 선언 시 값과 값 사이에 쉼표 사용 X
- for문에 배열의 모든 아이템을 범위로 사용할 경우에는 `${배열[@]}`을 사용하여 배열의 모든 아이템을 사용한다고 명시
```bash
#!/bin/bash

array=("apple" "banana" "pineapple")

for fruit in ${array[@]}
do
  echo $fruit;
done

$ sh for-example6.sh
apple
banana
pineapple
```
#### 2.1.7. 예제6) for문의 두번째 사용법
Java와 거의 같음
```bash
#!/bin/bash

for ((num=0; num<3; num++))
do
  echo $num;
done
```
### 2.2. while문
변수의 값이 특정 조건에 맞을 때까지 계속 반복하는 경우 주로 사용
#### 2.2.1. 기본 사용법
```bash
while [$변수1 연산자 $변수2]
do
  반복할 수행문
done
```
#### 2.2.2. 예제
무한루프에 빠지지 않도록 주의!
```bash
#!/bin/bash

num=0

while [ $num -lt 3 ]
do
  echo $num
  num=$((num+1)) # while문 사용 시 변수가 조건에 맞도록 증가식 넣어주기
done
```