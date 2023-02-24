# READDME
# 📒 프로젝트 이름

### 프로젝트 기간
<2023-02-06 ~ >

## 📖 목차
- [소개](#-소개)
- [실행 화면](#-실행-화면)
- [키워드](#키워드)
- [고민한 점](#-고민한-점)
- [트러블 슈팅](#-트러블-슈팅)
- [참고 링크](#-참고-링크)

## 소개
### 개발환경 및 라이브러리
[![swift](https://img.shields.io/badge/swift-5.0-orange)]()
[![xcode](https://img.shields.io/badge/Xcode-14.2-blue)]()
[![iOS](https://img.shields.io/badge/iOS-16.0-green)]()
<img src="https://img.shields.io/badge/SPM-orange?style=flat&logo=Swift&logoColor=ffffff"/>
<img src="https://img.shields.io/badge/RxSwift-red?style=flat"/>
<img src="https://img.shields.io/badge/SnapKit-blue?style=flat"/>
<img src="https://img.shields.io/badge/Alamofire-gray?style=flat"/>
### 팀원
|<img src = "https://i.imgur.com/0YI1hEB.jpg" width="200" height="200">|
|:--:|
|[그루트](https://github.com/Groot-94)|

## 실행 화면
||||
|:--:|:--:|:--:|
|일별, 주간, 주말 박스오피스 전환|영화 상세 화면|날짜 선택 화면|
|<img src = "https://i.imgur.com/W8CqXlr.gif" width="250" height="400">|<img src = "https://i.imgur.com/IrOWj7o.gif" width="250" height="400">|<img src = "https://i.imgur.com/MfvKuGd.gif" width="250" height="400">|
|영화 검색 화면|영화 검색 시 영화 상세 화면|
|<img src = "https://i.imgur.com/7iF6hrG.gif" width="250" height="400">|<img src = "https://i.imgur.com/tsx3kNJ.gif" width="250" height="400">|

## 키워드
<details>
    
**<summary>내용 보기**
    
</summary>
    
- MVVM
- RxSwift를 이용한 ViewModel과 View의 바인딩
- Alamofire Mocking Test
- Testable ViewModel
- ImageCaching with Concurrency
- Custom TabBar
- Coodinator Pattern
    
</details> 

## 고민한 점
<details>
    
**<summary>Alamofire의 MockSession을 어떻게 주입해야 할 지**
    
</summary>
    
- 관련 포스트로 대체 -> [Alamofire의 Mock Test해보기](https://velog.io/@iamgroot1231/Alamofire%EC%9D%98-Mock-Test%ED%95%B4%EB%B3%B4%EA%B8%B0)
    
</details> 

<details>
    
**<summary>Coodinator 패턴의 설계방식**
    
</summary>
    
- Coodinator 패턴을 사용 시 반복되는 화면이나 여러가지 세부적인 내용에 대한 화면이동이 유연하다는 점을 학습했고, 적용해보기 위해 사용했습니다. [the-coordinator](https://khanlou.com/2015/01/the-coordinator/)
- 뷰의 흐름을 구현하면서 어떤 Coodinator가 어떤 Parent와 Child를 가져야 할 지에 대한 고민을 들었습니다. 
    
    1. List Coodinator를 중심으로 화면이동이 필요한 Info Coodinator, Calender Coodinator, Search Coodinator를 Child로 구현했습니다.
    2. Search Coodinator도 영화의 정보를 보여줘야 하기 때문에 Info Coodinator를 Child로 구현했습니다.
    3. 구현한 Coodinator 패턴이 적절한지에 대한 의문이 생겼고, 어떤 부분에서 장점이 되는지 아직 잘 모르겠습니다.
    4. 구조
    <img src = "https://i.imgur.com/SkBLmP8.png" width="700" height="250">
    
</details> 

<details>

**<summary>actor를 사용해서 ImageCache 처리하는 방법**

</summary>
    
- 관련 포스트로 대체 -> [actor를 사용해서 ImageCaching 해보기](https://velog.io/@iamgroot1231/actor%EB%A5%BC-%EC%82%AC%EC%9A%A9%ED%95%B4%EC%84%9C-ImageCaching-%ED%95%B4%EB%B3%B4%EA%B8%B0)
    
</details>

<details>

**<summary>일별, 주간, 주말 박스오피스를 분리하기 위해 상단에 TabBar를 구현하는 방법**

</summary>
    
- UIKit에 존재하는 기본 TabBar는 하단에만 구현이 가능하지만, 당근마켓과 같은 앱에서 상단에 TabBar가 존재함을 보고 커스텀해서 만들어보고 싶었습니다.
  
    - [블로그](https://baked-corn.tistory.com/111)를 참고해서 컬렉션뷰 하단에 indicatorView를 구현해서 각각의 클릭 이벤트를 입력받을 시 indicatorView 위치를 적절하게 변경하는 방법으로 구현했습니다.
    - 위 블로그에선 컬렉션뷰 내부에 컬렉션 뷰를 넣는 부분이 있었는데 `일별, 주간, 주말을 각각의 셀로 나누는 방법이 아니라 하나의 뷰가 새로고침 되는 형태로 바꾸기 위한 방법을 고민`했습니다.
    - 셀 클릭 시 View의 Frame을 3분의 1로 나눈 부분으로 indicatorView를 옮겨주는 형태로 구현했습니다.
    ```swift
    extension BoxOfficeListViewController: CustomTapBarViewDelegate {
        func didTapCell(indexPath: IndexPath) {
            startLodingView(hideView: listView)

            if indexPath.row == 0 {
                viewModel.input.changeWeekGroup(standard: .daliy)
                tapBarView.indicatorViewLeadingConstraint.constant = 0
            } else if indexPath.row == 1 {
                viewModel.input.changeWeekGroup(standard: .week)
                tapBarView.indicatorViewLeadingConstraint.constant = tapBarView.frame.maxX * 1/3
            } else if indexPath.row == 2 {
                viewModel.input.changeWeekGroup(standard: .weekend)
                tapBarView.indicatorViewLeadingConstraint.constant = tapBarView.frame.maxX * 2/3
            }
        }
    }
    ```
    
</details>

## 트러블 슈팅
<details>

**<summary>검색화면에서 영화 셀 클릭 시 상세화면 전환이 중복호출 되는 문제**
    
</summary>
    
- 영화검색 화면에서 검색 한 영화의 셀을 여러번 클릭 시 상세화면으로 넘어가는 부분을 비동기 방식으로 설계했습니다.
- 동일한 셀을 여러번 클릭 시 뷰 이동 함수의 중복적인 호출로 인해 스택 형식으로 상세화면이 쌓이는 문제가 있었습니다.
   
    - 문제화면
    <img src = "https://i.imgur.com/CZX7TGs.gif" width="250" height="400">


- 해결을 위한 시도
    1. distinctUntilChanged() 메서드를 사용해서 중복을 제거하면 중복호출이 사라졌습니다. 하지만, 정상적으로 화면이동 후 다시 화면이동이 불가능 했습니다. 
    ```swift
    listView.rx.modelSelected(NaverMovieModel.self)
                .distinctUntilChanged()
                .subscribe(onNext: { [weak self] model in
                    self?.viewModel.input.didTapCell(model: model)
                })
                .disposed(by: disposeBag)
    ```
    
    2.  isSelectedCell 이라는 전역변수를 추가해서 확인하는 방법으로 해결했습니다. `이 부분은 추후에 조금 더 RxSwift를 활용한 방식으로 수정을 해보려고 합니다.`
    ```swift
    listView.rx.modelSelected(NaverMovieModel.self)
            .subscribe(onNext: { [weak self] model in
                guard let self = self,
                self.isSelectedCell == false else { return }
                
                self.viewModel.input.didTapCell(model: model)
                self.isSelectedCell = true
            }).disposed(by: disposeBag)
    ```
</details> 

## 참고
---

[🔝 맨 위로 이동하기](#-mongsil)
