pipenv --python 3
pipenv install django lxml

# 쉘 스크립트 사용 허가 시키기.
# Set-ExecutionPolicy -ExecutionPolicy RemoteSigned 
# https://m.blog.naver.com/gyul611/222194321084 한글꺠짐현상 제거.
# https://www.youtube.com/watch?v=S2syBlpz_4k hub craete tutorial
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/
# 터미널 UTF-8 설정하기.
$env:LC_ALL='C.UTF-8'
[System.Console]::InputEncoding = [System.Console]::OutputEncoding = [System.Text.Encoding]::UTF8

#region [0] awesome-project-creator
$generator={
# 터미널 변수 셋업. 
[string] $date = Get-Date -format "yyyyMMdd"
[string] $current_location_name = Split-Path -Path (Get-Location) -Leaf
[string] $project_name = "토마스"

Write-Host --------------------------------------------
Write-Host bat name : Awesome-django-project-creator-start-tool-kit.
Write-Host version  : $date
Write-Host index    :
Write-Host            1. Create django shell scripts [ join.ps1, run.ps1, out.ps1 ]
Write-Host            2. Create git-hub shell scripts [ pull.ps1, push.ps1 ]
Write-Host            3. Create folder access shell scripts [ access_django.ps1, access_git.ps1 ]
Write-Host            4. Create access folders [ access_django_dir.ps1, access_git_dir.ps1 ]
Write-Host --------------------------------------------

timeout 5

#region [1] batches, settings 폴더를 생성합니다.
Write-Host [1] batches, settings 폴더를 생성합니다. # | OUT-NULL대신 > $null을 쓴다 왜하냐하면 전자는 Overhead가 60%인 반면 $null은 0.3%이기 때문이다.
New-Item -Path ".\batches\django_bat", ".\batches\git_bat" -ItemType "directory" > $null # batches folder.
New-Item -Path ".\static\css", ".\static\images\icons", ".\static\images\upload", ".\static\js" -ItemType "directory" > $null # static folder.
New-Item -Path ".\templates\extends" -ItemType "directory" > $null # templates folder.
New-Item -Path ".\update\log", ".\update\test" -ItemType "directory" > $null # update folder.
New-Item -Path ".\utils\helper", ".\utils\settings" -ItemType "directory" > $null # utils folder.
#endregion
#region [2] 장고서버 베이스 쉘 스크립트들을 생성합니다.
Write-Host [2] 장고서버 베이스 쉘 스크립트들을 생성합니다.
$join_ps1={
[string] $project_name="장고프로젝트"
Write-Host Project Information.
Write-Host --------------------------------------------
Write-Host 프로젝트 참가 인원 : 0
Write-Host 프로젝트 기한 일자 : 0 to YYYY/MM/DD
Write-Host 프로젝트 이름 : $project_name
Write-Host 장고사용 버전 : None
Write-Host 프로젝트 데이터 베이스 : None 
Write-Host --------------------------------------------
Write-Host 장고 서버를 실행합니다.
cd..
cd..
python manage.py runserver
}
$run_ps1={
Write-Host 가상머신을 실행합니다.
pipenv shell
}
$out_ps1={
Write-Host 가상머신을 종료합니다.
exit
}
New-Item -Path ".\batches\django_bat\join.ps1" -ItemType "file" -Value $join_ps1.ToString() > $null
New-Item -Path ".\batches\django_bat\run.ps1" -ItemType "file" -Value $run_ps1.ToString() > $null
New-Item -Path ".\batches\django_bat\out.ps1" -ItemType "file" -Value $out_ps1.ToString() > $null
#endregion
#region [3] 깃-허브 베이스 쉘 스크립트들을 생성합니다.
Write-Host [3] 깃-허브 베이스 쉘 스크립트들을 생성합니다.

$pull_ps1={
[string] $current_location_name = Split-Path -Path (Get-Location) -Leaf
git branch -a
cd ..
cd ..
Write-Host - - - Start pull.ps1 terminal - - -
# [1] initialize to this folder.
Write-Host [1] 초기화.
git init
#[2] Enumerate All project Branches.
Write-Host [2] 모든 브랜치들을 나열합니다.
git branch -a
#[3] Remote to Project.
Write-Host [3] 깃-허브 프로젝트를 로컬로 리모트 합니다.
git remote add origin https://github.com/github01main/$current_location_name.git
#[4] Enter the pulling branch name.
Write-Host [4] pull할 branch의 이름을 입력해주세요.
$pull_branch_name = Read-Host "Enter pull branch name :"
git pull origin $pull_branch_name
#[5] All Resources Pulled on Local Storage.
Write-Host [5] 모든 resorce들이 local상에 pull 되었습니다.
Write-Host - - - Ended Pull.ps1 terminal - - -
}

$push_ps1={
[string] $current_location_name = Split-Path -Path (Get-Location) -Leaf
git branch -a
cd ..
cd ..
Write-Host - - - Start push.ps1 terminal - - -
#[1] Initialize to this folder.
Write-Host [1] 초기화.
git init
#[2] Add contents all.
Write-Host [2] 프로젝트 폴더내의 모든 파일을 추가합니다.
git add .
#[3] Remote project to PC.
Write-Host [3] 프로젝트 리모트.
git remote add origin https://github.com/github01main/$current_location_name.git
#[4] Commit Contents Input Area.
Write-Host [4] 커밋 내용을 입력하시오.
$commit_Contents = Read-Host "Enter what you want to commit :"
#[5] Sending Commit Contents Information.
Write-Host [5] 커밋 합니다.
git commit -m $commit_Contents
#[6] push Contents to branch Input Area.
Write-Host [6] Push할 브랜치를 입력하주십시오.
$branch_location = Read-Host "Enter the pushing branch name :"
#[7] Commit Content push Area.
Write-Host [7] 해당 브랜치에 Push합니다.
git push -u origin $branch_location
#[8] push completed message,
Write-Host $branch_location 공간에 리소스들을 Push 하였습니다. 
Write-Host - - - Ended push.ps1 terminal - - -
}

New-Item -Path ".\batches\git_bat\pull.ps1" -ItemType "file" -Value $pull_ps1.ToString() > $null
New-Item -Path ".\batches\git_bat\push.ps1" -ItemType "file" -Value $push_ps1.ToString() > $null
#endregion
#region [4] 장고 및 깃 접근 쉘 스크립트들을 생성합니다.
Write-Host [4] 장고 및 깃 접근 쉘 스크립트들을 생성합니다.
$access_django_dir_ps1={
# 장고 배치 폴더에 접속합니다..
Write-Host [1] 장고 쉘 폴더에 접속하였습니다.
cd .\batches\django_bat
}
$access_git_dir_ps1={
# 깃 쉘 폴더에 접속합니다..
Write-Host [2] 깃 쉘 폴더에 접속하였습니다.
cd .\batches\git_bat
}
New-Item -Path ".\access_django_dir.ps1" -ItemType "file" -Value $access_django_dir_ps1.ToString() > $null
New-Item -Path ".\access_git_dir.ps1" -ItemType "file" -Value $access_git_dir_ps1.ToString() > $null
#endregion
#region [5] 프로젝트 폴더 내에 패키지들을 Requirements.txt에 담아 생성합니다.
Write-Host [5] 프로젝트 폴더 내에 패키지들을 Requirements.txt에 담아 생성합니다.

cd .\utils\settings
pip freeze > requirements.txt
cd..
cd..

#endregion
#region [6] .gitinore 파일을 생성합니다.
Write-Host [6] .gitinore 파일을 생성합니다.
$gitignore={
# 특정 제외.
*.ps1
*.sh
*.txt
*.lock

# 제외 폴더.
migrations/
__pycache__/
venv/

# 제외 파일.
### macOS ###
.DS_Store
.AppleDouble
.LSOverride

### Windows ###
# [Dd]esktop.ini

# Windows Installer files
*.cab
*.msi
*.msix
*.msm
*.msp

# Windows shortcuts
*.lnk
}
New-Item -Path ".\.gitignore" -ItemType "file" -Value $gitignore.ToString() > $null
#endregion
#region [7] README.md 파일을 생성합니다.
Write-Host [7] README.md 파일을 생성합니다.

$README_md={
# # your django project title name.

# This is your description of your django project .. this is your demo web site link: [your official website](https://google.com)

# ## Features

# * Preconfigured setup for CI, coverage, and analysis services
# * `pyproject.toml` for managing dependencies and package metadata
# * `Makefile` for automating common [development tasks](https://github.com/jacebrowning/template-python/blob/main/%7B%7Bcookiecutter.project_name%7D%7D/CONTRIBUTING.md):
#     - Installing dependencies with `poetry`
#     - Automatic formatting with `isort` and `black`
#     - Static analysis with `pylint`
#     - Type checking with `mypy`
#     - Docstring styling with `pydocstyle`
#     - Running tests with `pytest`
#     - Building documentation with `mkdocs`
#     - Publishing to PyPI using `poetry`
# * Tooling to launch an IPython session with automatic reloading enabled

# If you are instead looking for a [Python application](https://caremad.io/posts/2013/07/setup-vs-requirement/) template, check out one of the sibling projects:

# * [jacebrowning/template-django](https://github.com/jacebrowning/template-django)
# * [jacebrowning/template-flask](https://github.com/jacebrowning/template-flask)

# ## Examples

# Here are a few sample projects based on this template:

# * [jacebrowning/minilog](https://github.com/jacebrowning/minilog)
# * [theovoss/Chess](https://github.com/theovoss/Chess)
# * [sprout42/StarStruct](https://github.com/sprout42/StarStruct)
# * [MichiganLabs/flask-gcm](https://github.com/MichiganLabs/flask-gcm)
# * [flask-restful/flask-restful](https://github.com/flask-restful/flask-restful)

# ## Usage

# Install `cookiecutter` and generate a project:

# ```python
# pip install cookiecutter
# cookiecutter gh:jacebrowning/template-python -f
# ```

# Cookiecutter will ask you for some basic info (your name, project name, python package name, etc.) and generate a base Python project for you.
# Once created, run the code formatter to updates files based on your chosen names:

# ```python
# $ cd <github_repo>
# $ make format
# ```

# Finally, commit all files generated by this template.

# ## Updates

# Run the update tool, which is generated inside each project:

# ```python
# $ bin/update
# ```
}
New-Item -Path ".\README.md" -ItemType "file" -Value $README_md.ToString() > $null
#endregion
#region [8] LICENSE 파일을 생성합니다.
Write-Host [8] LICENSE 파일을 생성합니다.
$license={
# MIT License

# Copyright (c) 2022 shiwookcho

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
}
New-Item -Path ".\LICENSE" -ItemType "file" -Value $license.ToString() > $null
#endregion
#region [9] 장고 프로젝트를 생성합니다.
Write-Host [9] 장고 프로젝트를 생성합니다.
django-admin startproject config .
#endregion
#region [10] 장고 프로젝트 앱 생성기를 생성합니다.
Write-Host [10] 장고 프로젝트 앱 생성기를 생성합니다.
$app_generator=@'
Write-Host [1] 새로운 장고 $new_app 생성을 시작합니다.
$new_app = Read-Host "생성할 앱의 이름을 입력해주세요: "

Write-Host [2] 장고 $new_app 생성합니다..
django-admin startapp $new_app

Write-Host [3] 장고 $new_app urls를 생성합니다..

$domain_name = $new_app -replace [regex]::escape("_"),""
$domain_name_1 = 'home'
$domain_name_2 = 'room'
$domain_name_3 = 'third_page'

$app_urls=@"
from django.urls import path
from . import views

urlpatterns = [
    # 1st Url Domain pattern.
    path('', views.$domain_name_1, name='$domain_name_1'),
    # 2nd Url Domain pattern..
    path('second/', views.$domain_name_2, name='$domain_name_2'),
    # 3rd Url Domain.
    path('third/', views.$domain_name_3, name='$domain_name_3'),
]
"@

New-Item -Path ".\$new_app\urls.py" -ItemType "file" -Value $app_urls.ToString() > $null

Write-Host [4] 장고 $new_app views.py를 재설정 합니다..
$app_file_view_py = ".\$new_app\views.py"

$app_content = Get-Content -Path $app_file_view_py

$app_insert_content =@"
from django.shortcuts import render

rooms = [
    {'id':1, 'name':'Lets learn python!'},
    {'id':2, 'name':'Design with me'},
    {'id':3, 'name':'Fronted developers'},
]
    # 1st Url Domain.
def home(request):
    return render(request, 'home.html', {'rooms': rooms})
    # 2nd Url Domain.
def room(request):
    return render(request, 'room.html')
    # 3rd Url Domain.
def kimchi_third_page(request):
    return render(request, 'third_page.html')
"@

$app_content = $app_insert_content
$app_content | Set-Content -Path $app_file_view_py
# $app_content -replace"[?]",""  | Set-Content -Path $app_file_view_py # replacing.

Write-Host [5] 장고 config에 $new_app 을 추가합니다..
$file = ".\config\settings.py"

$content = Get-Content -Path $file

# 생성될 settings 내에 INSTALLED_APPS 이름 내용을 재정의.
$new_app_config_name = $new_app -replace [regex]::escape("_"),""
$new_app_config_name = $new_app_config_name.substring(0,1).toupper()+$new_app_config_name.substring(1).tolower()
$Installed_apps_name = $new_app +'.apps.' + $new_app_config_name + 'Config'

$insert_content = "    `n    '$Installed_apps_name',"
$content[39] += $insert_content

$content | Set-Content -Path $file

Write-Host [6] 새로운 장고 $new_app 생성이 완료되었습니다.

# 장고 Urls.py 패턴 추가본..
$urls_file = ".\config\urls.py"

$urls_content = Get-Content -Path $urls_file

$insert_content = "    `n    path('',  include('$new_app.urls')),"
$urls_content[19] += $insert_content

$urls_content | Set-Content -Path $urls_file
'@
New-Item -Path ".\awesome-app-creator.ps1" -ItemType "file" -Value $app_generator.ToString() > $null
#endregion
#region [11] html css js templates sources generator.
Write-Host [11] 장고 프로젝트 템플릿 소스들을 생성합니다.
# base javascript를 생성하기 위한 템플릿.
$main_js=@'
'@

# base css를 생성하기 위한 템플릿.
$main_css =@'
*{
    margin: 0;
    padding: 0;
    border: 0;
 }
'@

# base html을 생성하기 위한 템플릿.
$main_html =@'
{% load static %}
<!DOCTYPE html>
<html lang="en">
<head>

<!--#region  meta section -->   

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    {% comment %} main.html에 설정된 script 변수값들을 하위 js 와 css에 적용시킨다. {% endcomment %}
    {% block extrahead %}
    {% comment %} 
    Merlin Bot Favicon 48x48 ico extention.
    {% endcomment %}
    <link rel="shortcut icon" type="image/x-icon" href="{% static 'images/icons/48x48_web_server_logo.ico' %}">
    <link rel="stylesheet" type="text/css" href="{% static 'css/main.css' %}">
    {% endblock %}

    <title>Discord merlin-Bot</title>

<!--#endregion -->

</head>

    <body>
        <!--#region  body section -->

        {% comment %} adding navigation bar. {% endcomment %}
        {% include 'nav.html' %}
        {% block content %}
        {% endblock %}

        <!--#endregion -->
    </body>

</html>
'@
# nav html을 생성하기 위한 템플릿.
$nav_html=@'
{% load static %}
<a href="/">
    <img class="merlin_logo" src="{% static 'images/Upload/512x512_Blue&White.png' %}"alt="Hellow my friend !">
</a>
<hr>
'@
# document html을 생성하기 위한 템플릿.
$home_html=@'
{% extends 'main.html' %} {% comment %} [0] main.html에 확장. {% endcomment %}
{% block content %}
<h1>Home templates</h1>

<div>
    <div>
        {% comment %} [1] views.py에서 할당된 array값들을 사용하도록 for으로 풀어준다. {% endcomment %}
        {% for document in documents %}
        <div>
            {% comment %} [2] urls pattern에 document name값을 읽어와서 적용한다. {% endcomment %}
            <h5>{{document.id}} -- <a href="{% url 'document' document.id %}">{{document.name}}</a></h5>
        </div>
        {% endfor %}
    </div>
</div>

{% endblock content %}
'@
$document_page=@'
{% extends 'main.html' %} {% comment %} main.html에 확장. {% endcomment %}
{% block content %}
{% comment %} 함수에서 요청받은 document의 이름값을 부여한다. {% endcomment %}
<h1>{{document.name}}</h1>
{% endblock content %}
'@
$contact_html=@'
{% extends 'main.html' %} {% comment %} main.html에 확장. {% endcomment %}
{% block content %}
<h1>Home templates</h1>
<div>
    <div>
        {% for room in rooms %}
        <div>
            <h5>{{room.id}} -- {{room.name}}</h5>
        </div>
        {% endfor %}
    </div>
</div>
{% endblock content %}
'@
# js, css html 파일들을 생성한다.
New-Item -Path ".\static\js\main.js" -ItemType "file" -Value $main_js.ToString() > $null
New-Item -Path ".\static\css\main.css" -ItemType "file" -Value $main_css.ToString() > $null
New-Item -Path ".\templates\main.html" -ItemType "file" -Value $main_html.ToString() > $null
New-Item -Path ".\templates\nav.html" -ItemType "file" -Value $nav_html.ToString() > $null
New-Item -Path ".\templates\extends\home.html" -ItemType "file" -Value $home_html.ToString() > $null
New-Item -Path ".\templates\extends\document_page.html" -ItemType "file" -Value $document_page.ToString() > $null
New-Item -Path ".\templates\extends\contact.html" -ItemType "file" -Value $contact_html.ToString() > $null
#endregion
#region [12] setting up os, templates, static for django project.
Write-Host [12] 장고 프로젝트 초기 셋팅을 설정합니다.
$file = ".\config\settings.py"

$content = Get-Content -Path $file

$insert_content = "`import os.path`r"
$content[13] += $insert_content

$insert_content = "        'DIRS': [BASE_DIR / 'templates'],"
$content[56] = $insert_content

$insert_content = "STATICFILES_DIRS = [os.path.join(BASE_DIR, 'static')]`r"
$content[118] += $insert_content

$content | Set-Content -Path $file
}
#endregion
New-Item -Path ".\awesome-project-creator.ps1" -ItemType "file" -Value $generator.ToString() > $null
#endregion
#region [13] pipenv shell start and procceed project creator.
pipenv shell
.\awesome-project-creator.ps1 /Quick
#endregion
Write-Host [14] bundle pack 첫번째 bundle-pack-scoop-installer 를 생성합니다.

$scoop_installer=@'
Write-Host [1] Scoop을 설치하기 위해 powershell script사용을 허가 합니다.

Set-ExecutionPolicy RemoteSigned -scope CurrentUser

Write-Host [2] Scoop을 설치 합니다.

iwr -useb get.scoop.sh | iex

Write-Host [3] 허브를 설치 합니다.
# https://github.com/github/hub#installation 허브 인스톨러 가이드 페이지 입니다.

scoop install hub
'@

New-Item -Path ".\bundle-pack-scoop-installer.ps1" -ItemType "file" -Value $scoop_installer.ToString() > $null

Write-Host [15] bundle pack 두번째 bundle-pack-ssh-key-generator 를 생성합니다.

$ssh_key_gen=@'

$static_git_email = Read-Host "깃-허브 이메일을 입력해주세요 "

ssh-keygen -t rsa -b 4096 -C $static_git_email

Write-Host [1] 깃 허브 암호화 파일을 생성합니다. 아래 첫번쨰 로케이션을 주석부분을 터미널에 붙여넣어주세요.
# 1) your location .\settings\id_rsa
# 2) your password
# 3) check password

Write-Host [2] 생성된 공개키를 https://github.com/settings/keys 에 입력해주세요.

cat ~/.ssh/id_rsa.pub

Write-Host [3] 생성된 공개키를 https://github.com/settings/keys 에 입력해주세요.
#ssh -T git@github.com
'@

New-Item -Path ".\bundle-pack-ssh-key-generator.ps1" -ItemType "file" -Value $ssh_key_gen.ToString() > $null

Write-Host [16] bundle pack 세번째 bundle-pack-git-setup 를 생성합니다.

$git_setup=@'
git init

git config --unset user.name
git config --unset user.email

git config --unset --global user.name
git config --unset --global user.email

# Write-Host [1] 깃 이메일을 설정합니다.
$static_git_email = Read-Host "변경하고자 하는 깃-허브 이메일을 입력해주세요 "
git config --global user.email $static_git_email
git config user.email

Write-Host [2] 깃 유저 이름을 설정합니다.
$split_name = $static_git_email -split '@';
git config --global user.name $split_name
git config user.name

Write-Host [3] Git 출력되는 명령어의 색깔 Auto로 설정합니다.
git config --global color.ui auto
'@

New-Item -Path ".\bundle-pack-git-setup.ps1" -ItemType "file" -Value $git_setup.ToString() > $null

Write-Host [17] bundle pack 네번째 Goodbye 클리너를 생성합니다
$repo_cleaner=@'
[string] $current_location_name = Split-Path -Path (Get-Location) -Leaf
hub delete github01@main/$current_location_name
'@
New-Item -Path ".\bundle-pack-goodbye_cleaner.ps1" -ItemType "file" -Value $repo_cleaner.ToString() > $null

# 장고 Urls 패턴 추가본..
$urls_file = ".\config\urls.py"

$urls_content = Get-Content -Path $urls_file

$insert_content = "from django.urls import path, include"
$urls_content[16] = $insert_content

$urls_content | Set-Content -Path $urls_file

Write-Host [18] 원격에 repogitory를 생성합니다.

hub create

git init
git rm -r --cached .
git add -A
git commit -m "your new repogitory is maded ! :) have a nice day."
[string] $git_hub_name = Split-Path -Path (Get-Location) -Leaf
git remote add origin git@github.com:github01main/$git_hub_name.git
git branch -M main
git push -u origin main

Write-Host [19] 생성된 원격 리포지토리를 browser로 엽니다.
hub browse
hub browse -- issues