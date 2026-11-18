# 차량 룸 보정 측정 페이지

20밴드 EQ 앱(hmg-eq20)의 룸 보정용 스마트폰 측정 페이지입니다. GitHub Pages(HTTPS)로 열면
안드로이드·아이폰 모두 브라우저에서 마이크를 쓸 수 있습니다.

**측정 페이지: https://dy-jeong.github.io/5W_M_roomcorrection_web/**

- 녹음과 계산은 모두 폰 안에서 하며, 녹음은 저장하거나 전송하지 않습니다(서버 없음).
- 결과는 25자 코드로 나오고, 헤드유닛 EQ 앱 → 룸 보정에서 입력합니다.

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
