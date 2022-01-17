

import 'dart:developer';

class ProcessRawData {
  final double lPFCOEFFECG = 0.100;
  final double lPFCOEFFPPG = 0.300;
  final String tag = 'ProcessRawData';
//                        try {
//                             even_data = even_data - (GlobalDefines.Setting.LPF_COEFF_ECG * (even_data - temp_data));
//                             //api서버에 넘기기 위한 코드
//                             //여기서 에러 발생하는 듯
// //                            ecg_ppg_total_Data2.append(even_data).append(" ;");
//                             binder.getEcg_ppg_tData().append(even_data).append(" ;");
  double evenData = 0.0;
  double oddData = 0.0;
  List<double>? processRawInputData(List<int> inputData){
    try{
      List<double> dummyData = [];
      int idx = 0;
      for(int data in inputData){
        //짝수
        if(idx % 2 == 0){
          evenData = evenData - (lPFCOEFFECG * (evenData - data));
          dummyData.add(evenData);
          idx +=1;
        }
        //홀수
        else{
          oddData = oddData - (lPFCOEFFPPG * (oddData - data));
          dummyData.add(oddData);
          idx +=1;
        }
        return dummyData;
      }
    }catch(e){
      log('$e in processRawInputData', name: tag);
      return null;
    }
  }
}