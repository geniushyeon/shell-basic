# 셸 스크립트 기초 문법(1)

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

### 3.2.7. 특수 매개변수
현재 실행 중인 스크립트나 명령어의 프로세스 ID(`PID`)를 확인하거나, 바로 앞에서 실행한 명령어나 함수 또는 스크립트 실행이 정상적으로 수행되었는지의 여부를 확인할 수 있는 변수들
|매개변수|설명|
|-|-|
|$$|현재 스크립트 또는 명령어의 PID|
|$?|최근에 실행된 명령어, 함수, 스크립트의 종료 상태|
|$!|최근에 실행한 백그라운드(비동기) 명령의 PID|
|$-|현재 옵션 플래그|
## 3.3. 매개변수 확장
변수를 초기화할 때
- 외부로부터 파라미터를 통해 변수의 값을 설정하는 경우
- 그렇지 않을 경우 기본값을 대체하여 사용하는 경우<br/>

가 많다. (like 삼항 연산자)
- 셸 스크립트나 함수 외부로부터 파라미터에 의해 입력받은 매개변수의 사용 범위를 확장시켜줌
### 3.3.1. 기본 변수 사용법
앞에서 `$변수명`으로 변수를 사용할 수 있다고 배웠지만, 문자열과 문자열 사이에서 외부로부터 입력받은 값을 치환하기 위해 변수를 사용할 경우, $만 사용하면 시스템은 어디서부터 어디까지가 변수명인지를 인식할 수 없음
- 중괄호를 같이 사용(`${변수명}`)하면 시스템이 더 쉽게 변수명을 인식할 수 있다.
```bash
# 변수 AUTH_URL에 "www.example.com/"을 저장
$ AUTH_URL = "www.example.com/"
$ echo "http://$AUTH_URLlogin.html" # 변수명 올바르게 인식 불가능
http://.html
$ echo "http://${AUTH_URL}login.html" # 변수 구분 가능
http://www.example.com/login.html
```
### 3.3.2. 변수를 초기화(할당, 치환)하기 위한 확장 변경자
특정 함수를 호출하거나 셸 스크립트를 실행할 때 함께 넘겨받는 파라미터에 의해 변수의 값을 초기화(할당, 치환)하는 경우, 그리고 변수가 선언된 위치에서 변수의 값을 설정하여 사용하는 경우가 많다. 이런 경우 셸 스크립트에서는 어떻게 표현하고, 어떤 확장자를 사용하면 되는지 알아보자
|확장자|설명|
|-|-|
|${변수-문자열}|변수가 설정되지 않은 경우 문자열로 변수를 치환|
|${변수:문자열}|변수가 설정되지 않았거나 null로 설정된 경우 문자열로 변수 치환|
|${변수=문자열}|변수가 설정되지 않은 경우 문자열을 변수에 저장하고 변수 치환|
|${변수:=문자열}|변수가 설정되지 않았거나 null로 설정된 경우 문자열을 변수에 저장하고 변수 치환|
|${변수+문자열}|변수가 설정된 경우 문자열로 변수 치환|
|${변수:+문자열}|변수가 설정되고, null 이외의 값으로 설정된 경우 문자열로 변수 치환|
|${변수?에러 메시지}|변수가 설정된 경우 변수의 값을 사용하며, 설정되지 않은 경우 표준오류 출력으로 에러 메시지를 출력|
|${변수:?에러메시지}|변수가 null 이외의 값으로 설정된 경우 변수의 값을 사용하며, 변수가 설정되지 않았거나 null인 경우 에러 메시지를 출력하고 셸 종료|
|${변수:시작위치}|변수값이 문자열일 경우 시작 위치부터 문자열 길이 끝까지 출력|
|${변수:시작위치:길이}|변수값이 문자열일 경우 시작 위치부터 길이까지 출력|
#### 3.3.2.1. ${변수-문자열}과 ${변수:-문자열}
```bash
$ OS_TYPE=redhat
# 변수 OS_TYPE에 값이 있으면 저장된 값 redhat을 출력
$ echo ${OS_TYPE:-ubuntu}
redhat
# 변수 OS_TYPE을 삭제하면 변수가 설정되지 않았으므로 ubuntu 출력
$ unset OS_TYPE
$ echo ${OS_TYPE:-ubuntu}
ubuntu
$ echo ${OS_TYPE-ubuntu}
ubuntu
# 변수 OS_TYPE에 ""를 저장해도 null로 인식하여 ubuntu 출력
$ OS_TYPE=""
$ echo ${OS_TYPE:-ubuntu}
ubuntu
$ echo ${OS_TYPE-ubuntu}
ubuntu
```
#### 3.3.2.2. ${변수:-문자열}과 ${변수:=문자열}
${변수:=문자열}을 사용할 경우에는, 변수가 초기화되지 않았을 경우 문자열을 변수에 저장
- 계속해서 해당 변수를 변경된 값으로 사용하고 싶다면 ${변수:=문자열} 사용
```bash
# OS_TYPE에 null 저장
$ OS_TYPE=""
# OS_TYPE==null이므로 redhat 출력
$ echo ${OS_TYPE:=redhat}
redhat
# 값을 저장하지 않음
$ echo $OS_TYPE

# OS_TYPE==null이므로 redhat 출력 + 값 저장
$ e
cho ${OS_TYPE:=redhat}
redhat
$ echo $OS_TYPE
redhat
```
#### 3.3.2.3. 변수가 초기화되었을 경우의 ${변수:+문자열}과 ${변수+문자열}
변수에 값이 설정되어 있을 경우, 설정된 값을 기본값으로 사용하는 것이 아니라 다른 값으로 변수의 기본값을 설정할 경우 사용

#### 3.3.2.4. 변수가 선언되지 않았거나 null일 경우의 ${변수:+문자열}과 ${변수+문자열}
1. ${변수:+문자열}을 사용할 경우<br/>
  변수에 null이 설정되어 있으면, 변수가 초기화되지 않았다고 판단하고 null 출력
2. ${변수+문자열}을 사용할 경우<br/>
  변수가 null로 초기화되었다고 판단하고 문자열 출력
3. 변수가 선언되지 않았을 경우: 둘다 null 출력

#### 3.3.2.5. 변수가 null일 경우 ${변수:?에러메시지}와 ${변수?에러메시지}
```bash
# OS_TYPE에 redhat 저장
$ OS_TYPE="redhat"
# OS_TYPE !== null이므로 redhat 출력
$ echo ${OS_TYPE:?null or not set}
redhat
$ echo ${OS_TYPE?not set}
redhat
# OS_TYPE에 null 저장
$ OS_TYPE=""
# ${변수:?에러메시지}를 사용하면 null은 값으로 취급하지 않으므로 에러 메시지 출력 후 종료
$ echo ${OS_TYPE:?null or not set}
zsh: OS_TYPE: null or not set
# 비정상 종료이므로 특수 매개변수 $?는 1을 출력
$ echo $?
1
# ${변수?에러메시지}는 null도 값으로 취급하므로 null 출력
$ echo ${OS_TYPE?not set}

# 정상 종료이므로 특수 매개변수 $?는 0 출력
$ echo $?
0
```

#### 3.3.2.6. 변수가 선언되지 않았을 경우의 ${변수:?에러메시지}와 ${변수?에러메시지}
변수가 선언되지 않았을 경우에는 둘 다 에러 메시지를 출력한 후 쉘 스크립트 종료
- 어떤 에러 메시지를 써야할지 잘 모르겠다면 `${변수?}`를 사용하면 에러 메시지 출력 후 쉘 스크립트 종료
  - 에러 메시지: parameter null or not set
```bash
$ unset OS_TYPE
$ echo ${OS_TYPE?}
zsh: OS_TYPE: parameter not set
```

#### 3.3.2.7. 변수의 문자열 자르기
1. ${변수:위치}<br/>
  변수에 저장된 문자열의 위치부터 문자열 끝까지 리턴
2. ${변수:위치:길이}<br/>
  특정 문자열 길이만큼만 잘라서 사용할 경우, 해당 길이만큼만 문자열 리턴
3. ${변수:(-위치)}<br/>
  문자열 끝에서 해당 위치만큼 이동한 후 문자열 끝까지 리턴
4. ${변수:(-위치):길이}<br/>
  문자열 끝에서 해당 위치만큼 이동한 후, 문자열 끝까지의 길이에서 설정한 길이만큼을 뺀 길이만큼 리턴
```bash
$ OS_TYPE="Redhat Ubuntu Fedora Debian"
# OS_TYPE에 저장된 문자열 위치 14번째부터 문자열 끝까지 출력
$ echo ${OS_TYPE:14}
Fedora Debian
# OS_TYPE에 저장된 문자열 위치 14번째부터 6글자 출력
$ echo ${OS_TYPE:14:6}
Fedora
# OS_TYPE에 저장된 문자열 끝에서 6번째 글자부터 문자열 끝까지 출력
$ echo ${OS_TYPE:(-6)}
Debian
# OS_TYPE에 저장된 문자열의 끝에서 6번째 글자부터 2글자 출력
$ echo ${OS_TYPE:(-6):2}
De
# OS_TYPE에 저장된 문자열 끝 6번째 글자부터 끝까지의 길이 중 2를 뺀 나머지 길이만큼 출력
$ echo ${OS_TYPE:(-6):-2}
Debi
```
### 3.3.3. 변수의 문자열 값을 변경하기 위한 매개변수 확장자
변수의 값이 문자열로 설정되었을 경우 패턴을 통해 문자열을 변경할 경우에 사용할 수 있는 확장자
|확장자|설명|
|-|-|
|${변수#패턴}|변수에 설정된 문자열 앞에서부터 `처음 찾은 패턴`과 일치하는 패턴 앞의 모든 문자열 제거|
|${변수##패턴}|변수에 설정된 문자열 앞에서부터 `마지막으로 찾은 패턴`과 일치하는 패턴 앞의 모든 문자열 제거|
|${변수%패턴}|변수에 설정된 문자열 `뒤에서부터 처음 찾은 패턴`과 일치하는 패턴 뒤의 모든 문자열 제거|
|${변수%%패턴}|변수에 설정된 문자열 `뒤에서부터 마지막으로 찾은 패턴`과 일치하는 패턴 뒤의 모든 문자열 제거|
|${#변수}|변수의 길이 리턴|
|${변수/찾을문자열/바꿀문자열}|변수에 설정된 문자열에서 첫번째 패턴에 해당하는 부분을 문자열로 변경<br/>문자열을 지정하지 않으면 해당 문자열을 제거|
|${변수/#찾을문자열/바꿀문자열}|변수에 설정된 문자열의 시작 문자열이 패턴과 맞는 경우 문자열로 변경|
|${변수/%찾을문자열/바꿀문자열}|변수에 설정된 문자열의 마지막 문자열이 패턴과 맞는 경우 문자열로 변경|

#### 3.3.3.1. ${변수#패턴}과 ${변수##패턴}
1. ${변수#패턴}: 문자열 앞에서부터 처음 찾은 패턴 앞의 모든 문자열 제거
2. #{변수##패턴}: 문자열 앞에서부터 마지막으로 찾은 패턴 앞의 모든 문자열 제거<br/>

패턴을 기입할 때는 모든 문자열을 의미하는 애스터리스크(`*`)를 패턴 앞에 반드시 사용해야 함
```bash
$ FILE_NAME="myvm_container-repo.tar.gz"
# 앞에서부터 처음 찾은 _ 앞의 모든 문자열 제거
$ echo ${FILE_NAME#*_}
container-repo.tar.gz
# 앞에서무터 마지막으로 찾은 - 앞의 모든 문자열 제거
$ echo ${FILE_NAME##*-}
repo.tar.gz
```
#### 3.3.3.2. ${변수%패턴}과 ${변수%%패턴}
1. ${변수%패턴}: 문자열 뒤에서부터 처음 찾은 패턴 뒤의 모든 문자열 제거
2. ${변수%%패턴}: 문자열 뒤에서부터 마지막으로 찾은 패턴 뒤의 모든 문자열 제거<br/>
이 경우에도 반드시 패턴 뒤에 애스터리스크(`*`) 사용
```bash
# 뒤에서부터 처음 찾은 . 뒤의 모든 문자열 제거
$ echo ${FILE_NAME%.*}
myvm_container-repo.tar
# 뒤에서부터 마지막으로 찾은 . 뒤의 모든 문자열 제거
$ echo ${FILE_NAME%%.*}
myvm_container-repo
```
#### 3.3.3.3. 파일명과 파일 경로 추출 예시
1. 디렉토리 경로 추출
  1. ${변수%패턴}을 사용하여 문자열 뒤에서부터 처음으로 찾은 패턴 뒤의 모든 문자열 삭제
  2. 문자열을 리턴할 수 있도록 /* 사용
  3. 문자열의 뒤에서부터 처음으로 찾은 / 뒤의 모든 문자열을 삭제함으로써 디렉토리 경로 추출
2. 파일명 추출
   1. ${변수##패턴} 사용하여 문자열 앞에서부터 마지막으로 찾은 패턴 앞의 모든 문자열 삭제
3. 변수에 저장된 문자열의 길이
   1. ${#변수} 사용

```bash
# 파일 경로 저장
$ FILE_PATH="/etc/nova/nova.conf"
# 문자열에서 디렉토리 경로 출력
$ echo ${FILE_PATH%/*}
/etc/nova
# 파일 경로에서 파일명 출력
$ echo ${FILE_PATH##*/}
nova.conf
# 변수의 문자열 길이 출력
echo ${#FILE_PATH}
19
```

#### 3.3.3.4. ${변수/찾을문자열/바꿀문자열}과 ${변수//찾을문자열/바꿀문자열}
1. ${변수/찾을문자열/바꿀문자열}: 변수에 설정된 문자열 앞에서부터 처음으로 찾은 문자열을 바꿀문자열로 치환
2. ${변수//찾을문자열/바꿀문자열}: 문자열 전체에서 해당 문자열을 찾아 바꿀문자열로 치환
- 바꿀 문자열을 입력하지 않으면 찾은 문자열 제거
3. 문자열의 시작 부분을 변경할 경우 ${변수/#찾을문자열/바꿀문자열} 사용
4. 문자열의 끝 부분을 변경할 경우 ${변수/%찾을문자열/바꿀문자열} 사용
```bash
$ OS_TYPE="Redhat Linux Ubuntu Fedora Linux"
# 앞에서부터 처음으로 찾은 Linux를 OS로 변경
$ echo ${OS_TYPE/Linux/OS}
Redhat OS Ubuntu Fedora Linux
# 처음부터 끝까지 찾은 Linux를 OS로 변경
$ echo ${OS_TYPE//Linux/OS}
Redhat OS Ubuntu Fedora OS
# 앞에서부터 처음으로 찾은 Linux 삭제
$ echo ${OS_TYPE/Linux}
Redhat  Ubuntu Fedora Linux
# 처음부터 끝까지 찾은 Linux 삭제
$ echo ${OS_TYPE//Linux}
Redhat  Ubuntu Fedora
# Redhat으로 시작하는 단어를 Unknown으로 변경
$ echo ${OS_TYPE/#Redhat/Unknown}
Unknown Linux Ubuntu Fedora Linux
# Linux로 끝나는 단어를 Unknown으로 변경
$ echo ${OS_TYPE/%Linux/Unknown}
Redhat Linux Ubuntu Fedora Unknown
```