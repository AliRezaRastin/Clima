

import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/constants.dart';

class Weather {

 Future<dynamic> getLocationWeather() async{

      Location location = Location();
      await location.getCurrentLocation();
      NetHelper netHelper = NetHelper(
          "${KOPWMbaseUrl}?units=metric&lat=${location.latitute}&lon=${location.longitute}&appid=$Kapikey");
        return await netHelper.getData();
  }



  Future<dynamic>getCityWeather(String cityName)async{
   NetHelper netHelper=NetHelper('$KOPWMbaseUrl?q=$cityName&units=metric&appid=${Kapikey}');
   var weatherData=await netHelper.getData();
   return weatherData;


  }

}