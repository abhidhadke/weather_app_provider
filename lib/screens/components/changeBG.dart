
changeBg(String bg, Map data){
  bool isDayTime = data['icon'][2].startsWith('d');
  String rain = isDayTime ? 'rain_day.png' : 'rain_night.png';
  String haze = isDayTime ? 'haze_day.png' : 'haze_night.png';
  String clear = isDayTime ? 'clear_day.png' : 'clear_night.png';
  String cloud = isDayTime ? 'cloud_day.png' : 'cloud_night.png';
  String mist = isDayTime ? 'mist_day.png' : 'mist_night.png';
  String snow = isDayTime ? 'snow_day.png' : 'snow_night.png';
}