enum SettingsDataLocation {
  seoul("seoul", en: "Seoul", ko: "서울특별시"),
  gangwon("gangwon", en: "Gangwon", ko: "강원도"),
  gyeonggi("gyeonggi", en: "Gyeonggi", ko: "경기도"),
  gyeongbuk("gyeongbuk", en: "Gyeongbuk", ko: "경상북도"),
  gyeongnam("gyeongnam", en: "Gyeongnam", ko: "경상남도"),
  gwangju("gwangju", en: "Gwangju", ko: "광주광역시"),
  daegu("daegu", en: "Daegu", ko: "대구광역시"),
  daejeon("daejeon", en: "Daejeon", ko: "대전광역시"),
  busan("busan", en: "Busan", ko: "부산광역시"),
  ulsan("ulsan", en: "Ulsan", ko: "울산광역시"),
  incheon("incheon", en: "Incheon", ko: "인천광역시"),
  jeonbuk("jeonbuk", en: "Jeonbuk", ko: "전라북도"),
  jeonnam("jeonnam", en: "Jeonnam", ko: "전라남도"),
  jeju("jeju", en: "Jeju", ko: "제주특별자치도"),
  chungbuk("chungbuk", en: "Chungbuk", ko: "충청북도"),
  chungnam("chungnam", en: "Chungnam", ko: "충청남도"),
  custom("custom", en: "Custom", ko: "직접 설정");

  const SettingsDataLocation(this.code, {required this.en, required this.ko});
  final String code;
  final String en;
  final String ko;

  factory SettingsDataLocation.getName(String code){
    return SettingsDataLocation.values.firstWhere((value) => (value.code == code));
  }
}

enum SettingsDataTheme {
  circle("circle", en: "Circle Type", ko: "원형 타입"),
  horse("horse", en: "Horse Type", ko: "말 타입");

  const SettingsDataTheme(this.code, {required this.en, required this.ko});
  final String code;
  final String en;
  final String ko;

  factory SettingsDataTheme.getName(String code){
    return SettingsDataTheme.values.firstWhere((value) => (value.code == code));
  }
}

