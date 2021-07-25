# 가장 많이 쓰는 리눅스 명령어(1)
## 1. grep
특정 디렉터리나 로그, 환경 설정 파일 등에서 특정 문자열을 찾을 수 있는 명령어<br/>
제공된 파일이나 선행 명령어의 결과에서 입력한 패턴과 일치하는 라인이 있는지 검색하여 해당 라인 출력
### 1.1. grep 사용법 알아보기
```bash
# 기본 사용법
$ grep [옵션] 패턴 [파일]
```
#### 1.1.1. grep 기본 사용법(1)
grep을 사용할 때는 옵션, 검색할 문자열의 패턴, 그리고 검색 대상이 되는 파일명이 필요하다.
- -i 옵션: 대소문자를 구분하지 않고 패턴을 검색하라
```bash
# /etc/fstab 파일에서 uuid라는 단어(패턴)를 검색해라
$ grep -i 'uuid' /etc/fstab 
```
#### 1.1.2. 기본 사용법(2)
- -e 옵션: 패턴이나 패턴이 저장되어 있는 파일을 이용하여 여러 개의 패턴을 검색한다.
  - 검색하고자 하는 패턴이 하나 이상일 경우 사용
- -f 옵션: 패턴이 저장되어 있는 파일을 여러 개 이용하여 검색한다.
```bash
$ grep [옵션] [-e 패턴 | -f 파일] [파일]
```
#### 1.1.3. 기본 사용법(3)
| 기호와 함께 옵션 및 패턴과 함께 사용: | 기호 앞의 명령어 결과가 grep의 검색 대상이 됨
```bash
명령어 | grep [옵션] [ 패턴 | -e 패턴 ]
```
### 1.2. grep의 다양한 옵션들
#### 1.2.1. 정보 관련 옵션
|옵션|설명|
|--|--|
|--help|grep 명령어 사용법에 대한 도움말을 보여줌|
|-V, --version|grep 명령어의 버전 정보 및 라이센스 정보를 보여줌
```bash
$  grep --help
usage: grep [-abcDEFGHhIiJLlmnOoqRSsUVvwxZ] [-A num] [-B num] [-C[num]]
	[-e pattern] [-f file] [--binary-files=value] [--color=when]
	[--context[=num]] [--directories=action] [--label] [--line-buffered]
	[--null] [pattern] [file ...]
```
```bash
$ grep --version
grep (BSD grep) 2.5.1-FreeBSD
```
#### 1.2.2. 패턴 문법 관련 옵션
|옵션|설명|
|--|--|
|-E, --extended-regexp|확장 정규 표현식에 해당하는 패턴을 검색할 경우 사용됨|
|-F, --fixed-strings|여러 줄로 되어 있는 문자열을 검색할 경우 사용됨|
|-G, --basic-regexp|기본 정규 표현식에 해당하는 패턴을 검색할 때 사용되는 옵션으로, 기본값<br/>옵션을 생략하면 -G 옵션
|-P, --perl-regexp|Perl 방식의 정규 표현식에 해당하는 패턴을 검색할 때 사용되는 옵션으로 다른 옵션에 비해 잘 사용되지는 않음|
- -E 옵션을 사용할 경우
```bash
$ grep 'q[[:lower:]]*\??' regex.txt
# 검색 결과 없음
$ regular-expression git:(main) ✗ grep -E 'q[[:lower:]]*\??' regex.txt
Do you have any questions? or Do you need any help?
If you have any questions, Please send a mail to the email below.
```
-E 옵션을 사용한 경우와 그렇지 않은 경우 검색 결과가 다름을 알 수 있다.
- F 옵션을 사용할 경우
```bash
# 패턴이 여러 줄일 경우 사용
$ grep -F '# Date
# Author
# Description' regex.txt
# Date: 2020-05-05
# Author: NaleeJang
# Description: regular expression test file
```
#### 1.2.3. 매칭 제어 관련 옵션
패턴을 문자열과 매칭시킬 때 적용할 수 있는 옵션들(e.g. 여러 패턴을 검색하는 경우, 특정 패턴은 검색에서 제외하는 경우, 대소문자 구분없이 패턴을 사용할 경우)
|옵션|설명|
|--|--|
|-e 패턴, --regexp=패턴|여러 개의 패턴을 검색할 때 사용, OR 조건으로 검색|
|-f 파일, --file=파일|-e 옵션과 동일하나 패턴 대신 패턴이 포함된 파일을 이용하여 검색할 때 사용됨|
|-i, --ignore-case|패턴 검색 시 대소문자 구분을 무시할 경우 사용|
|-v, --invert-match|해당 패턴을 제외하고 검색할 경우 사용<br/>주석을 제거한 파일 내용만 볼 경우 주로 사용됨|
|-w, --word-regexp|검색하고자 하는 단어가 정확하게 있는 라인만 검색할 경우 사용|
|-x, --line-regexp|검색하고자 하는 패턴과 정확하게 일치하는 라인만 검색할 경우 사용|
|-y|-i 옵션과 동일한 기능 제공
- -f 파일, --file=파일 옵션 사용
```bash
# echo를 이용해 mail과 phone을 파일로 저장
$ echo 'mail' > file1.txt
$ echo 'phone' > file2.txt
# 저장한 파일을 이용해 regex.txt에서 mail과 phone이 포함된 문자열 검색
$ grep -f file1.txt --file=file2.txt regex.txt
If you have any questions, Please send a mail to the email below.
e-mail: nalee999@gmail.com
phone: 010-2222-5668
```
- -v, --invert-match 옵션 사용
```bash
# 주석과 공백을 제외한 파일 내용 확인
$ cat regex.txt| grep -v '^#' | grep -v '^$'
```
- -w, --word-regexp 옵션 사용
```bash
# -w 옵션 없이 검색했을 경우 expression이 포함된 모든 라인 출력
$ grep 'expression' regex.txt
# Description: regular expression test file
# This is an example file for testing regular expressions.	This example file includes control characters.
# -w 옵션을 사용할 경우 expression과 완전히 일치하는 단어가 있는 라인만 출력
$ grep -w 'expression' regex.txt
# Description: regular expression test file
```
#### 1.2.4. 출력 제어 관련 옵션
패턴과 일치하는 단어의 개수를 세거나, 패턴이 포함된 파일명을 찾을 경우 유용하게 사용할 수 있다.
|옵션|설명|
|--|--|
|-c, --count|패턴과 일치하는 단어의 개수를 보여줌|
|--color|GREP_COLORS 환경변수에 의해 정의된 컬러에 맞게 검색한 패턴과 동일한 문자열의 색을 바꿔서 보여줌|
|-L, --files-without-match|검색 대상이 되는 파일 중 패턴과 일치하는 단어가 없는 파일명을 보여줌|
|-l, --files-with-matches|검색 대상이 되는 파일 중 패턴과 일치하는 단어가 있는 파일명을 보여줌|
|-m 라인 수, --max-count=라인 수|패턴과 일치하는 단어가 포함된 라인을 해당 라인 수만큼 보여줌|
|-o, --only-matching|패턴과 일치하는 단어만 보여줌|
|-q, --quiet, --silent|패턴과 일치하는 단어가 있든 없든 아무것도 보여주지 않음|
|-s, --no-messages|존재하지 않거나 읽을 수 없는 파일에 대한 오류 메시지를 보여주지 않음|
- --color 옵션 사용
```bash
# 검색한 문자열을 연두색으로 보여주도록 설정
$ GREP_COLOR="1;32" grep --color 'expression' regex.txt
# Description: regular expression test file
# This is an example file for testing regular expressions.	This example file includes control characters.
```
- -s 옵션: 셸 스크립트에서 결과를 변수로 저장해 처리할 경우 유용하며, 일반적인 상황에서는 사용하지 않는 것이 더 좋다.
### 1.2.5. 출력라인 제어 관련 옵션
|옵션|설명|
|--|--|
|-b, --byte-offset|패턴이 포함된 출력라인의 바이트 수를 라인의 제일 앞부분에 함께 보여줌|
|-H, --with-filename|패턴이 포함된 출력라인의 파일명을 라인의 제일 앞부분에 함께 보여줌|
|-h, --no-filename|-H 옵션과 반대로 패턴이 포함된 출력라인의 파일명을 보여주지 않음|
|--label=LABEL|파일 목록에서 특정 파일을 검색할 경우 검색라인 제일 앞부분에 라벨을 함께 보여줌.<br/> -H 옵션을 함께 사용해야 함|
|-n, --line-number|패턴이 포함된 출력라인 제일 앞부분에 라인 번호를 함께 보여줌|
|-T, --initial-tab|라인 번호나 파일명이 함께 출력될 경우 탭과 함께 간격을 조정하여 보여줌|
|-u, --unix-byte-offsets|패턴이 포함된 출력라인의 바이트 수를 유닉스 스타일로 보여줌<br/>-b 옵션과 함께 사용해야 함|
|-Z, --null|패턴이 포함된 파일명을 출력 시 뉴라인 없이 한 줄로 보여줌.<br/> -l 옵션과 함께 사용해야 함

- -b 옵션 사용
검색 패턴이 포함된 라인의 바이트 수를 라인 제일 앞부분에 함께 보여준다.
```bash
$ grep -b 'express' regex.txt
150:# Description: regular expression test file
288:This is an example file for testing regular expressions.	This example file includes control characters.
```
### 1.2.6. 컨텍스트 라인 제어 관련 옵션
|옵션|설명|
|--|--|
|-A 라인 수, --after-context=라인 수|패턴이 포함된 라인 후에 선언한 라인 수에 해당하는 라인만큼 뒤로 라인을 추가하여 보여줌|
|-B 라인 수, --before-context=라인 수|패턴이 포함된 라인 전에 선언한 라인 수에 해당하는 라인만큼 뒤로 라인을 추가하여 보여줌|
|-C 라인 수, --context=라인 수|패턴이 포함된 랑니 전, 후에 선언한 랑니 수에 해당하는 라인만큼 앞, 뒤로 라인을 추가하여 보여줌|
|--group-separator=그룹구분기호|옵션 -A, -B, -C와 함께 사용할 때 패턴을 기준으로 그룹핑을 해주며, 설정한 그룹구분 기호와 함께 그룹핑을 해줌|
|--no-group-separator|옵션 -A, -B, -C와 함께 사용할 때 기본적으로 패턴을 기준으로 그룹핑을 해주지만, 해당 옵션을 사용하면 그룹핑을 하지 않음|
### 1.2.7. 파일 및 디렉터리 관련 옵션
검색 대상이 디렉터리와 디렉터리 내의 파일이 대상일 경우 사용할 수 있는 옵션
### 1.2.8. 기타 옵션
1. --line-buffered: grep의 경우 패턴과 일치하는 모든 라인 검색이 완료된 후 화면에 보여주지만, 이 옵션을 사용하면 검색된 라인을 바로 보여줌. 많은 양의 로그 검색 시 유용하나 많이 사용하면 성능에 영향을 줄 수 있음
2. -U, --binary: 검색 대상 파일을 바이너리로 취급하여 캐리지 리턴(C)이나 라인피드(LF) 같은 문자를 제거하여 검색
3. -z, --null-data: 패턴이 포함된 파일의 전체 내용 출력