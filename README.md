# Flutter 기차 예약 앱 - lib 폴더 구조

## 📁 폴더 구조

```
lib/
├── main.dart                    # 앱 진입점
└── pages/                      # 페이지별 폴더
    ├── home/                   # 홈 페이지
    │   ├── classes/
    │   │   └── variable_classes.dart    # 데이터 클래스 정의
    │   ├── widgets/
    │   │   ├── station_select_box.dart  # 역 선택 박스 위젯
    │   │   └── trip_confirm_button.dart # 좌석 선택 버튼 위젯
    │   └── home_page.dart              # 홈 페이지 메인
    ├── seat/                   # 좌석 선택 페이지
    │   ├── widgets/
    │   │   ├── seat_column.dart        # 좌석 열 위젯
    │   │   ├── guide_info.dart         # 안내 정보 위젯
    │   │   └── station_route.dart      # 역 경로 표시 위젯
    │   └── seat_page.dart              # 좌석 선택 페이지 메인
    └── station_list/           # 역 목록 페이지
        └── station_list_page.dart      # 역 목록 페이지 메인
```

## 📄 파일 설명

### 🚀 앱 진입점
- **`main.dart`**: Flutter 앱의 시작점, MaterialApp 설정 및 HomePage를 초기 화면으로 설정

### 🏠 홈 페이지 (`pages/home/`)
- **`home_page.dart`**: 메인 홈 화면, 출발역/도착역 선택 UI
- **`classes/variable_classes.dart`**: 
  - `StationBoxData` 클래스: 출발역/도착역 상태, 역 목록 데이터, 출발역 선택인지 도착역 선택인지 true false로 표시하는 상태
- **`widgets/station_select_box.dart`**: 출발역과 도착역을 선택할 수 있는 UI 컴포넌트
- **`widgets/trip_confirm_button.dart`**: 좌석 선택 페이지로 이동하는 버튼

### 🪑 좌석 선택 페이지 (`pages/seat/`)
- **`seat_page.dart`**: 좌석 선택 메인 화면, 좌석 배치도 표시
- **`widgets/seat_column.dart`**: 
  - `SeatColumn`: 개별 좌석 열을 표시하는 위젯
  - `FakeSeat`: 좌석 번호 표시용 위젯 (Seat위젯이랑 비슷하게 생겼는데, 50x50 크기의 정사각형이라는 것만 공유합니다. 안쪽엔 숫자만 있고 컨테이너 색이 없고 투명해요.)
  - `FakeSeatColumn`: 행 번호를 표시하는 위젯(SeatColumn이랑 비슷하게 생김.)
- **`widgets/guide_info.dart`**: 좌석 선택됨, 선택안됨 무슨색인지 알려줌.
- **`widgets/station_route.dart`**: 선택된 출발역-도착역 경로 정보 표시

### 🚉 역 목록 페이지 (`pages/station_list/`)
- **`station_list_page.dart`**: 역 목록을 표시하고 선택할 수 있는 페이지

## 🔄 데이터 흐름

1. **홈 페이지**에서 `StationBoxData` 객체 생성
2. 출발역/도착역 선택 시 **역 목록 페이지**로 이동
3. 역 선택 후 **홈 페이지**로 돌아와 선택된 역 정보 업데이트
4. 여행 확인 버튼 클릭 시 **좌석 선택 페이지**로 이동
5. 좌석 선택 후 예약 완료

## 🎯 주요 기능

- ✅ 출발역/도착역 선택
- ✅ 역 목록에서 역 선택
- ✅ 좌석 눌러서 선택하면 보라색으로 표시해주고, 한번 더 누르면 선택 취소됩니다.

## 🛠 기술 스택

- **Flutter**: 크로스 플랫폼 UI 프레임워크
- **Dart**: 프로그래밍 언어
- **Material Design**: UI 디자인 시스템

## 🔗 상태변수와 콜백함수 데이터 흐름

### 📊 상태변수 흐름도

```
HomePage (StatefulWidget)
├── stationBoxData (StationBoxData 객체)
│   ├── departStationName: String    # 선택된 출발역 이름 (기본값: '선택')
│   ├── arriveStationName: String    # 선택된 도착역 이름 (기본값: '선택')
│   ├── departOrArrive: bool         # 현재 출발역 선택인지 도착역 선택인지 구분
│   │                                   (true: 출발역, false: 도착역)
│   └── stationList: List<String>    # 선택 가능한 역 목록 (수서, 동탄, 평택지제, ...)

SeatPage (StatefulWidget)
├── selectedColIndex: String         # 선택된 좌석의 열 인덱스 (A, B, C, D) (기본값: ' ')
└── selectedRowIndex: int            # 선택된 좌석의 행 인덱스 (1~20) (기본값: 0)
```

### 🔄 콜백함수 흐름도

```
HomePage
├── setDepartOrArrive(bool)          # 출발역/도착역 구분 상태 변경 함수
│   │                                    # StationListPage에서 앱바 타이틀과 역 선택 시
│   │                                    # 어느 변수에 저장할지 결정하는 용도
│   └── → StationSelectBox → StationListPage
├── setDepartStationName(String)     # 출발역 이름 변경 함수
│   └── → StationSelectBox → StationListPage → HomePage (setState)
├── setArriveStationName(String)     # 도착역 이름 변경 함수
│   └── → StationSelectBox → StationListPage → HomePage (setState)
└── setSelectedColRowIndex(String, int)  # 좌석 선택 상태 변경 함수
    └── → SeatPage → SeatColumn → SeatPage (setState)
```

// "### 🎯 setState 영향 범위"

이건 setState가 호출될 때(즉, 상태가 변경될 때) 어떤 위젯들이 실제로 다시 그려지고, 그로 인해 화면에 어떤 변화가 생기는지 구체적으로 설명하는 부분입니다. 
// 예를 들어, 역을 선택하거나 좌석을 선택할 때 setState를 호출하면, 
// 어떤 위젯이 새로고침되어 텍스트나 버튼, 색상 등이 어떻게 바뀌는지 실제 영향 범위를 예시와 함께 보여주려고 하는 섹션입니다.

#### 1️⃣ 역 선택 시 (HomePage의 setState)
```dart
// StationListPage에서 역 클릭 시
onTap: () {
  if (departOrArrive) {
    setDepartStationName(stationName); // ✅ HomePage의 setState 호출
  } else {
    setArriveStationName(stationName); // ✅ HomePage의 setState 호출
  }
}
```

**setState 실행 후 영향받는 위젯들:**
- `StationSelectBox`의 출발역/도착역 텍스트가 새로 선택된 역 이름으로 업데이트
- `TripConfirmButton`이 출발역과 도착역이 모두 선택되었을 때만 활성화됨

#### 2️⃣ 좌석 선택 시 (SeatPage의 setState)
```dart
// SeatColumn에서 좌석 클릭 시
onTap: () {
  onChanged!(columnIndex!, rowIndex!); // ✅ SeatPage의 setState 호출
}
```

**setState 실행 후 영향받는 위젯들:**
- 모든 `SeatColumn`의 좌석 색상이 변경됨 (선택된 좌석: 보라색, 나머지: 회색)
- 하단 "좌석 선택" 버튼이 좌석이 선택되었을 때만 활성화됨

### 📋 매개변수 전달 체인

```
HomePage
├── StationSelectBox(
│   ├── stationBoxData,           # StationBoxData 객체
│   ├── setDepartOrArrive,        # 콜백함수
│   ├── setDepartStationName,     # 콜백함수  
│   └── setArriveStationName      # 콜백함수
│   )
├── TripConfirmButton(
│   └── stationBoxData            # StationBoxData 객체
│   )
└── SeatPage(
    └── stationBoxData            # StationBoxData 객체
    )
```

### 🔄 상태 업데이트 순서

1. **사용자 액션** (터치, 클릭)
2. **콜백함수 호출** (매개변수로 전달받은 함수)
3. **setState 실행** (상태변수 업데이트)
4. **위젯 재빌드** (변경된 상태 반영)
5. **UI 업데이트** (새로운 상태로 화면 갱신) 