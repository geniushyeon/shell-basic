# 쉘 스크립트 기초 문법 - 정규 표현식
## 1. POSIX 기본 및 확장 문법
패턴을 기술하는 문자열 내의 각 문자들은 메타 문자(특별한 의미)나 정규 문자로 이해된다.
- e.g. 정규식 "a.": a와 일치하는 문자 하나와 뉴라인을 제외한 모든 문자 하나를 갖는 문자열과 일치시키는 메타 문자
## 2. POSIX 문자클래스
찾고자 하는 문자열의 종류. 예를 들어 사용자가 입력한 전화번호가 정상인지, 숫자가 아닌 문자가 입력되지는 않았는지 등을 확인할 경우 사용되는 숫자를 의미하는 문자 -> 문자클래스
## 3. 예제
### 3.1. 메타 문자 .을 이용할 경우
뉴라인을 제외한 한 개의 문자
```bash
# C로 시작해 U로 끝나는 세 글자 단어여야 하며, 가운데 한 개의 글자는 어떤 문자가 와도 상관없음
$ grep 'C.U' regex.txt
CPU model is Intel(R) Core(TM) i7-8665U CPU @ 1.90GHz

# C로 시작해 e로 끝나는 네 글자 단어여야 하며, 가운데 두 글자는 어떤 문자가 와도 상관없음
$ grep 'C..e' regex.txt
CPU model is Intel(R) Core(TM) i7-8665U CPU @ 1.90GHz
```
### 3.2. 메타 문자 *, \, ?와 문자클래스 [:lower:]를 이용할 경우
- *: 문자와 문자 사이 또는 문자 뒤에 어떤 문자열이 와도 상관없을 경우
- \: 특수 문자를 사용할 경우, 해당 문자가 메타 문자가 아닌 일반 문자일 경우 \을 붙여주면 일반 문자로 인식
- ?: 앞에서 검색한 단어 하나가 일치하거나 일치하지 않을 경우에도 검색 가능
- [:lower:]: 알파벳 소문자, grep과 함께 사용할 때는 중첩 대괄호`[[]]` 사용
```bash
# q로 시작하여 ?로 끝나는 단어여야 하며 q와 ? 사이는 영문소문자인 단어
$ grep -E 'q[[:lower:]]*\?' regex.txt
Do you have any questions? or Do you need any help?
# q로 시작하여 ?로 끝나거나 그 외 한 문자로 끝나는 단어여야 하며 q와 ? 사이는 영문소문자인 단어
$ grep -E 'q[[:lower:]]*\??' regex.txt
Do you have any questions? or Do you need any help?
If you have any questions, Please send a mail to the email below.
```
### 3.3. 메타 문자 +와 ^를 이용할 경우
- +: 앞에서 검색한 문자 하나가 계속 반복되는 경우
- ^: 라인 시작 문자가 검색하고자 하는 단어일 경우
```bash
# -2로 시작해 -로 끝나며, 2가 계속 반복되는 단어
$ grep -E '\-2+\-' regex.txt
phone: 010-2222-5668
$ grep '^#' regex.txt
#===========================================#
# Date: 2020-05-05
# Author: NaleeJang
# Description: regular expression test file
#===========================================#
# System Information
# Help
# Contacts
```
### 3.4. 메타 문자 ^, {N}, {N,}, 문자클래스 [:alpha:]
- ^: 라인 시작 문자를 검색할 경우
- [:alpha:]: 알파벳 한 글자
- {N}: 앞에서 검색한 문자나 문자클래스가 몇 번 반복되는지 숫자로 기입
- {N,}: 앞에서 검색한 문자나 문자클래스가 최소 N번 이상일 경우
```bash
# 라인 시작 시 알파벳 5글자로 시작하며, 알파벳 뒤에 :으로 끝나는 단어가 있는 라인
$ grep -E '^[[:alpha:]]{5}:' regex.txt
phone: 010-2222-5668
# 라인 시작 시 알파벳 5글자 이상이며, 뒤에 공백을 가진 단어가 있는 라인
$ grep -E '^[[:alpha:]]{5,}[[:space:]]' regex.txt
Today is 05-May-2020.
Current time is 6:04PM.
Memory size is 32GiB
```
### 3.5. 메타 문자 {N, M}, $ 그리고 문자클래스 [:alpha:][:digit:]
- {N, M}: 앞에서 검색한 문자나 문자클래스가 N번 이상, M번 이하를 표현할 경우 사용
- $: 라인 종료
  - $와 함께 사용할 때는 다음 예제처럼 $ 앞에 검색하고자 하는 단어나 문자클래스를 입력하면 해당 단어나 문자클래스로 끝나는 라인을 찾을 수 있음
- [:digit:]: 0-9 사이의 정수
```bash
# 라인 종료 시 알파벳 4글자 이상 6글자 이하인 단어가 있는 라인
$ grep -E '[[:alpha:]]{4,6}$' regex.txt
 Regular Expression
# Author: NaleeJang
# Description: regular expression test file
# System Information
# Help
# Contacts

# 라인 종료 시 숫자 4글자 이상 6글자 이하인 단어가 있는 라인
$ grep -E '[[:digit:]]{4,6}.$' regex.txt
Today is 05-May-2020.
```
### 3.6. 메타 문자 ^, ^$
- ^: 라인 시작
- ^$: 라인 시작을 알려주는 ^ + 라인 종료를 알려주는 $ = 라인의 공백을 의미함
```bash
# 라인 시작 시 #으로 시작하고, 공백인 라인 제거
$ cat regex.txt | grep -v '^#' | grep -v '^$'
====================
 Regular Expression
====================

Today is 05-May-2020.
Current time is 6:04PM.
This is an example file for testing regular expressions.	This example file includes control characters.
CPU model is Intel(R) Core(TM) i7-8665U CPU @ 1.90GHz
Memory size is 32GiB
Disk is 512 GB
IP Address is 192.168.35.7
Do you have any questions? or Do you need any help?
If you have any questions, Please send a mail to the email below.
e-mail: nalee999@gmail.com
phone: 010-2222-5668
```
### 3.7. 메타 문자 \, \b, \B
- `\`: 메타 문자와 동일한 문자를 검색할 경우 해당 문자가 메타 문자가 아닌 일반 문자임을 알리기 위해 사용
- \b: 단어의 끝
- \B: 라인의 끝 == $
```bash
# . 으로 끝나는 단어가 있는 라인
$ grep '\.\b' regex.txt
Today is 05-May-2020.
Current time is 6:04PM.
This is an example file for testing regular expressions.	This example file includes control characters.
CPU model is Intel(R) Core(TM) i7-8665U CPU @ 1.90GHz
IP Address is 192.168.35.7
If you have any questions, Please send a mail to the email below.
e-mail: nalee999@gmail.com

# .가 있는 라인
$ grep '\.' regex.txt
Today is 05-May-2020.
Current time is 6:04PM.
This is an example file for testing regular expressions.	This example file includes control characters.
CPU model is Intel(R) Core(TM) i7-8665U CPU @ 1.90GHz
IP Address is 192.168.35.7
If you have any questions, Please send a mail to the email below.
e-mail: nalee999@gmail.com

# .으로 끝나는 라인
$ grep '\.\B' regex.txt
This is an example file for testing regular expressions.	This example file includes control characters.
```
### 3.8. 메타 문자 `\<`, `\>`
특정 문자로 시작하는 단어나 특정 문자로 끝나는 단어를 검색할 때 유용하게 쓰일 수 있다.
- `\<`: 단어의 시작
- `\>`: 단어의 끝
```bash
# C로 시작하는 단어가 있는 라인
$ grep '\<C' regex.txt
Current time is 6:04PM.
CPU model is Intel(R) Core(TM) i7-8665U CPU @ 1.90GHz
# Contacts

# n으로 끝나는 단어가 있는 라인
$ grep 'n\>' regex.txt
 Regular Expression
# Description: regular expression test file
This is an example file for testing regular expressions.	This example file includes control characters.
# System Information
```
### 3.9. 문자클래스 `[:cntrl:]`, `[:graph:]`
- `[:cntrl:]`: 특수문자 
  - e.g. 탭, 캐리지 리턴 등 눈으로 볼 수 없는 문단 부호들
- `[:graph:]`: 스페이스를 제외한 아스키코드
```bash
# 특수 문자가 포함된 라인
$ grep '[[:cntrl:]]' regex.txt
This is an example file for testing regular expressions.	This example file includes control characters.
# 아스키 코드가 있는 모든 라인
$ grep '[[:graph:]]' regex.txt | head -n 10
====================
 Regular Expression
====================
#===========================================#
# Date: 2020-05-05
# Author: NaleeJang
# Description: regular expression test file
#===========================================#
Today is 05-May-2020.
Current time is 6:04PM.
```
### 3.10. 문자클래스 `[:print:]`
- 스페이스를 포함한 아스키 코드
```bash
# 스페이스를 포함한 아스키 코드가 있는 모든 라인
$ grep '[[:print:]]' regex.txt | head -n 10
====================
 Regular Expression
====================

#===========================================#
# Date: 2020-05-05
# Author: NaleeJang
# Description: regular expression test file
#===========================================#
Today is 05-May-2020.
```
### 3.11. 메타 문자 {N,}, 문자클래스 `[:alpha:]`, `[:punct:]`
- `[:punct:]`: 문장 부호
  - e.g. 마침표, 쉼표, 물음표, 세미콜론
```bash
# 알파벳 6글자 이상이며, 문장 부호로 끝나는 단어가 있는 라인
$ grep -E '[[:alpha:]]{6,}[[:punct:]]' regex.txt
# Author: NaleeJang
# Description: regular expression test file
This is an example file for testing regular expressions.	This example file includes control characters.
Do you have any questions? or Do you need any help?
If you have any questions, Please send a mail to the email below.
```
### 3.12. 메타 문자 `\<`, `\>`, *, {N}, 문자클래스 `[:xdigit:]`
- `[:xdigit:]`: 16진수에 해당하는 문자들만 허용
  - IPv6과 같은 주소를 검색할 경우 단어 시작과 끝을 의미하는 메타 문자 `\<`, `\>`와 검색한 문자클래스가 몇 번 반복되는지를 의미하는 {N}을 사용하면 쉽게 검색할 수 있다.
```bash
# 16진수 2글자로 시작하며, 16진수 2글자로 끝나는 단어가 있는 라인
$ ip a | grep -E '\<[[:xdigit:]]{2}:*:[[:xdigit:]]{3}\>'
```