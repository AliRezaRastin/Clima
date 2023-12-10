import 'package:geolocator/geolocator.dart';

class Location {

  double? longitute;
  double? latitute;

  Future<void> getCurrentLocation ( )async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low
    );
  latitute=position.latitude;
  longitute=position.longitude;

  }



}