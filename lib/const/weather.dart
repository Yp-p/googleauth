class WeatherModel {
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'ရာသီဉတု အနည်းငယ်ပူနေပါတယ်။\n 🍦  စားပြီး ခရီးသွားလိုက်ပါ။';
    } else if (temp > 20) {
      return 'ပုံမှန် ရာသီတုအခြေအနေဖြစ်ပါတယ်။ \n ပျော်ရွှင်သော ခရီးစဉ်ဖြစ်ပါစေ။';
    } else if (temp < 10) {
      return 'ရာသီဉတု အရမ်းအေးသည်။\n 🧣 နှင့် 🧤 ကို ယူသွားပါ';
    } else {
      return 'ရာသီဉတုအေးသည်။ \n 🧥  ကို ယူသွားပါ';
    }
  }
}
