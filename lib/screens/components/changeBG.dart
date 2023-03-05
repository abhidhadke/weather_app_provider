
changeBg(int id, String icon){
  bool isDayTime = icon[2].startsWith('d');
  String rain = isDayTime ? 'rain_day.png' : 'rain_night.png';
  String clear = isDayTime ? 'clear_day.png' : 'clear_night.png';
  String cloud = isDayTime ? 'cloud_day.png' : 'cloud_night.png';
  String mist = isDayTime ? 'smoke_day.png' : 'smoke_night.png';
  String snow = isDayTime ? 'snow_day.png' : 'snow_night.png';

  if(200 <= id && id <= 232){
    return 'assets/wallpapers/$rain';
  }
  if(300 <= id && id <= 321){
    return 'assets/wallpapers/$rain';
  }
  if(500 <= id && id <= 531){
    return 'assets/wallpapers/$rain';
  }
  if(600 <= id && id <= 622){
    return 'assets/wallpapers/$snow';
  }
  if(701 <= id && id <= 781){
    return 'assets/wallpapers/$mist';
  }
  if(id == 800){
    return 'assets/wallpapers/$clear';
  }
  if(801 <= id && id <= 804){
    return 'assets/wallpapers/$cloud';
  }
  else{
    return 'assets/wallpapers/$cloud';
  }
}