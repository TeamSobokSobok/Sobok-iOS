# 소복소복<img src="./Asset/sobok-logo.png" align=left width=100>

> 소중한 사람과 함께하는 복약 체크 서비스 💊

<br />

# 💭 About

> 여러분은 소중한 사람의 건강을 지키기 위해 어떤 노력을 하고 계신가요?  
> 
> 걱정되는 마음은 있지만, 막상 내가 매일 무언가 행동하는 건 쉽지 않죠.  
> 일상이 바쁜 당신을 위해서 소복소복이 여러분의 일을 줄여드려요.  
> 소복소복에서는 소중한 사람이 약을 제 때 먹었는지 직접 물어보지 않고도 체크할 수 있거든요.  
> 
> **나의 복약 체크는 물론, 소중한 사람의 복약까지 확인할 수 있는 ‘소복소복’**
> **우리의 건강을 챙기는 매일의 실천입니다** 🙂

<br />

# ✨ Main Feat

- **`홈`** 
나의 복약을 체크하고, 상대방이 보내준 응원스티커를 확인할 수 있습니다.

- **`공유`** 
소중한 사람의 복약 캘린더를 확인하고, 응원을 보낼 수 있습니다.

- **`알림`**
캘린더 공유 요청과 전송받은 복약 정보를 확인할 수 있습니다.

- **`추가`** 
내 복약 정보를 추가하고, 소중한 사람에게 복약 일정을 전송할 수 있습니다.

![This is the last](https://user-images.githubusercontent.com/75469131/150535885-e6c38a60-19b0-4957-8919-2c78074cdb50.png)

<br />

# 🍎 Team Member - `iOS`

|<img src="./Asset/태현.png" width=200>|<img src="./Asset/승찬.png" width=200>|<img src="./Asset/은희.png" width=200>|<img src="./Asset/선영.png" width=200>|
|:--:|:--:|:--:|:--:|
|**태현**|**승찬**|**은희**|**선영**|
|[@Taehyeon-Kim](https://github.com/Taehyeon-Kim)|[@seungchan2](https://github.com/seungchan2)|[@EunHee-Jeong](https://github.com/EunHee-Jeong)|[@seondal](https://github.com/seondal)|

<br />

#### 태현
`메인 뷰` `스티커 확인` `수정하기` `내 약 상세 (중복)` `공유 캘린더(중복)` `공유 스티커 확인` `공유 스티커 보내기` `공유 보낸 스티커 수정`

#### 승찬
`내 약 추가 액션시트` `약 추가` `복용 기간 선택` `복용 기간 캘린더` `알림 시간 설정` `추가 목록`

#### 은희
`알림 목록` `약 전송 요청` `약 매일 수정` `공유 스티커 보내기 팝업` `상단바`

#### 선영
`로그인` `회원가입` `친구 이름 수정` `캘린더 공유 닉네임 조회` `캘린더 공유 요청`

---

[어려웠던 부분과 극복 과정 보러가기](https://baejiann120.notion.site/Overcome-5e7c95d4783e468fa848b5e26b1473d7)

<br />

# 📚 Library

| Name | Tag |
| --- | --- |
| Moya | Network |
| SnapKit | Layout |
| Then | Layout, Sugar API     |
| IQKeyboardManager | Layout, Keyboard |
| Kingfisher | Image Caching | 

<br />

# 🕹 Convention

`Coding Convention` · `Commit Convention`

<details markdown="1">
<summary>[Coding Convention]</summary>

### 📍 MARK 주석

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
---

### 📍 함수 네이밍

**`서버통신`**

서비스함수명 + WithAPI

**`IBAction`**

동사원형 + 목적어
ex) touchBackButton

**`뷰 전환`**

pop, push, present, dismiss
동사 + To + 목적지 뷰 (다음에 보일 뷰)
( dismiss는 dismiss + 현재 뷰 )

**`데이터 다루기`**
- 데이터 파싱 - parse + 모델 + 결과물   
    parseDiaryUserID    
    sort소확행
    
**`초기세팅`**
- init + 목적어
ex) initPickerView

**`hidden unhidden`**
- show + 목적어
- hide + 목적어

**`뷰 UI 관련`**
- 동사원형 + 목적어

**`애니메이션`**
- 동사원형 + 목적어 + WithAnimation
- showButtonsWithAnimation

**`register`**
- register + 목적어
- registerXib

**`권한 위임`**
- setDelegation()
- assignDelegation()

**`subview로 붙이기`**
- attatch

**`프로토콜`**
- 뷰 이름 + View + Protocol

---

### 📍 파일명 네이밍

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
💊 [소복소복 Commit Message Template]
✅ [커밋 타입] 내용 (#이슈번호) 형식으로 작성
✅ ex. [Feat] 로그인 뷰 구현 (#1)
✅ 제목(title)을 아랫줄에 작성
✅ 최대 50글자, 제목 끝에 마침표 금지, 무엇을 했는지 명확하게 작성

########################
# ✅ 본문(body)을 아랫줄에 작성

########################
# ✅ 꼬릿말(footer)을 아랫줄에 작성

########################
```
</details>
 
<details markdown="3">
<summary>[Commit Type]</summary>

  > 🚨 총 9개의 커밋 타입으로 구분한다.
  
```  
[Docs]   문서 작성 및 수정 작업(README 등)
[Add]    기능이 아닌 것 생성 및 추가 작업(파일·익스텐션·프로토콜 등)
[Feat]   새로운 기능 추가 작업
[Style]  UI 관련 작업(UI 컴포넌트, Xib 파일, 컬러·폰트 작업 등)
[Fix]    에러 및 버그 수정, 기능에 대한 수정 작업
[Edit]   Fix가 아닌 모든 수정 작업(주석, 파일 및 폴더 위치, 코드 스타일 등)
[Del]    파일, 에셋 등 삭제 작업
[Set]    세팅 관련 작업
[Test]   테스트 관련 작업
```  
</details>

[자세히 보기](https://baejiann120.notion.site/Convention-334f61e9e0a94f02abf4b4ebc979bbf3)
 

<br />

# 🐾 Branch Strategy

`Git Flow` · `GitHub Flow`

<details markdown="1">
<summary>브랜치 종류 소개</summary>

`develop` - default 
- protected → 승인 받아야만 merge 가능

`feature`
- feature/#이슈번호
- feature/#1

</details>

<details markdown="1">
<summary>시나리오</summary>

> 1️⃣ **Issue**
> 1. 이슈생성

> 2️⃣ **Branch**
> - ex. feature/#16

> 3️⃣ **Pull request**
> 1. reviewer → 4명
> 2. 4명 중 2명이 승인(approve)을 해야 merge 가능

> 4️⃣ **Code Review**
> 1. 수정 요청
> 2. 대상자(작업자)가 수정을 하고 다시 커밋을 날림
> 3. 수정 반영하고 답글로 커밋로그 남기기
>    - 수정사항은 커밋번호로 남기기

> 5️⃣ **merge**
> 1. 팀원 호출
> 2. 간단한 리뷰, 피드백, 회의 마친 후
> 3. 다 같이 보는 자리에서 합칠 수 있도록 하기

</details>

<br />

# 🗂 Folder Architecture

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
