enum SettingsData {
  seoul("seoul", en: "Seoul", ko: "서울특별시"),
  gangwon("seoul", en: "Gangwon", ko: "강원도"),
  gyeonggi("seoul", en: "Gyeonggi", ko: "경기도"),
  gyeongbuk("seoul", en: "Gyeongbuk", ko: "경상북도"),
  gyeongnam("seoul", en: "Gyeongnam", ko: "경상남도"),
  gwangju("seoul", en: "Gwangju", ko: "광주광역시"),
  daegu("seoul", en: "Daegu", ko: "대구광역시"),
  daejeon("seoul", en: "Daejeon", ko: "대전광역시"),
  busan("seoul", en: "Busan", ko: "부산광역시"),
  ulsan("seoul", en: "Ulsan", ko: "울산광역시"),
  incheon("seoul", en: "Incheon", ko: "인천광역시"),
  jeonbuk("seoul", en: "Jeonbuk", ko: "전라북도"),
  jeonnam("seoul", en: "Jeonnam", ko: "전라남도"),
  jeju("seoul", en: "Jeju", ko: "제주특별자치도"),
  chungbuk("seoul", en: "Chungbuk", ko: "충청북도"),
  chungnam("seoul", en: "Chungnam", ko: "충청남도"),
  custom("seoul", en: "Custom", ko: "직접 설정"),

  theme_circle("circle", en: "Circle Type", ko: "원형 타입"),
  theme_horse("horse", en: "Horse Type", ko: "말 타입");

  const SettingsData(this.code, {required this.en, required this.ko});
  final String code;
  final String en;
  final String ko;

  factory SettingsData.getName(String code){
    return SettingsData.values.firstWhere((value) => (value.code == code));
  }
}