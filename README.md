# 소복소복<img src="./Asset/sobok-logo.png" align=left width=100>

> 소중한 사람과 함께하는 복약 체크 서비스 💊

<br />

## 💭 프로젝트 설명

> 여러분은 소중한 사람의 건강을 지키기 위해 어떤 노력을 하고 계신가요?  
> 
> 걱정되는 마음은 있지만, 막상 내가 매일 무언가 행동하는 건 쉽지 않죠.  
> 일상이 바쁜 당신을 위해서 소복소복이 여러분의 일을 줄여드려요.  
> 소복소복에서는 소중한 사람이 약을 제 때 먹었는지 직접 물어보지 않고도 체크할 수 있거든요.  
> 
> **나의 복약 체크는 물론, 소중한 사람의 복약까지 확인할 수 있는 ‘소복소복’**
> **우리의 건강을 챙기는 매일의 실천입니다** 🙂

<br />

## 🙋🏻‍♂️ Team Member 사복이들

|<img src="./Asset/태현.png" width=200>|<img src="./Asset/승찬.png" width=200>|<img src="./Asset/은희.png" width=200>|<img src="./Asset/선영.png" width=200>|
|:--:|:--:|:--:|:--:|
|**태현**|**승찬**|**은희**|**선영**|
|[@Taehyeon-Kim](https://github.com/Taehyeon-Kim)|[@seungchan2](https://github.com/seungchan2)|[@EunHee-Jeong](https://github.com/EunHee-Jeong)|[@seondal](https://github.com/seondal)|

<br />

## 🕹 Convention

`Coding Convention` · `Commit Convention`

<details markdown="1">
<summary>[Coding Convention]</summary>

#### 📍 MARK 주석

```
// MARK: - Properties

// MARK: - @IBOutlet Properties

// MARK: - @IBAction Properties

// MARK: - View Life Cycle viewDidLoad(), viewWillAppear(_:) …

// MARK: - Functions

// MARK: - Extensions

// MARK: - UITableViewDataSource

// MARK: - UITableViewDelegate 프로토콜들 Extension 으로 빼기
```
<br />

#### 📍 함수 네이밍

##### **`서버통신`**

서비스함수명 + WithAPI

##### **`IBAction`**

동사원형 + 목적어
ex) touchBackButton

##### **`뷰 전환`**

pop, push, present, dismiss

동사 + To + 목적지 뷰 (다음에 보일 뷰)

( dismiss는 dismiss + 현재 뷰 )

##### **`데이터 다루기`**

- 데이터 파싱 - parse + 모델 + 결과물
    
    parseDiaryUserID
    
    sort소확행
    

##### **`초기세팅`**

- init + 목적어

ex) initPickerView

##### **`hidden unhidden`**

- show + 목적어
- hide + 목적어

##### **`뷰 UI 관련`**

- 동사원형 + 목적어

##### **`애니메이션`**

- 동사원형 + 목적어 + WithAnimation
- showButtonsWithAnimation

##### **`register`**

- register + 목적어
- registerXib

##### **`권한 위임`**

- setDelegation()
- assignDelegation()

##### **`subview로 붙이기`**

- attatch

##### **`프로토콜`**

- 뷰 이름 + View + Protocol

<br />

#### 📍 파일명 네이밍

**@IBOutlet Properties - 프로퍼티 종류 뒤에 다 쓰기 (줄임말 X)**

ex) emailTextField(O) emailTF(X)  
      loginButton(O)

**뷰 컨트롤러 파일 만들 때 뒤에 ViewController 다 쓰기 (VC (X))**

파일명 첫 글자는 대문자  
Enum 등은 첫 글자 대문자  
변수 첫 글자는 소문자
</details>


<details markdown="2">
<summary>[Swift Lint]</summary>

```
disabled_rules:
- line_length
- trailing_whitespace
- orphaned_doc_comment
- nesting
- function_body_length

opt_in_rules:
- anyobject_protocol
- let_var_whitespace

included:

excluded:
- SobokSobok/Application # AppDelegate, SceneDelegate 파일 무시
- SobokSobok/Common/NameSpace

identifier_name:
  excluded:
    - id

force_cast:
    warning              # 강제 캐스팅은 error에서 warning으로 변경

```
</details>

<details markdown="3">
<summary>[Commit Convention]</summary>

```
# 💊 [소복소복 Commit Message Template]
# ✅ [커밋 타입] 내용 (#이슈번호) 형식으로 작성
# ✅ ex. [Feat] 로그인 뷰 구현 (#1)
# ✅ 제목(title)을 아랫줄에 작성
# ✅ 최대 50글자, 제목 끝에 마침표 금지, 무엇을 했는지 명확하게 작성

########################
# ✅ 본문(body)을 아랫줄에 작성

########################
# ✅ 꼬릿말(footer)을 아랫줄에 작성

# --- COMMIT END ---
########################
# --- Commit Type ---
# 🚨 총 9개의 커밋 타입으로 구분한다.
# [Docs]   문서 작성 및 수정 작업(README 등)
# [Add]    기능이 아닌 것 생성 및 추가 작업(파일·익스텐션·프로토콜 등)
# [Feat]   새로운 기능 추가 작업
# [Style]  UI 관련 작업(UI 컴포넌트, Xib 파일, 컬러·폰트 작업 등)
# [Fix]    에러 및 버그 수정, 기능에 대한 수정 작업
# [Edit]   Fix가 아닌 모든 수정 작업(주석, 파일 및 폴더 위치, 코드 스타일 등)
# [Del]    파일, 에셋 등 삭제 작업
# [Set]    세팅 관련 작업
# [Test]   테스트 관련 작업
########################
```
</details>

<br />

## 🐾 Branch Strategy

`Git Flow` · `GitHub Flow`

<br />

`develop` - default / protected → 승인 받아야만 merge 가능

`feature`

- feature/#이슈번호
- feature/#1

<br />

`시나리오`

- 이슈 생성
- 이슈에 대한 브랜치를 생성
    - ex. feature/#16
- Pull request 생성
    - reviewer → 4명
    - 4명 중 2명이 승인(approve)을 해야 함
    - merge 가능
- 리뷰 남기면서 이거 수정해달라고 요청
    - 대상자(작업자)가 수정을 하고 다시 커밋을 날림
    - 수정사항은 커밋번호로 남기기
- merge가 필요할 때, 팀원 호출
    - 간단한 리뷰, 피드백, 회의 마친 후
    - 다 같이 보는 자리에서 합칠 수 있도록 하기

<br />

## 🗂 Folder Architecture

<details markdown="1">
<summary>폴더링을 소개합니다✨</summary>

- 🗂 Application (Application Layer에 해당하는 그룹)

    - AppDelegate.swift
    - SceneDelegate.swift
- 🗂 Common
    - 🗂 DesignSystem (ex. `Component`, `FontConverter`, `etc.`)
    - 🗂 NameSpace (ex. `Font`, `Color`, `Image`, `Xib`, `Text`, `etc.`)
    - 🗂 Extension (EasyKit에 없고 프로젝트 내에서 필요한 Extension)
    - 🗂 Protocol
- 🗂 Data
    - 🗂 Mock (Mock, Stub용으로 사용할 json 파일)
    - 🗂 Model (일반 Model)
    - 🗂 DTO (네트워크 통신용 Model)
- 🗂 Presentation
    - 🗂 Common (공통 VC)
    
        - BaseViewController
        - Navigation
        - TabBarController
    - 🗂 Splash (뷰)
    
        - SplashViewController.xib
        - SplashViewController.swift
        - 🗂 ViewModel
        - 🗂 Cell
        - 🗂 View
    - SignIn
    - SignUp
    - ...
- 🗂 Resource
    - Launch.storyboard
    - 🗂 Gif (Lottie용이 있다면 gif 파일 그룹)
    - 🗂 Font (font 파일 그룹)
    - 🗂 Assets.xcassets (`AppIcon`)
    
        - AppIcon
    - 🗂 Color.xcassets (`컬러값`)
    - 🗂 Image.xcassets (`이미지`, `아이콘`)
    
        - 에셋 추가
- 🗂 Service
    - 🗂 Network (`json 폼 회의`)
    
        - BaseRequest
        - BaseResponse
    - 🗂 Parser (Converter)
    
        - MockParser.swift
    - 🗂 Result (네트워크 통신 결과)
    
        - NetworkResult
- 🗂 Support(s)
    - 🗂 Script (스크립트 )
    - Info.plist

</details>
