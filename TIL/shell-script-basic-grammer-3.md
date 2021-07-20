# 쉘 스크립트 기초 문법(3) - 연산자, 정규 표현식

## 1. 연산자
쉘 스크립트의 대부분의 문법에서 조건식을 만들기 위해 사용
- 변수의 데이터 타입, 혹은 사용하는 문법에 따라 달라질 수 있다.
### 1.1. 문자열 연산자
변수의 데이터 타입이 문자열인 경우 주로 사용되는 연산자<br/>
해당 연산자와 함께 사용하면 변수에 어떤 값이 저장되든 모두 문자열로 취급한다.
|연산자|사용법|설명|
|-|-|-|
|-z|if [ -z $변수 ]|문자열의 길이가 0이면 참|
|-n|if [ -n $변수 ]|문자열의 길이가 0이 아니면 참|
#### 1.1.1. 문자열 변수가 null값인지 체크
변수가 초기화되었는지 여부를 체크할 때 -z 연산자를 유용하게 사용할 수 있다.
```bash
#!/bin/bash

if [ -z $1 ]
then
  echo True
else
  echo False
fi

$ sh operator-example.sh
True
$ sh operator-example.sh test
False
```
#### 1.1.2. 문자열 변수에 문자열이 저장되었는지 체크
-n 연산자: 문자열의 길이가 0보다 크면 True 리턴
```bash
#!/bin/bash

if [ -n $1 ]
then
  echo True
else
  echo False
fi

$ sh operator-example2.sh
True # 책 내용대로면 False여야 하는데..
$ sh operator-example2.sh test
True # ????
```