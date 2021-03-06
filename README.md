# swift-pokergameapp


<br>



## Step1 - 게임판 만들기

- 앱 기본 설정을 지정해서 StatusBar 스타일을 LightContent로 보이도록 한다.
- ViewController 클래스에서 self.view 배경을 다음 이미지 패턴으로 지정한다. 이미지 파일은 Assets에 추가한다.
- 다음 카드 뒷면 이미지를 다운로드해서 프로젝트 Assets.xcassets에 추가한다.
- ViewController 클래스에서 코드로 아래 출력 화면처럼 화면을 균등하게 7등분해서 7개 UIImageView를 추가하고 카드 뒷면을 보여준다.
- 카드 가로와 세로 비율은 1:1.27로 지정한다.



### 새롭게 알게 된 점

- 뷰의 백그라운드 컬러를 반복되는 이미지로 지정할 수 있다
- 스택 뷰를 사용하면 스택뷰가 내부의 아이템들을 알아서 정렬 해준다
- 코드로 오토레이아웃 지정을 처음 해봤다. 어려울 줄 알았는데 생각보다 할만했다.
- status bar에 대해 그간 전혀 생각하지 않고 있었는데, 어두운 배경에는 밝게 표시되도록 변경해줄 수 있다.

### 어려웠던 점

- 스택 뷰 내부의 구성이 어떻게 이뤄지고, 어떤 속성을 가지고 있는지 몰라서 좀 헤맸다.
- 스토리보드로 화면을 만들 땐, 일단 즉각적으로 보여지니 오토레이아웃에 대해 크게 생각하지 않았는데 코드로 만들 땐 필수다. 이점을 놓치고 있어서 조금 어려웠지만 극복 



<img src="https://user-images.githubusercontent.com/40784518/73843413-f359d600-4861-11ea-9152-4621cd453f77.png" width="30%"></img>





<br>



## Step2 - 카드 클래스

- 객체지향 프로그래밍 방식에 충실하게 카드 클래스(class)를 설계한다.
  - 속성으로 모양 4개 중에 하나, 숫자 1-13개 중에 하나를 가질 수 있다.
  - 모양이나 숫자도 적당한 데이터 구조로 표현한다. 클래스 혹은 Nested enum 타입으로 표현해도 된다.
  - 카드 정보를 출력하기 위한 문자열을 반환하는 함수를 구현한다.
  - 문자열에서 1은 A로, 11은 J로, 12는 Q로, 13은 K로 출력한다.
- ViewController에서 특정한 카드 객체 인스턴스를 만들어서 콘솔에 출력한다.

### 고민한 점

card class 안에서 패턴과 숫자를 함께 표시하기에 열거형이 접근도 간편하고, 함수도 넣어 사용할 수 있어서
가공하기에도 좋을 것 같아 선택했다.





<br>



## Step3 - 카드덱 구현과 테스트

- 모든 종류의 카드 객체 인스턴스를 포함하는 카드덱 구조체를 구현한다.
- 객체지향 설계 방식에 맞도록 내부 속성을 모두 감추고 다음 인터페이스만 보이도록 구현한다.
  - count 갖고 있는 카드 개수를 반환한다.
  - shuffle 기능은 전체 카드를 랜덤하게 섞는다.
  - removeOne 기능은 카드 인스턴스 중에 하나를 반환하고 목록에서 삭제한다.
  - reset 처음처럼 모든 카드를 다시 채워넣는다.
- 메소드 매개변수와 리턴값은 어떤 타입이 좋을지, 속성으로 무엇이 필요한지, 불변 Immutable 인지 가변 mutable 인지 판단해야 한다.
- 카드덱 기능을 확인할 수 있도록 단위 테스트를 추가한다.
- 사용자가 다음과 같이 입력하는 예상 시나리오를 그대로 테스트한다.



### 고민한 점

- card deck에서 모든 card 종류를 만들어야 하는데, enum의 모든 케이스를 어떻게 돌릴까 생각하다, `CaseIterable` 프로토콜을 이용하여 enum의 모든 케이스를 순회할 수 있게 하였다.
- card deck에서 card 생성 시 별도의 메소드를 사용하려다가, 굳이 메소드로 빼지 않고 card deck 생성시 모든 card가 만들어지도록 init()안에서 구현하였다.



<br>

## Step4 - 포커 딜러와 게임 테스트

- 포커 딜러 선택을 위한 새로운 입력 뷰가 있다고 가정한다.
  - 게임은 7카드스터드 방식과 5카드스터드를 지원한다.
- 참여자는 딜러를 제외하고 1명에서 4명까지 참여할 수 있다.
- 카드게임 종류와 참여자수에 따라 각기 다른 동작을 해야한다.
- 카드가 남은 경우는 계속해서 게임을 진행하고, 카드가 부족할 경우 종료한다고 가정한다.



### 고민한 점

**Dealer**

- player들에게 카드를 나눠준다
- 본인도 카드를 가진다

**Player**

- 카드를 배분받는다

**PokerGame**

- 7stud, 5stud 중 선택 가능
- 선택된 stud에 따라 dealer가 player들에게 카드 배분
- 남은 카드 갯수 확인

### 수정 사항

1. 접근 제어자 변경
2. 사용하지 않는 코드 삭제
3. 하위 객체 속성에 간접 접근하도록 dealer와 player 안에 메소드 추가
4. 테스트 코드 변경

<img src="https://user-images.githubusercontent.com/40784518/75237536-dd0cbd80-5802-11ea-8cb4-41f28e9217a6.png" width="50%"></img>





<br>



## Step5 - 포커게임 결과화면

- 각각의 카드 정보에 맞게 이미지 매칭
- 선택된 Stud / Player Count 에 따라 출력되는 카드의 갯수와 이미지 변경
- App의 shake 동작시 카드 섞이도록 구현 



### 고민한 점

- 각 카드에 맞게 이미지를 매치해주기 위해서 VC에서 어떻게 Player의 Cards에 접근할지 고민했습니다.. 만들고 보니 getter로 만든 것 같아 리팩토링이 필요할거 같다
- Card 타입에 CustomStringConvertible을 사용해 string값을 리턴받아 이미지 이름과 매치되도록 하였다.
- 딜러와 플레이어가 공통적인 기능을 하는 부분이 있어, 처음엔 딜러가 플레이어를 상속받게 만들었으나, 그 둘은 상속관계가 아닌 대등한 관계라 생각되어 프로토콜을 따로 만들어 채택.
- segmented control에서 선택된 만큼 stackview를 생성해주기 위해 메서드를 사용.



### 수정 사항

- 클로저를 이용해서 연결된 구조에 동작을 넘겨준다는 것이 잘 와닿지 않았는데, 피드백 반영하며 코드 수정하면서 어제보다는 클로저에 대해 좀 더 이해하게 된 것 같다.
- VC > PokerGame > Player > Card 로 접근했었는데, 플레이어별로 카드의 구분 없이 한꺼번에 가져오게 되어 Players 클래스를 추가로 만들었다.

<img src="https://user-images.githubusercontent.com/40784518/74433200-4e637c80-4ea3-11ea-9bf9-33dccf460c26.png" width="30%"></img><img src="https://user-images.githubusercontent.com/40784518/74433246-64713d00-4ea3-11ea-8693-4c97a1508eab.png" width="30%"></img>

 

<br>



## Step6 - 승자 확인하기

- 7카드, 5카드에서 **원페어, 투페어, 트리플, 포카드, 스트레이트 규칙**만 판단해서 이긴 사람을 자동으로 계산하는 방법을 추가한다. 더 우선순위가 높은 규칙은 일반적인 Texas Holdem 카드게임 규칙을 따른다.
  - **원페어** = 가진 카드 중 두 카드 숫자가 같은 경우
  - **투페어** = 가진 카드 중 두 카드 숫자가 같은 경우가 두 가지 이상
  - **트리플** = 가진 카드 중 세 카드 숫자가 같은 경우
  - **스트레이트** = 가진 카드 중 다섯 카드 숫자가 연속 번호인 경우
  - **포카드** = 가진 카드 중 네 카드 숫자가 같은 경우
  - 페어가 없을 경우 또는 같은 핸즈인 경우 숫자가 높은 카드를 가진 사람이 우승한다.
- 화면에 승자 표시를 위한 이미지 뷰를 추가하고, 위에 계산한 점수를 기준으로 승자를 표시한다.



### 고민한 점

1. 승자 구하는 로직

- hands에서 플레이어가 가진 카드를 기반으로 페어가 있는지 / 스트레이트인지 구함
- PokerGame에서 플레이어간 결과를 비교하는데, 결과가 같은 경우 가지고 있는 카드가 큰 플레이어가 이기도록 구현
- 클로저를 사용해 플레이어 각각의 승패 결과를 가지고 오도록 함

2. 화면에 승자 표시하기

- 메달 이미지를 넣어주기 위해 스택뷰를 내부에 하나 더 생성했는데, 사이즈가 제멋대로여서 찾아보니 스택뷰 내부의 이미지 사이즈도 조정이 가능해서 적용함
- 이긴 플레이어에게 메달 표시를 해줄때 스택뷰의 인덱스로 접근하게 했음..

<img src="https://user-images.githubusercontent.com/40784518/75237898-85228680-5803-11ea-9fa3-0fae8f32d2b0.png" width="30%"></img><img src="https://user-images.githubusercontent.com/40784518/75237964-a2575500-5803-11ea-8dc3-de107e3a3972.png" width="30%"></img>



### 수정 사항

- Hands.swift 안에 nested 타입 선언을 GameResult.swift 로 분리
- 플레이어간의 결과 비교는 PokerGame이 아닌 하위객체인 Players 에서 하도록 수정
- ViewController 안에서 Player와 Dealer가 겹치는 부분 메소드로 분리
- ViewController 안에서 private으로 선언되어있던 속성인 isWinner 확인하는 걸 기존 클로저 이용하는 것에서 접근제한자를 private(set)으로 수정해 값만 가져오도록 변경 
- 승자에게 메달 달아주는 애니메이션 추가 🏅
