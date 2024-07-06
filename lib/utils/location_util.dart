enum Location {
  defaultItem("default_item", en: "Default", ko:  "기본");

  const Location(this.code, {required this.en, required this.ko});
  final String code;
  final String en;
  final String ko;

  factory Location.getName(String code){
    return Location.values.firstWhere((value) => (value.code == code));
  }
}