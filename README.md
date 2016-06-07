# iOSTermProject [미세먼지 주의보]

각 지역별 미세먼지 농도를 확인하여 검색된 위치에 "매우나쁨~좋음" 등을 확인할수 있다.
![Image01](https://lh3.googleusercontent.com/mjB11Bu3f_Tn-SfaiMLCGfGUpL7lT3AsCROh95AhinUnVnQrwNzEZxPDkl0-ihUXY-I=h900-rw)
![Image02](https://lh3.googleusercontent.com/EcN5q1FUaDkOd6-GTb1Lep141WX-nVJGKdkWVOUwUY2Cx3eti5WguNmvbIHjjqz-xHl6=h900-rw)

[이미지출처] https://play.google.com/store/apps/details?id=cheehoon.ha.particulateforecaster

----------
개발자
----------
+ 2012180004 권창현
+ 2011180047 정택수

---------
개발 환경
---------
+ OS X El Capitan
+ XCode 7.3
+ Swift
+ iOS 8.4 이상

---------
사용하는 API
---------
+ [대기오염정보 조회 서비스](https://www.data.go.kr/subMain.jsp#/L3B1YnIvdXNlL3ByaS9Jcm9zT3BlbkFwaURldGFpbC9vcGVuQXBpTGlzdFBhZ2UkQF4wMTJtMjEkQF5wdWJsaWNEYXRhUGs9MTUwMDA1ODEkQF5icm1DZD1PQzAwMTIkQF5tYWluRmxhZz10cnVl) - 각 측정소별 대기오염정보를 조회하기 위한 서비스로 기간별, 시도별 대기오염 정보와 민감군 이상 측정소 내역, 미세먼지 예보 통보 내역을 조회할 수 있다.
+ [측정소정보 조회 서비스   ](https://www.data.go.kr/subMain.jsp?param=T1BFTkFQSUAxNTAwMDY2MA==#/L3B1YnIvdXNlL3ByaS9Jcm9zT3BlbkFwaURldGFpbC9vcGVuQXBpTGlzdFBhZ2UkQF4wMTJtMSRAXnB1YmxpY0RhdGFQaz0xNTAwMDY2MCRAXmJybUNkPU9DMDAxMiRAXnJlcXVlc3RDb3VudD00MzYkQF5vcmdJbmRleD1PUEVOQVBJ) - 대기질 측정소 정보를 조회하기 위한 서비스로 TM 좌표기반의 가까운 측정소 및 측정소 목록과 측정소의 정보를 조회할 수 있다.
+ [지번주소조회 서비스](https://www.data.go.kr/subMain.jsp#/L3B1YnIvdXNlL3ByaS9Jcm9zT3BlbkFwaURldGFpbC9vcGVuQXBpTGlzdFBhZ2UkQF4wMTJtMjEkQF5wdWJsaWNEYXRhUGs9MTUwMDAyNjgkQF5icm1DZD1PQzAwMTEkQF5tYWluRmxhZz10cnVl) - 우정사업본부에서는 현재 운영되고 있는 지번주소체계의 새우편번호(2015.8.1 시행) 및 기존우편번호를 조회하는 기능을 제공합니다.
+ [좌표계 변환, 좌표->현재위치](https://developers.daum.net/services/apis/local/geo/transcoord) - 좌표계 변환API는 입력한 좌표를 다른 좌표계의 좌표, 좌표→주소 변환API는 좌표를 입력하면 그에 해당하는 주소로 변경시킬 수 있습니다. XML, JSON(P) 형식으로 결과를 반환합니다.

---------
구현 예정 내용
---------
+ 대기오염 정보 조회 - 자신이 지정한 위치의 대기오염 정보를 조회 가능
+ 대기오염 통계 - 각 측정소의 농도 정보와 기간별 통계수치 정보 조회
+ 측정소 정보 조회 - 자신의 위치에서 TM좌표 기반의 가까운 측정소의 정보를 조회
+ 지번주소 조회 - 자신의 위치를 찾기 위한 각 시/도/군/읍/면/동 정보 조회
+ PM10, PM2.5 - 발생 원인, 예보, 등급 조회

---------
개발 일정
---------
+ 1주차 ( 05/16 ~ 05/22 ) - View의 UI제작, 지번주소 조회 구현
+ 2주차 ( 05/23 ~ 05/29 ) - 대기오염 정보 조회 구현
+ 3주차 ( 05/30 ~ 06/05 ) - 대기오염 통계, 초 미세먼지, 미세먼지 조회
+ 4주차 ( 06/06 ~ 06/09 ) - 측정소 정보 조회

---------
역할 분담
---------
+ **정택수 :**
 1. 사용자의 GPS얻기
 2. 초 미세먼지, 미세먼지 API 파싱

+ **권창현 :**
 1. 대기오염 정보 API 파싱
 2. 대기오염 통계 API 파싱

+ **공동 구현 :**
 1. 리소스 수집
 2. 지번주소 API 파싱
 3. 측정소 정보 API 파싱

---------
Youtube 업로드 영상 & PPT 자료
---------
+ [1차 발표 PPT](https://github.com/WindowsHyun/iOSProject/blob/master/Document/%EC%8A%A4%EB%A7%88%ED%8A%B8%ED%8F%B0%EA%B2%8C%EC%9E%84%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%98%EB%B0%8D%201%EC%B0%A8%20%EB%B0%9C%ED%91%9C.pptx?raw=true) / [1차 발표 영상](https://www.youtube.com/watch?v=7T7QmmTkiYM&feature=youtu.be)
+ [2차 발표 PPT](https://github.com/WindowsHyun/iOSProject/blob/master/Document/%EC%8A%A4%EB%A7%88%ED%8A%B8%ED%8F%B0%EA%B2%8C%EC%9E%84%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%98%EB%B0%8D%202%EC%B0%A8%20%EB%B0%9C%ED%91%9C.pptx?raw=true) / [2차 발표 영상](https://www.youtube.com/watch?v=87TNLEW7F-8&feature=youtu.be)

---------
참고사항
---------
* 아이패드
1. 스크린 사이즈
– 세로 : 768 * 1024 px
– 가로 : 1024 * 768 px
2. 네비게이션바 / 툴바 : 높이 44 px
3. 네비게이션바 버튼 / 툴바 버튼 : 높이 30 px
4. 네비게이션바 버튼 이미지 / 툴바 버튼 이미지 : 20 * 20 px
5. 탭바 : 높이 49 px
6. 탭바 이미지 : 30 * 30 px


앱 개발에 필요한 이미지 파일

- 72 X 72 png icon : 아이패드의 홈 화면에 표시할 앱 아이콘.
- 50 X 50 png icon : 아이패드의 스포트라이트 검색 결과 화면에 표시되는 아이콘.
- 29 X 29 png icon : iOS 설정화면에 표시될 아이콘. (옵션)
- 64 X 64 and 320 X 320 png icon : 문서 유형을 등록하는 경우 필요. (옵션)
- 768 X 1004 png image : 앱 실행 초기화면 이미지.(파일이름 아래 참고.)
- 앱 실행 초기화면 이미지 파일명.

- Default-Portrait.png : 세로보기 화면
- Default-PortraitUpsideDown.png : 뒤집힌 세로보기. 없으면 Default-Portrait.png가 대체 (옵션)
- Default-Landscape.png : 가로보기 화면
- Default-LandscapeLeft.png, Default-LandscapeRight.png : 가로보기 화면에서 왼쪽, 오른쪽을 따로 표시해야할 경우. 
- 없으면 - - -Default-Landscape.png가 대체 (옵션)
