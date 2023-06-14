# <center>JakomoProject</center>  
![Stack](https://img.shields.io/badge/flutter-02569B?style=for-the-badge&logo=Flutter&logoColor=white)
![Stack](https://img.shields.io/badge/android-3DDC84?style=for-the-badge&logo=Android&logoColor=white)
![Stack](https://img.shields.io/badge/apple-000000?style=for-the-badge&logo=IOS&logoColor=white)
![Stack](https://img.shields.io/badge/dart-0175C2?style=for-the-badge&logo=Dart&logoColor=white)
![Stack](https://img.shields.io/badge/kotlin-7F52FF?style=for-the-badge&logo=Kotlin&logoColor=white)
![Stack](https://img.shields.io/badge/swift-F05138?style=for-the-badge&logo=Swift&logoColor=white)
![Stack](https://img.shields.io/badge/firebase-FFCA28?style=for-the-badge&logo=Firebase&logoColor=white)
![Stack](https://img.shields.io/badge/bluetooth-0082FC?style=for-the-badge&logo=BLE&logoColor=white)
<table>
   <tr>
      <td>
         <img width="200px" src="./1.png">
      </td>
      <td>
         <img width="200px" src="./2.png">
      </td>
      <td>
         <img width="200px" src="./3.png">
      </td>
      <td>
         <img width="200px" src="./4.png">
      </td>
      <td>
         <img width="200px" src="./5.png">
      </td>
      <td>
         <img width="200px" src="./6.png">
      </td>
      <td>
         <img width="200px" src="./7.png">
      </td>      
   </tr>
   <tr>
      <td>
         <img width="200px" src="./8.png">
      </td>
      <td>
         <img width="200px" src="./9.png">
      </td>
      <td>
         <img width="200px" src="./10.png">
      </td>
      <td>
         <img width="200px" src="./11.png">
      </td>
      <td>
         <img width="200px" src="./12.png">
      </td>
      <td>
         <img width="200px" src="./13.png">
      </td>
    </tr>	
</table>

#### 해당 앱은 각 Store에서 내려가 동영상으로 대체합니다. 👉🏻[앱 동영상](https://drive.google.com/file/d/1ruBQovASZY0D_ppkiltXThmqzcCsqXss/view?usp=drive_link)

[1.프로젝트 소개](#😀-프로젝트-소개)    
[2.프로젝트내 담당 업무](#🧑‍💻-프로젝트내-담당-업무)  
[3.개발 기간](#⏳️-개발-기간)  
[3.기술 스택](#⚙️-기술-Stack)  
[3.협업 기관](#🙌-Contributing-and-Company)   
[3.주요 기능](#📌-주요-기능)  
[4.개발을 하고 싶어요](#Application-구조)


## 😀 프로젝트 소개  
여러 협업 기관과 함께 만든 IOT 서비스로 기기와 연동해 기기 제어 및 생체 신호 측정을 통한 건강 상태 분석등이 주요 기능인 휴식 테마의 앱입니다.    

### 🧑‍💻 프로젝트내 담당 업무  
+ 서비스 설계 -> 리메인과 기기 기반 서비스 설계 및 기획  
+ 서비스 개발 -> Flutter를 사용한 앱 개발, Firebase를 사용한 Serverless 구조 개발  
+ 배포 -> PlayStore, AppStore(현재는 Store에서 앱이 내려가 있습니다.)    

### ⏳️ 개발 기간  
* 서비스 설계 시작 : 2020.12  
* 앱 개발 시작 : 2021.01    

### ⚙️ 기술 Stack  
* 상태 관리 및 바인딩, 라우팅 -> GetX  
* 디자인 패턴 -> MVC  
* Device 통신 -> BLE  

### 🙌 Contributing and Company    
> Emmahc : 서비스 설계 및 개발, 배포, 팀 리딩  
> 생산기술연구원 : 리클라이너 설계 Support   
> Jakomo : 리클라이너 제조 및 설계  
> 리메인 : 기획 및 디자인    

### 📌 주요 기능  
* MemberShip 기능  
  * 로그인  
  * 회원가입/회원탈퇴  
  * 회원 정보 수정  
  * ID/PWD 찾기  
* 기기 제어  
<img width="600px" src="./screen.png">
* 생체 신호 측정 및 분석  
<img width="600px" src="./screen2.png">
* 건강 상태 측정 내역(Calendar, Graph)  
* AS / 1대1 문의 신청  
* 음악 플레이어(백그라운드)


### Application 구조
<details><summary>ApplicationTree</summary>
   
```bash
├── README.md
├── android
│   ├── app
│   │   ├── build.gradle
│   │   └── src
│   │       ├── debug
│   │       │   └── AndroidManifest.xml
│   │       ├── main
│   │       │   ├── AndroidManifest.xml
│   │       │   ├── kotlin
│   │       │   │   └── com
│   │       │   │       └── example
│   │       │   │           └── smartrecliner_flutter
│   │       │   │               └── MainActivity.kt
│   │       │   └── res
│   │       │       ├── drawable
│   │       │       │   └── launch_background.xml
│   │       │       ├── drawable-v21
│   │       │       │   └── launch_background.xml
│   │       │       ├── mipmap-hdpi
│   │       │       │   └── ic_launcher.png
│   │       │       ├── mipmap-mdpi
│   │       │       │   └── ic_launcher.png
│   │       │       ├── mipmap-xhdpi
│   │       │       │   └── ic_launcher.png
│   │       │       ├── mipmap-xxhdpi
│   │       │       │   └── ic_launcher.png
│   │       │       ├── mipmap-xxxhdpi
│   │       │       │   └── ic_launcher.png
│   │       │       ├── values
│   │       │       │   └── styles.xml
│   │       │       └── values-night
│   │       │           └── styles.xml
│   │       └── profile
│   │           └── AndroidManifest.xml
│   ├── build.gradle
│   ├── gradle
│   │   └── wrapper
│   │       └── gradle-wrapper.properties
│   ├── gradle.properties
│   └── settings.gradle
├── images
│   ├── back_img.png
│   ├── banner1_img.png
│   ├── banner2_img.png
│   ├── ble_img.png
│   ├── blooddrop_black_img.png
│   ├── blooddrop_img.png
│   ├── body_controlseat_img.png
│   ├── breathe_mint_img.png
│   ├── check_img.png
│   ├── close_black_img.png
│   ├── close_img.png
│   ├── context_circle_img.png
│   ├── context_recten_img.png
│   ├── context_trialg_img.png
│   ├── directionsign_left_img.png
│   ├── directionsign_right_img.png
│   ├── down_direction_img.png
│   ├── dummy_profile.png
│   ├── graph_icon_black_img.png
│   ├── graph_icon_gray_img.png
│   ├── healthnodata_img.png
│   ├── heart_black_img.png
│   ├── heart_img.png
│   ├── heart_mint_img.png
│   ├── heartgrey_img.png
│   ├── heat_seat_grey_img.png
│   ├── heat_seat_img.png
│   ├── info_img.png
│   ├── jakomo_logo_img.png
│   ├── leg_controlseat_img.png
│   ├── list_black_img.png
│   ├── list_gray_img.png
│   ├── lying_img.png
│   ├── lying_white_img.png
│   ├── measure_next_history_img.png
│   ├── measure_previous_history_img.png
│   ├── menu_img.png
│   ├── mode_add_mint_img.png
│   ├── mode_list_mint_img.png
│   ├── playing_img.png
│   ├── plus_img.png
│   ├── point_grey_img.png
│   ├── point_img.png
│   ├── point_red_img.png
│   ├── point_yellow_img.png
│   ├── position_seat_grey_img.png
│   ├── position_seat_img.png
│   ├── progress_grey_img.png
│   ├── progress_original_img.png
│   ├── radial_scale.png
│   ├── remoter_img.png
│   ├── reset_grey_img.png
│   ├── reset_img.png
│   ├── result_mint_img.png
│   ├── rocking_seat_grey_img.png
│   ├── rocking_seat_img.png
│   ├── sit_img.png
│   ├── sit_white_img.png
│   ├── stress_black_img.png
│   ├── stress_img.png
│   ├── up_direction_img.png
│   ├── weight_black_img.png
│   └── weight_img.png
├── ios
│   ├── Flutter
│   │   ├── AppFrameworkInfo.plist
│   │   ├── Debug.xcconfig
│   │   └── Release.xcconfig
│   ├── Runner
│   │   ├── AppDelegate.swift
│   │   ├── Assets.xcassets
│   │   │   ├── AppIcon.appiconset
│   │   │   │   ├── Contents.json
│   │   │   │   ├── Icon-App-1024x1024@1x.png
│   │   │   │   ├── Icon-App-20x20@1x.png
│   │   │   │   ├── Icon-App-20x20@2x.png
│   │   │   │   ├── Icon-App-20x20@3x.png
│   │   │   │   ├── Icon-App-29x29@1x.png
│   │   │   │   ├── Icon-App-29x29@2x.png
│   │   │   │   ├── Icon-App-29x29@3x.png
│   │   │   │   ├── Icon-App-40x40@1x.png
│   │   │   │   ├── Icon-App-40x40@2x.png
│   │   │   │   ├── Icon-App-40x40@3x.png
│   │   │   │   ├── Icon-App-60x60@2x.png
│   │   │   │   ├── Icon-App-60x60@3x.png
│   │   │   │   ├── Icon-App-76x76@1x.png
│   │   │   │   ├── Icon-App-76x76@2x.png
│   │   │   │   └── Icon-App-83.5x83.5@2x.png
│   │   │   └── LaunchImage.imageset
│   │   │       ├── Contents.json
│   │   │       ├── LaunchImage.png
│   │   │       ├── LaunchImage@2x.png
│   │   │       ├── LaunchImage@3x.png
│   │   │       └── README.md
│   │   ├── Base.lproj
│   │   │   ├── LaunchScreen.storyboard
│   │   │   └── Main.storyboard
│   │   ├── Info.plist
│   │   └── Runner-Bridging-Header.h
│   ├── Runner.xcodeproj
│   │   ├── project.pbxproj
│   │   ├── project.xcworkspace
│   │   │   ├── contents.xcworkspacedata
│   │   │   └── xcshareddata
│   │   │       ├── IDEWorkspaceChecks.plist
│   │   │       └── WorkspaceSettings.xcsettings
│   │   └── xcshareddata
│   │       └── xcschemes
│   │           └── Runner.xcscheme
│   └── Runner.xcworkspace
│       ├── contents.xcworkspacedata
│       └── xcshareddata
│           ├── IDEWorkspaceChecks.plist
│           └── WorkspaceSettings.xcsettings
├── lib
│   ├── Api
│   │   ├── APIResultDto.dart
│   │   ├── ApiClient.dart
│   │   ├── ApiClient.g.dart
│   │   ├── ApiRawDto.dart
│   │   ├── ApiRawDto.g.dart
│   │   ├── DummyHistoryDto.dart
│   │   ├── DummyHistoryDto.g.dart
│   │   ├── HistoryAPI.dart
│   │   ├── HistoryAPI.g.dart
│   │   ├── HistoryApiResponse.dart
│   │   └── HistoryApiResponse.g.dart
│   ├── Banner
│   │   └── BannerUI.dart
│   ├── BleProvider.dart
│   ├── BleScan
│   │   └── BLEScanBlue.dart
│   ├── BottomUI.dart
│   ├── ChartGraph
│   │   ├── BloodPressureGraphUI.dart
│   │   ├── HistoryListUI.dart
│   │   └── ReclinerGraphUI.dart
│   ├── ContextMenu
│   │   └── ContextMenu.dart
│   ├── Control
│   │   ├── ControlAttributeUI.dart
│   │   ├── ControlHeatUI.dart
│   │   ├── ControlShakeUI.dart
│   │   ├── ControlUI.dart
│   │   ├── HeatMultiSwitch.dart
│   │   ├── HeatProvider.dart
│   │   ├── RemoteContolProvider.dart
│   │   ├── ShakeMultiSwitch.dart
│   │   └── ShakeProvider.dart
│   ├── Drawer
│   │   └── DrawerUI.dart
│   ├── Dto
│   │   └── MeasureResultDto.dart
│   ├── Health
│   │   ├── HealthItemUI.dart
│   │   └── HistoryHealthItemUI.dart
│   ├── History
│   │   ├── DummyHistory.dart
│   │   ├── History.dart
│   │   ├── HistoryBloodPressureGraphUI.dart
│   │   ├── HistoryDateController.dart
│   │   ├── HistoryGraphController.dart
│   │   ├── HistoryGraphUI.dart
│   │   ├── HistoryList.dart
│   │   ├── HistoryListItem.dart
│   │   ├── HistoryProvider2.dart
│   │   ├── NewHistoryGraphUI.dart
│   │   ├── NewHistoryProvider.dart
│   │   └── TestProvider.dart
│   ├── HistoryRestAPI
│   │   ├── ApiResultDto.dart
│   │   ├── ApiResultDto.g.dart
│   │   ├── HApi.dart
│   │   ├── HApi.g.dart
│   │   ├── HApiInfoDto.dart
│   │   ├── HApiInfoDto.g.dart
│   │   ├── HApiInsertDto.dart
│   │   ├── HApiInsertDto.g.dart
│   │   ├── HApiResultDto.dart
│   │   ├── HApiResultDto.g.dart
│   │   ├── OnlyUserEmailDto.dart
│   │   ├── OnlyUserEmailDto.g.dart
│   │   ├── UserEmailDto.dart
│   │   └── UserEmailDto.g.dart
│   ├── MainPage.dart
│   ├── Measure
│   │   ├── DetailResult.dart
│   │   ├── HistoryControlDate.dart
│   │   ├── HistoryProvider.dart
│   │   ├── HistroyControlGraph.dart
│   │   ├── Measure.dart
│   │   ├── MeasureGraphUI.dart
│   │   ├── MeasureHistory.dart
│   │   ├── MeasureResult.dart
│   │   ├── Measuring.dart
│   │   └── ProcessRawData.dart
│   ├── MemberShip
│   │   ├── MemberShipStart.dart
│   │   └── PatternAuth.dart
│   ├── Mode
│   │   ├── ModeDto.dart
│   │   └── ModeItemUI.dart
│   ├── Protocol
│   │   └── BleProtocol.dart
│   ├── SplashPage.dart
│   ├── UISupport
│   │   ├── AppbarUI.dart
│   │   ├── CustomDialogBox.dart
│   │   ├── ModeData.dart
│   │   ├── ReclinerColor.dart
│   │   └── ScreenUtilAPI.dart
│   └── main.dart
├── pubspec.lock
├── pubspec.yaml
└── test
    └── widget_test.dart
``` 
   
</details>
