
# Search Image APP

## 개발 환경

- Flutter 3.16.9
- Dart 3.2.6
- Android Studio(Hedgehog | 2023.1.1)
- Github
- 카카오 개발자 계정 및 REST API 키 활성화


## 환경 설정

**프로젝트 루트에 `.env` 파일 생성하기:**
이 파일에는 카카오 REST API 키가 포함되어야 합니다. 프로젝트 루트에 `.env` 파일을 생성하고 다음 줄을 추가하세요:
   ```
   KAKAO_REST_API_KEY='KakaoAK 카카오_REST_API_KEY'
   ```
## 프로젝트 아키텍쳐

**Clean Architecture** : 클린 아키텍처 기반으로 Flutter 프로젝트에 맞게 재해석하여 구성

## 주요 라이브러리

- **API 통신**: `retrofit`, `dio`
- **의존성 주입(DI)**: `get_it`, `injectable`
- **상태 관리**: `flutter_riverpod`
- **로컬 데이터베이스**: `isar`
- **이미지 캐싱**: `cached_network_image`

## Development Support

- ChatGPT
- Github Copilot

