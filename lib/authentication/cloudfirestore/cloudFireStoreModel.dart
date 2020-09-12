import 'package:flutter/material.dart';

class CloudFireStoreModel {
  final String question;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final String correctAnswer;

  CloudFireStoreModel(
      {this.question,
      this.option1,
      this.option2,
      this.option3,
      this.option4,
      this.correctAnswer});

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'option1': option1,
      'option2': option2,
      'option3': option3,
      'option4': option4,
      'correctAnswer': correctAnswer
    };
  }
}

List cloudList = [
  CloudFireStoreModel(
    question: 'မြန်မာနိုင်ငံ၏မြို့တော် အမည်ကိုရွေးပါ၊',
    option1: 'ရန်ကုန်မြို့',
    option2: 'မန္တလေးမြို့',
    option3: 'နေပြည်တော်',
    option4: 'ပုဂံမြို့',
    correctAnswer: 'နေပြည်တော်'
  ),
  CloudFireStoreModel(
      question: 'မင်းကွန်းခေါင်းလောင်း၏ အလေချိန်မှာ ပိဿချိန်-',
      option1: '၅၅၅၅၅',
      option2: '၅၅၅၅၅၅',
      option3: '၅၅၅၅၅၅၅',
      option4: '၅၅၅၅',
      correctAnswer: '၅၅၅၅၅'
  ),
  CloudFireStoreModel(
      question: 'အလောင်းဘုရား နန်းတည်ခဲ့သော ရွှေဘိုမြို့သည် မည်သည့် တိုင်းဒေသကြီး/ပြည်နယ်တွင်တည်ရှိသနည်း။',
      option1: 'ရှမ်းပြည်နယ်',
      option2: 'မန္တလေးတိုင်းဒေသကြီး',
      option3: 'ပဲခူးတိုင်းဒေသကြီး',
      option4: 'စစ်ကိုင်းတိုင်းဒေသကြီး',
      correctAnswer: 'စစ်ကိုင်းတိုင်းဒေသကြီး'
  ),
  CloudFireStoreModel(
      question: 'တောင်ငူမြို့ကို တည်ထောင်သူမှာ မည်သူဖြစ်သနည်း။',
      option1: 'တပင်ရွှေထီး',
      option2: 'ဘုရင်နောင်',
      option3: 'မင်းကြီးညို',
      option4: 'ရွှေဘို',
      correctAnswer: 'မင်းကြီးညို'
  ),
  CloudFireStoreModel(
      question: 'တောင်ငူမြို့ကို ရှေးအခါက မည်သို့ခေါ်ဆိုခဲ့သနည်း။',
      option1: 'ရတနာသိဃ',
      option2: 'ပုဂံ',
      option3: 'ကမ္ဘောဇ',
      option4: 'ကေတုမတီ',
      correctAnswer: 'ကေတုမတီ'
  ),

  CloudFireStoreModel(
      question: 'တောင်ငူမြို့ကို ရှေးအခါက မည်သို့ခေါ်ဆိုခဲ့သနည်း။',
      option1: 'ရတနာသိဃ',
      option2: 'ပုဂံ',
      option3: 'ကမ္ဘောဇ',
      option4: 'ကေတုမတီ',
      correctAnswer: 'ကေတုမတီ'
  ),
  CloudFireStoreModel(
      question: 'ဟံသာ၀တီမြို့ကို ယခုအခါမည်သို့ခေါ်ဆိုသနည်း',
      option1: 'ပုသိမ်မြို့',
      option2: 'မြဝတီမြို့',
      option3: 'ပြည်မြို့',
      option4: 'တောင်ငူမြို့',
      correctAnswer: 'ပြည်မြို့'
  ),
  CloudFireStoreModel(
      question: 'ကျိုက်ရိုးစေတီတော် တည်ရှိသော မြို့မှာ - ',
      option1: 'ကျိုက်ထိုမြို့',
      option2: 'ကျိုက်ထော်မြို့',
      option3: 'သက္ကလမြို့',
      option4: 'မော်လမြိုင်မြို့',
      correctAnswer: 'ကျိုက်ထိုမြို့'
  ),
  CloudFireStoreModel(
      question: 'မြန်မာနိုင်ငံ၏ စီးပွားရေးမြို့တော်မှာ - ',
      option1: 'မန္တလေးမြို့',
      option2: 'နေပြည်တော်',
      option3: 'ပုဂံမြို့',
      option4: 'ရန်ကုန်မြို့',
      correctAnswer: 'ရန်ကုန်မြို့'
  ),
  CloudFireStoreModel(
      question: 'ဖောင်တော်ဦးဘုရား တည်ရှိသောမြို့မှာ',
      option1: 'မန္တလေးမြို့',
      option2: 'ညောင်ရွှေမြို့နယ်',
      option3: 'ပုဂံမြို့',
      option4: 'ရန်ကုန်မြို့',
      correctAnswer: 'ညောင်ရွှေမြို့နယ်'
  ),


];
