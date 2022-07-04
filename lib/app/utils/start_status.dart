class StartStatus {
  final bool isSwitchedOnOff;
  final bool isSwitchedAutoMode;
  final int colorR;
  final int colorG;
  final int colorB;

  const StartStatus(
      {required this.isSwitchedOnOff,
      required this.isSwitchedAutoMode,
      required this.colorR,
      required this.colorG,
      required this.colorB});

  factory StartStatus.fromJson(Map<String, dynamic> parsedJson) {
    return StartStatus(
        isSwitchedOnOff: parsedJson['payload']['isEnabled'] == 1 ? true : false,
        isSwitchedAutoMode:
            parsedJson['payload']['autoMode'] == 1 ? true : false,
        colorR: int.parse(parsedJson['payload']['R'].replaceAll("^0+", "")),
        colorG: int.parse(parsedJson['payload']['G'].replaceAll("^0+", "")),
        colorB: int.parse(parsedJson['payload']['B'].replaceAll("^0+", "")));
  }
}
