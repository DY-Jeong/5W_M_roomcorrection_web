# 차량 룸 보정 측정 페이지

20밴드 EQ 앱(hmg-eq20)의 룸 보정용 스마트폰 측정 페이지입니다. GitHub Pages(HTTPS)로 열면
안드로이드·아이폰 모두 브라우저에서 마이크를 쓸 수 있습니다.

**측정 페이지: https://dy-jeong.github.io/5W_M_roomcorrection_web/**

- 녹음과 계산은 모두 폰 안에서 하며, 녹음은 저장하거나 전송하지 않습니다(서버 없음).
- 결과는 **36자 측정 코드**로 나오고, 헤드유닛 EQ 앱 → 룸 보정에서 입력합니다.
  이전 버전 EQ 앱용 25자 코드도 결과 화면의 접힌 항목에 함께 표시됩니다.
- `index.html` 한 파일에 측정 코드(`roomcorr-core.js`, `roomcorr-mics.js`)가 모두 들어 있습니다.
  이 파일만 올리면 됩니다.

## 변경 이력

### 2026-11-26 — 측정 코드 v2 (커밋 `2cb4845`)

헤드유닛 EQ 앱의 파라메트릭 EQ·정밀 보정·저역 필터를 룸 보정에 쓸 수 있도록, 폰은 **보정값 대신 측정값**을
보내고 보정 계산은 헤드유닛이 하도록 바꿨습니다.

| 항목 | 이전 (v1) | 지금 (v2) |
|---|---|---|
| 코드 길이 | 25자 (5-5-5-5-5) | 36자 (6-6-6-6-6-6) |
| 코드 내용 | 20밴드 보정값 (1 dB 단위) | 1/3 옥타브 31점 측정 편차 (20 Hz~20 kHz, 1 dB 단위, 측정 못 한 점 표시) |
| 보정 계산 | 폰 | 헤드유닛 |
| 오류 검출 | CRC-8, 한 글자 오타 모두 검출 | 동일 |

- **분석 해상도 향상**: 20개 반 옥타브 밴드 대신 31개 1/3 옥타브 지점을 측정해, 밴드 사이의 좁은 공진·딥도 잡힙니다.
- **측정 위치 간 편차 반영**: 머리 위치를 바꿔 측정한 값들이 크게 다른 지점(한 위치에서만 생긴 현상)은
  편차에 따라 약하게 반영합니다. 결과 화면에 해당 지점 수를 표시합니다.
- **헤드유닛에서 하는 일** (EQ 앱 2026-11-26 이후 버전):
  - 20밴드 곡선과 파라메트릭 밴드(최대 12개)를 함께 생성 — 어느 모드로 바꿔도 룸 보정이 유지됩니다.
  - 목표 곡선(플랫 / 차량 기본 / 저음 강조)과 딥 보강(안 함 / 절반 / 모두)을 측정 후에도 바꿀 수 있고, 바로 다시 계산됩니다.
  - 깊고 좁은 딥(머리 위치에 따라 움직이는 상쇄)은 보강하지 않고, 30 Hz 미만은 부스트하지 않습니다.
  - 저역 측정값이 있으면 초저역 차단 필터(20/25/30 Hz)를 자동으로 정합니다.
- **호환성**:
  - 새 EQ 앱은 첫 글자로 버전을 구분해 25자·36자 코드를 모두 받습니다.
  - 이전 EQ 앱에는 36자 코드를 넣을 수 없으니, 결과 화면의 "이전 버전 EQ 앱용 25자 코드"를 쓰세요.
- 변경 파일: `../roomcorr/web/roomcorr-core.js` (`measurement`, `encode2`, `codeLength`, 1/3 옥타브 분석),
  `../roomcorr/web/index.html` (36자 코드 표시, 위치 편차 안내), `../roomcorr/test/test-core.js` (v2 테스트 3개,
  `vectors2.json` 생성).

### 2026-11-18 — 최초 게시 (커밋 `60b7474`)

- 20밴드 보정값을 담은 25자 코드 (v1).

## 게시 (처음 한 번)

1. GitHub 저장소: https://github.com/DY-Jeong/5W_M_roomcorrection_web
2. 이 폴더에서:
   ```
   git remote add origin https://github.com/DY-Jeong/5W_M_roomcorrection_web.git
   git push -u origin main
   ```
3. 저장소 Settings → Pages → Source: `Deploy from a branch`, Branch: `main` / `/ (root)` → Save.
4. 1~2분 후 `https://dy-jeong.github.io/5W_M_roomcorrection_web/` 에서 열립니다. 폰 홈 화면에 추가해 두면 편합니다.

GitHub Pages를 무료 계정으로 쓰려면 저장소가 공개(Public)여야 합니다. 이 폴더에는 측정 페이지만 있고 차량 데이터나 헤드유닛 파일은 없습니다.

## 갱신

측정 코드(`../roomcorr/web`)를 고친 뒤:

```
powershell -ExecutionPolicy Bypass -File update.ps1
git commit -am "update page"
git push
```

`update.ps1`은 JS 테스트를 돌리고 단일 파일 페이지를 다시 만들어 `index.html`로 복사합니다.
페이지와 헤드유닛 앱의 코드 형식이 맞는지는 `vectors.json`(v1)·`vectors2.json`(v2)으로 앱 `CoreTest`가 확인하므로,
코드 형식을 바꿨다면 EQ 패키지(`20_tools\build_hmg_eq20.cmd`)도 같이 다시 빌드하세요.
