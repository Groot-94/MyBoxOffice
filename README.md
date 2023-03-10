# ๐ MyBoxOffice

### ํ๋ก์ ํธ ๊ธฐ๊ฐ
<2023-02-06 ~ >

## ๐ ๋ชฉ์ฐจ
- [์๊ฐ](#-์๊ฐ)
- [์คํ ํ๋ฉด](#-์คํ-ํ๋ฉด)
- [ํค์๋](#ํค์๋)
- [๊ณ ๋ฏผํ ์ ](#-๊ณ ๋ฏผํ-์ )
- [ํธ๋ฌ๋ธ ์ํ](#-ํธ๋ฌ๋ธ-์ํ)
- [์ฐธ๊ณ  ๋งํฌ](#-์ฐธ๊ณ -๋งํฌ)

## ์๊ฐ
### ๊ฐ๋ฐํ๊ฒฝ ๋ฐ ๋ผ์ด๋ธ๋ฌ๋ฆฌ
[![swift](https://img.shields.io/badge/swift-5.0-orange)]()
[![xcode](https://img.shields.io/badge/Xcode-14.2-blue)]()
[![iOS](https://img.shields.io/badge/iOS-16.0-green)]()
<img src="https://img.shields.io/badge/SPM-orange?style=flat&logo=Swift&logoColor=ffffff"/>
<img src="https://img.shields.io/badge/RxSwift-red?style=flat"/>
<img src="https://img.shields.io/badge/SnapKit-blue?style=flat"/>
<img src="https://img.shields.io/badge/Alamofire-gray?style=flat"/>
### ํ์
|<img src = "https://i.imgur.com/0YI1hEB.jpg" width="200" height="200">|
|:--:|
|[๊ทธ๋ฃจํธ](https://github.com/Groot-94)|

## ์คํ ํ๋ฉด
||||
|:--:|:--:|:--:|
|์ผ๋ณ, ์ฃผ๊ฐ, ์ฃผ๋ง ๋ฐ์ค์คํผ์ค ์ ํ|์ํ ์์ธ ํ๋ฉด|๋ ์ง ์ ํ ํ๋ฉด|
|<img src = "https://i.imgur.com/W8CqXlr.gif" width="250" height="400">|<img src = "https://i.imgur.com/IrOWj7o.gif" width="250" height="400">|<img src = "https://i.imgur.com/MfvKuGd.gif" width="250" height="400">|
|์ํ ๊ฒ์ ํ๋ฉด|์ํ ๊ฒ์ ์ ์ํ ์์ธ ํ๋ฉด|
|<img src = "https://i.imgur.com/7iF6hrG.gif" width="250" height="400">|<img src = "https://i.imgur.com/tsx3kNJ.gif" width="250" height="400">|

## ํค์๋
<details>
    
**<summary>๋ด์ฉ ๋ณด๊ธฐ**
    
</summary>
    
- MVVM
- RxSwift๋ฅผ ์ด์ฉํ ViewModel๊ณผ View์ ๋ฐ์ธ๋ฉ
- Alamofire Mocking Test
- Testable ViewModel
- ImageCaching with Concurrency
- Custom TabBar
- Coodinator Pattern
    
</details> 

## ๊ณ ๋ฏผํ ์ 
<details>
    
**<summary>Alamofire์ MockSession์ ์ด๋ป๊ฒ ์ฃผ์ํด์ผ ํ  ์ง**
    
</summary>
    
- ๊ด๋ จ ํฌ์คํธ๋ก ๋์ฒด -> [Alamofire์ Mock Testํด๋ณด๊ธฐ](https://velog.io/@iamgroot1231/Alamofire%EC%9D%98-Mock-Test%ED%95%B4%EB%B3%B4%EA%B8%B0)
    
</details> 

<details>
    
**<summary>Coodinator ํจํด์ ์ค๊ณ๋ฐฉ์**
    
</summary>
    
- Coodinator ํจํด์ ์ฌ์ฉ ์ ๋ฐ๋ณต๋๋ ํ๋ฉด์ด๋ ์ฌ๋ฌ๊ฐ์ง ์ธ๋ถ์ ์ธ ๋ด์ฉ์ ๋ํ ํ๋ฉด์ด๋์ด ์ ์ฐํ๋ค๋ ์ ์ ํ์ตํ๊ณ , ์ ์ฉํด๋ณด๊ธฐ ์ํด ์ฌ์ฉํ์ต๋๋ค. [the-coordinator](https://khanlou.com/2015/01/the-coordinator/)
- ๋ทฐ์ ํ๋ฆ์ ๊ตฌํํ๋ฉด์ ์ด๋ค Coodinator๊ฐ ์ด๋ค Parent์ Child๋ฅผ ๊ฐ์ ธ์ผ ํ  ์ง์ ๋ํ ๊ณ ๋ฏผ์ ๋ค์์ต๋๋ค. 
    
    1. List Coodinator๋ฅผ ์ค์ฌ์ผ๋ก ํ๋ฉด์ด๋์ด ํ์ํ Info Coodinator, Calender Coodinator, Search Coodinator๋ฅผ Child๋ก ๊ตฌํํ์ต๋๋ค.
    2. Search Coodinator๋ ์ํ์ ์ ๋ณด๋ฅผ ๋ณด์ฌ์ค์ผ ํ๊ธฐ ๋๋ฌธ์ Info Coodinator๋ฅผ Child๋ก ๊ตฌํํ์ต๋๋ค.
    3. ๊ตฌํํ Coodinator ํจํด์ด ์ ์ ํ์ง์ ๋ํ ์๋ฌธ์ด ์๊ฒผ๊ณ , ์ด๋ค ๋ถ๋ถ์์ ์ฅ์ ์ด ๋๋์ง ์์ง ์ ๋ชจ๋ฅด๊ฒ ์ต๋๋ค.
    4. ๊ตฌ์กฐ
    <img src = "https://i.imgur.com/SkBLmP8.png" width="700" height="250">
    
</details> 

<details>

**<summary>actor๋ฅผ ์ฌ์ฉํด์ ImageCache ์ฒ๋ฆฌํ๋ ๋ฐฉ๋ฒ**

</summary>
    
- ๊ด๋ จ ํฌ์คํธ๋ก ๋์ฒด -> [actor๋ฅผ ์ฌ์ฉํด์ ImageCaching ํด๋ณด๊ธฐ](https://velog.io/@iamgroot1231/actor%EB%A5%BC-%EC%82%AC%EC%9A%A9%ED%95%B4%EC%84%9C-ImageCaching-%ED%95%B4%EB%B3%B4%EA%B8%B0)
    
</details>

<details>

**<summary>์ผ๋ณ, ์ฃผ๊ฐ, ์ฃผ๋ง ๋ฐ์ค์คํผ์ค๋ฅผ ๋ถ๋ฆฌํ๊ธฐ ์ํด ์๋จ์ TabBar๋ฅผ ๊ตฌํํ๋ ๋ฐฉ๋ฒ**

</summary>
    
- UIKit์ ์กด์ฌํ๋ ๊ธฐ๋ณธ TabBar๋ ํ๋จ์๋ง ๊ตฌํ์ด ๊ฐ๋ฅํ์ง๋ง, ๋น๊ทผ๋ง์ผ๊ณผ ๊ฐ์ ์ฑ์์ ์๋จ์ TabBar๊ฐ ์กด์ฌํจ์ ๋ณด๊ณ  ์ปค์คํํด์ ๋ง๋ค์ด๋ณด๊ณ  ์ถ์์ต๋๋ค.
  
    - [๋ธ๋ก๊ทธ](https://baked-corn.tistory.com/111)๋ฅผ ์ฐธ๊ณ ํด์ ์ปฌ๋ ์๋ทฐ ํ๋จ์ indicatorView๋ฅผ ๊ตฌํํด์ ๊ฐ๊ฐ์ ํด๋ฆญ ์ด๋ฒคํธ๋ฅผ ์๋ ฅ๋ฐ์ ์ indicatorView ์์น๋ฅผ ์ ์ ํ๊ฒ ๋ณ๊ฒฝํ๋ ๋ฐฉ๋ฒ์ผ๋ก ๊ตฌํํ์ต๋๋ค.
    - ์ ๋ธ๋ก๊ทธ์์  ์ปฌ๋ ์๋ทฐ ๋ด๋ถ์ ์ปฌ๋ ์ ๋ทฐ๋ฅผ ๋ฃ๋ ๋ถ๋ถ์ด ์์๋๋ฐ `์ผ๋ณ, ์ฃผ๊ฐ, ์ฃผ๋ง์ ๊ฐ๊ฐ์ ์๋ก ๋๋๋ ๋ฐฉ๋ฒ์ด ์๋๋ผ ํ๋์ ๋ทฐ๊ฐ ์๋ก๊ณ ์นจ ๋๋ ํํ๋ก ๋ฐ๊พธ๊ธฐ ์ํ ๋ฐฉ๋ฒ์ ๊ณ ๋ฏผ`ํ์ต๋๋ค.
    - ์ ํด๋ฆญ ์ View์ Frame์ 3๋ถ์ 1๋ก ๋๋ ๋ถ๋ถ์ผ๋ก indicatorView๋ฅผ ์ฎ๊ฒจ์ฃผ๋ ํํ๋ก ๊ตฌํํ์ต๋๋ค.
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

## ํธ๋ฌ๋ธ ์ํ
<details>

**<summary>๊ฒ์ํ๋ฉด์์ ์ํ ์ ํด๋ฆญ ์ ์์ธํ๋ฉด ์ ํ์ด ์ค๋ณตํธ์ถ ๋๋ ๋ฌธ์ **
    
</summary>
    
- ์ํ๊ฒ์ ํ๋ฉด์์ ๊ฒ์ ํ ์ํ์ ์์ ์ฌ๋ฌ๋ฒ ํด๋ฆญ ์ ์์ธํ๋ฉด์ผ๋ก ๋์ด๊ฐ๋ ๋ถ๋ถ์ ๋น๋๊ธฐ ๋ฐฉ์์ผ๋ก ์ค๊ณํ์ต๋๋ค.
- ๋์ผํ ์์ ์ฌ๋ฌ๋ฒ ํด๋ฆญ ์ ๋ทฐ ์ด๋ ํจ์์ ์ค๋ณต์ ์ธ ํธ์ถ๋ก ์ธํด ์คํ ํ์์ผ๋ก ์์ธํ๋ฉด์ด ์์ด๋ ๋ฌธ์ ๊ฐ ์์์ต๋๋ค.
   
    - ๋ฌธ์ ํ๋ฉด
    <img src = "https://i.imgur.com/CZX7TGs.gif" width="250" height="400">


- ํด๊ฒฐ์ ์ํ ์๋
    1. distinctUntilChanged() ๋ฉ์๋๋ฅผ ์ฌ์ฉํด์ ์ค๋ณต์ ์ ๊ฑฐํ๋ฉด ์ค๋ณตํธ์ถ์ด ์ฌ๋ผ์ก์ต๋๋ค. ํ์ง๋ง, ์ ์์ ์ผ๋ก ํ๋ฉด์ด๋ ํ ๋ค์ ํ๋ฉด์ด๋์ด ๋ถ๊ฐ๋ฅ ํ์ต๋๋ค. 
    ```swift
    listView.rx.modelSelected(NaverMovieModel.self)
                .distinctUntilChanged()
                .subscribe(onNext: { [weak self] model in
                    self?.viewModel.input.didTapCell(model: model)
                })
                .disposed(by: disposeBag)
    ```
    
    2.  isSelectedCell ์ด๋ผ๋ ์ ์ญ๋ณ์๋ฅผ ์ถ๊ฐํด์ ํ์ธํ๋ ๋ฐฉ๋ฒ์ผ๋ก ํด๊ฒฐํ์ต๋๋ค. `์ด ๋ถ๋ถ์ ์ถํ์ ์กฐ๊ธ ๋ RxSwift๋ฅผ ํ์ฉํ ๋ฐฉ์์ผ๋ก ์์ ์ ํด๋ณด๋ ค๊ณ  ํฉ๋๋ค.`
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

## ์ฐธ๊ณ 
---

[๐ ๋งจ ์๋ก ์ด๋ํ๊ธฐ](#-mongsil)
