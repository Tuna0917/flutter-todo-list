# todo_list
데이터 관련 실습의 정석(웃음) **TO-DO LIST**

## 구조
1. 화면
    1. SplashScreen(초기 진입 스플래시 화면)
    2. LoginScreen(로그인 화면)
    3. ListScreen(홈 화면)
    4. NewsScreen(뉴스 화면)
2. 기능
    1. 로그인 -> 아이디와 비밀번호를 입력하면 검증없이 로그인
    2. 자동 로그인 -> 앱을 다시 열었을 때 로그인 화면 스킵(SharedPreferences)
    3. Todo 목록보기(sqlite / Firebase)
    4. Todo 상세보기(sqlite / Firebase)
    5. Todo 등록하기(sqlite / Firebase)
    6. Todo 삭제하기(sqlite / Firebase)
    7. Todo 수정하기(sqlite / Firebase)
    8. 뉴스 가져와서 보여주기(API)


## Firebase

```bash
# zsh
flutterfire configure
```

https://firebase.google.com/docs/flutter/setup?hl=ko&platform=ios