# awesome-django-project-generate-by-powershell

## 쩔어주는 장고 프로젝트 생성기 by powershell 사용 가이드.

### CLI Usage

본인 Local에 설치된 `powershell` 을 실행시킨다... :

```powershell

# 웬만하면 바탕화면을 entry로 시작하는게 좋다.

Desktop\awesome-django-project_generator.ps1

```

### 사용용도

* 장고서버를 통한 웹사이트 구현을 목표를 두어야한다.
* 자동화 프로그램 파일에 최적화된 파워쉘을 통해 업무시간을 단축하려는 의도를 두어야한다.

### 목적의도

* 매번 프로젝트와 앱을 생성하는 불편함과 새로 `settings.py`, `urls.py`에 생성된 앱에 대한 정보가 자동 기입 되도록 매크로를 제작하였습니다. 사용 방법에 대해서는 아래내용을 참조하시며 사용하시면 됩니다.
* 첫 제작 당시 외부용도가 아닌 지극히 팀 프로젝트를 하며 매번 반복되는 동작을 매크로화 시키는데에 목표를 두고 만들었습니다.
* 단순함에 초점을 바탕으로 두고 `awesome-django-project_generator.ps1` 파일만 실행 시키기만하면 자동으로 프로젝트 폴더생성부터 리포지토리까지 구성해줍니다.

### 사용방법

* 파이썬 패키지 매니저 모듈인 pipenv를 해당 파이썬 버전에 맞게 전역설치로 하길 권장합니다.
* 로컬에 초기 파워쉘에 대한 규정이 서명 된스크립트만 허용이 되어있다면 unregistricted로 변경해주셔야합니다.
* 파워쉘 버전을 최신화 시켜 사용하길 권장합니다. 현재 버전 7.x (하위 서브 버전은 무관 경험적인 버전은 사용하지 말것)

파워쉘 자동화 프로그램에 대해 더 알고 싶으시다면 [ PowerShell 7.2의 새로운 기능! ](https://docs.microsoft.com/ko-kr/powershell/scripting/whats-new/what-s-new-in-powershell-72?view=powershell-7.2) 을 참조 하시면됩니다.

## 파워쉘을 사용하면서 사용하기 좋은 모듈들.

몇몇개의 유용한 모듈들을 공유합니다 :

* [z-jumper](https://github.com/rupa/z) 유저가 접근했던 폴더의 히스토리를 바탕으로 단순 CLI를 통해 해당 폴더 공간으로 점프시키는 프로그램.
* [PsReadLine 2.2.x](https://docs.microsoft.com/ko-kr/powershell/module/psreadline/about/about_psreadline?view=powershell-7.2) 터미널 입력을 바탕으로 다양한 제어 접근을 유저에게 제공하고 발빠른 작업을 수행하도록 도와주는 프로그램.
* [ohmyposh](https://ohmyposh.dev/docs) 로컬 PC 터미널 공간을 꾸며준다 지극히 커스터마이징 용임으로 클라이언트의 미적감각이 요구된다.
* [Terminal-Icons](https://github.com/devblackops/Terminal-Icons) 폴더 아이콘을 터미널 공간에서 유저에게 시각적으로 제공해준다. * 눈요기로만 좋다. 소량의 메모리를 잡아먹는다.
