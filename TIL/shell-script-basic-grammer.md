# 셸 스크립트 기초 문법

## 1. 셸 스크립트 만들기
```shell
# vi 에디터를 통해 파일 생성

# 시작 시 #!/bin/bash를 붙여 해당 파일이 셸 스크립트라는 것을 알려줌
#!/bin/bash

echo "hello world!"

# :wq
```
## 2. 셸 스크립트 실행
### 2.1. sh 명령어
```bash
$ sh myshell.sh
hello world!
```
### 2.2. chmod 명령어 이용
셸 스크립트 파일에 실행 권한을 주고, 직접 셸 스크립트를 실행하는 방법
```bash
$ chmod +x myshell.sh
$ ./myshell.sh
hello world!
```
### 2.3. 명령어와 함께 프롬프트에서 바로 실행
```bash
$ echo "hello world!"
hello world
```
## 3. 변수 사용하기
### 3.1. 변수 선언
```bash
#!/bin/bash

# 변수 선언과 값 저장
language="Korean"
# 변수 사용
echo "I can speak $language"

```
```bash
$ sh myshell.sh
I can speak Korean
```
- 디렉터리 생성하기
```bash
#!/bin/bash

language="Korea English Japan"

mkdir $language
```
- 셸 스크립트에서 변수는 특별한 타입을 요구하지 않으므로, 쉽게 변수를 선언하고 사용할 수 있다.
### 3.2. 변수의 종류
#### 3.2.1. 함수
특정 동작이나 목적을 위해 만들어진 것
- 스크립트를 재사용하기 위해
- 스크립트의 줄 수를 줄여주고 좀 더 효율적으로 스크립트를 만들 수 있다.
```bash
#!/bin/bash

# 파라미터로 입력된 문자열을 화면에 출력
function print() {
  echo $1
}

print "I can speak Korean"
```
#### 3.2.2. 전역 변수
스크립트 전체에서 사용할 수 있는 변수
```bash
#!/bin/bash

language="Korean"
function print() {
  echo "I can speak $language"
}

print

# I can speak Korean
```
#### 3.2.3. 지역 변수
함수 내에서만 변수에 저장된 값이 유효한 변수
- `local` 키워드 사용
```bash
#!/bin/bash

language="Korean"

function learn() {
  local learn_language="English"
  echo I am learning $learn_language

}
function print() {
  echo "I can speak $1"
}

learn
print $language
print $learn_language

# I am learning English
# I can speak Korean
# I can speak - learn_language 변수 사용 불가
```

#### 3.2.4. 예약변수(환경변수)
시스템에서 사용하고 있는 변수들
- 환경변수로 셸 스크립트 작성 시 시스템의 환경 정보를 확인하는 경우 매우 유용
```bash
# 사용자의 홈 디렉터리
echo $HOME

# 실행 파일 디렉터리 경로
echo $PATH
```
더 많은 변수는 책 p.27-p.29 참조
#### 3.2.5. 위치 매개변수
스크립트 수행 시 함께 넘어오는 파라미터
|매개변수|설명|
|-|-|
|$0|실행된 스크립트 이름|
|$1|파라미터 순서대로 번호가 부여되며, 10번째부터는 `{}`로 감싸줘야 함
|$*|전체 인자 값|
|$@|전체 인자 값($*와 동일하지만, 쌍따옴표로 변수를 감싸면 다른 결과가 나옴)
|$#|매개변수의 총 개수|
```bash
#!/bin/bash

echo "This shell script name is $0"
echo "I can speak $1 and $2"
echo "This shell script parameters are $*"
echo "This shell script parameters are $@"
echo "This parameter count is $#"

$ sh mylanguage.sh Korea English
# This shell script name is mylanguage.sh
# I can speak Korean and English
# This shell script parameters are Korean English
#This shell script parameters are Korean English
# This parameter count is 2
```
#### 3.2.6. $*과 $@
1. $* 사용
큰따옴표와 상관없이 공백을 기준으로 문자열을 각각의 파라미터로 인식
```bash
#!/bin/bash

for language in $*
do
  echo "I can speak $language"
done

$ sh mylanguage.sh Korean English "Spanish French"
# I can speak Korean
# I can speak English
# I can speak Spanish
# I can speak French
```
$@를 사용해도 결과는 동일<br>
2. 큰따옴표와 함께 $* 사용하기
```bash
#!/bin/bash

for language in "$*"
do
  echo "I can speak $language"
done

$ sh mylanguage.sh Korean English "Spanish French"
# I can speak Korean English Spanish French
```
$@를 사용하면
```bash
#!/bin/bash

for language in "$*"
do
  echo "I can speak $language"
done

$ sh mylanguage.sh Korean English "Spanish French"
# I can speak Korean
# I can speak English
# I can speak Spanish French
```