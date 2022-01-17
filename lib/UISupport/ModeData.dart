import 'package:smartrecliner_flutter/Mode/ModeDto.dart';

class ModeData{
  List<ModeDto> modeList = [
    ModeDto('낮잠모드', '오후에는\n잠이 쏟아져', null, '흔들 2', null, false),
    ModeDto('휴식모드', '아늑하고\n편하게', '60분', '흔들1', '온열1', false),
    ModeDto('사용자 추가 모드', '누워서\n핸드폰 볼 때', '60분', '흔들1', '온열1', false)
  ];
}