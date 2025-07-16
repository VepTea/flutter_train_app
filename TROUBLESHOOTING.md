# Flutter 기차 예약 앱 - 트러블슈팅 가이드

## 🚨 개발하면서 겪은 문제들과 해결 방법

### 1️⃣ 상태 공유 문제 (제일 중요한 교훈!)

#### 📖 스토리: "왜 역이 선택되지 않을까?"
처음에 역 선택 기능을 만들 때, StationSelectBox 위젯 안에서 `StationBoxData()`를 새로 만들어버렸어요. 그런데 이상하게도 역을 선택해도 화면에 반영이 안 되더라고요. 

"분명히 역을 선택했는데 왜 안 바뀌지?" 하면서 한참을 헤맸는데, 알고 보니 하위 위젯에서 새로 만든 객체랑 상위에서 만든 객체가 완전히 다른 존재였던 거예요. 마치 같은 이름의 다른 사람처럼... 😅

#### ❌ 이렇게 하면 안 돼요
```dart
// 하위 위젯에서 새로 만들면 안됨
class StationSelectBox extends StatelessWidget {
  StationSelectBox() {
    this.stationBoxData = StationBoxData(); // ❌ 새로 만들면 안됨!
  }
}
```

#### ✅ 이렇게 해야 해요
```dart
// 상위에서 만들고 전달받기
class StationSelectBox extends StatelessWidget {
  StationSelectBox({required this.stationBoxData});
  final StationBoxData stationBoxData; // ✅ 전달받기
}
```

#### 🔍 왜 이렇게 해야 하는지
- 하위 위젯에서 `StationBoxData()`로 새로 만들면
- HomePage에서 만든 원본 객체랑 **완전히 다른 새로운 객체**가 됨
- 그래서 **상태 공유가 안 됨** (원본이 바뀌어도 새 객체는 모름)
- 마치 같은 이름의 다른 사람처럼... 완전히 다른 존재!

#### 💡 앞으로 이렇게 하자
- **상태값은 한 번만 만들고** (상위에서)
- **그걸 그대로 전달받기** (하위에서)
- 같은 객체를 공유해야만 상태 변경이 서로 반영됨

---

### 2️⃣ Navigator.pop() 호출 문제

#### 📖 스토리: "왜 다이얼로그가 안 닫힐까?"
좌석 선택 후 확인 다이얼로그를 만들었는데, 취소나 확인 버튼을 눌러도 다이얼로그가 안 닫히더라고요. 

"버튼은 잘 눌리는데 왜 안 닫히지?" 하면서 한참을 고민했는데, 알고 보니 `Navigator.pop` 함수 호출할 때 괄호를 빼먹었던 거예요. 함수 자체를 전달해버려서 실행이 안 됐던 거죠! 😂

#### ❌ 이렇게 하면 다이얼로그가 안 닫혀요
```dart
onPressed: () {
  Navigator.pop(); // ❌ context 없으면 안됨
}
```

#### ✅ 이렇게 해야 닫혀요
```dart
onPressed: () {
  Navigator.pop(context); // ✅ context 필수!
}
```

#### 🔍 왜 이렇게 해야 하는지
- `Navigator.pop`은 **context가 필수**임
- context가 없으면 어떤 화면을 닫을지 모름
- 결과적으로 다이얼로그가 안 닫힘 (짜증!)

#### 💡 Context란?
- **Context**는 위젯이 화면에서 어디에 있는지 알려주는 위치 정보
- 마치 GPS 좌표처럼 "지금 이 위젯이 앱의 어느 부분에 있는지" 알려줌
- Navigator가 "어떤 화면을 닫을지" 결정할 때 이 정보를 사용함
- context가 없으면 Navigator가 "어디를 닫아야 하지?" 하고 혼란스러워함

---

### 3️⃣ setState 사용 문제

#### 📖 스토리: "왜 setState가 안 될까?"
좌석 선택 기능을 만들 때, StatelessWidget에서 `setState`를 사용하려고 했는데 에러가 나더라고요.

"분명히 setState는 이렇게 쓰는 건데 왜 안 되지?" 하면서 한참을 헤맸는데, 알고 보니 StatelessWidget에서는 상태 변경이 안 되는 거였어요. StatefulWidget으로 바꿔야만 했던 거죠! 🤦‍♂️

#### ❌ 이렇게 하면 에러나요
```dart
class MyWidget extends StatelessWidget {
  void updateState() {
    setState(() {}); // ❌ StatelessWidget에서는 안됨
  }
}
```

#### ✅ 이렇게 해야 돼요
```dart
class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  void updateState() {
    setState(() {}); // ✅ StatefulWidget에서만 가능
  }
}
```

#### 🔍 왜 이렇게 해야 하는지
- `setState`는 `StatefulWidget`에서만 사용 가능
- `StatelessWidget`은 상태 변경이 안 됨 (고정된 위젯)

---

### 4️⃣ ListView inside Column 문제

#### 📖 스토리: "왜 좌석 배치도가 안 보일까?"
좌석 선택 페이지를 만들 때, Column 안에 ListView를 넣었는데 에러가 나더라고요.

"ListView는 이렇게 쓰는 건데 왜 에러가 나지?" 하면서 한참을 고민했는데, ListView가 "나는 무한한 높이가 필요해!"라고 하는데 Column은 "나는 제한된 높이만 줄 수 있어"라고 해서 싸움이 났던 거예요. Expanded가 중간에서 "적당한 높이를 줄게!"라고 해결해줬죠! 😅

#### ❌ 이렇게 하면 에러나요
```dart
Column(
  children: [
    ListView( // ❌ 무한 높이 에러!
      children: [...],
    ),
  ],
)
```

#### ✅ 이렇게 해야 돼요
```dart
Column(
  children: [
    Expanded( // ✅ 높이 제약 추가
      child: ListView(
        children: [...],
      ),
    ),
  ],
)
```

#### 🔍 왜 이렇게 해야 하는지

**문제 상황:**
- `ListView`는 "내가 얼마나 높이를 가질 수 있는지 알려줘!"라고 요구함
- `Column`은 "나는 높이를 제한하지 않아. 너가 알아서 해!"라고 함
- 둘 다 높이를 결정하지 못해서 **무한 높이 에러**가 발생함

**해결 방법:**
- `Expanded`는 "내가 사용할 수 있는 공간을 모두 너에게 줄게!"라고 함
- Column의 남은 공간을 모두 ListView에게 할당해줌
- ListView는 그 공간만큼만 사용하게 됨

**실제 예시:**
```dart
Column(
  children: [
    Text("제목"), // 고정 높이
    Expanded( // 남은 공간을 모두 사용
      child: ListView(...), // Expanded가 준 공간만큼만 사용
    ),
  ],
)
```


---

### 5️⃣ Boolean 플래그 사용 문제

#### 📖 스토리: "왜 출발역을 눌렀는데 도착역 페이지가 나올까?"
역 선택 기능을 만들 때, 출발역을 눌렀는데 도착역 선택 페이지가 나오는 이상한 일이 있었어요.

"분명히 출발역을 눌렀는데 왜 도착역 페이지가 나오지?" 하면서 한참을 헤맸는데, Boolean 값을 전달할 때 부정 연산자(`!`)를 사용해서 의도와 다른 값이 전달됐던 거예요. 명시적으로 `true`/`false`를 전달하니까 해결됐죠! 😂

#### ❌ 이렇게 하면 의도와 다르게 동작해요
```dart
// 역 선택 시
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => StationListPage(
      departOrArrive: !departOrArrive, // ❌ 부정 연산자 사용하면 헷갈림
    ),
  ),
);
```

#### ✅ 이렇게 하면 명확해요
```dart
// 출발역 선택 시
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => StationListPage(
      departOrArrive: true, // ✅ 명확하게 true
    ),
  ),
);

// 도착역 선택 시
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => StationListPage(
      departOrArrive: false, // ✅ 명확하게 false
    ),
  ),
);
```

#### 🔍 왜 이렇게 해야 하는지
- 부정 연산자(`!`)를 사용하면 의도와 다른 값이 전달될 수 있음
- 명시적으로 `true`/`false` 값을 전달하는 게 안전하고 명확함

---

## 🎯 앞으로 개발할 때 기억할 것들

### 1. 상태 관리 💾
- **상태값은 한 번만 만들고 그걸 전달받기**
- **절대 하위에서 새로 만들지 말기**
- **같은 객체를 공유해야 상태 변경이 반영됨**

### 2. 함수 호출 📞
- **콜백함수 호출할 때 괄호 확인하기**
- **Navigator.pop() 등 함수 호출할 때 괄호 필수**

### 3. 위젯 타입 🔄
- **setState 쓸 때 StatefulWidget인지 확인하기**
- **상태 변경이 필요하면 StatelessWidget → StatefulWidget 바꾸기**

### 4. 레이아웃 제약 📐
- **ListView를 Column 안에 넣을 때 Expanded 사용하기**
- **높이 제약이 필요한 위젯들 주의하기**

### 5. Boolean 값 ✅
- **명시적인 true/false 값 사용하기**
- **부정 연산자 사용할 때 주의하기**



## 🚀 추가 팁

### 디버깅할 때 체크리스트
- [ ] 상태값이 제대로 전달되고 있나?
- [ ] 함수 호출 시 괄호가 빠졌나?
- [ ] 위젯 타입이 맞나? (Stateless vs Stateful)
- [ ] 레이아웃 제약이 해결되었나?
- [ ] Boolean 값이 의도한 대로 전달되나?

## 📚 참고할 만한 자료들

- [Flutter StatefulWidget vs StatelessWidget](https://docs.flutter.dev/development/ui/widgets-intro)
- [Flutter Navigator](https://docs.flutter.dev/cookbook/navigation)
- [Flutter Layout Constraints](https://docs.flutter.dev/development/ui/layout/constraints) 