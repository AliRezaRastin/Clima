import 'package:clima/components/details_widjets.dart';
import 'package:clima/components/erroe_message.dart';
import 'package:clima/components/loadingWidget.dart';
import 'package:clima/models/weatherModels.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/utilities/weather-icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
  LocationPermission? permission;
  double? latitute;
  WeatherModels? weatherModels;
  Weather weather=Weather();
  var weatherData;
   String? title,message;
  int code=0;
  double? longitute;
  bool isDataLoaded = false;
  bool isErrorOcured=false;
  void getPermission() async {
    permission = await geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await geolocatorPlatform.requestPermission();
      if (permission != LocationPermission.denied) {
        if (permission == LocationPermission.deniedForever) {
          print(
              "permission is denied for ever please go to the setting and then get permission for the appp for using it .");
          setState(() {
            isDataLoaded =true;
            isErrorOcured=true;
            title='permission is permanently denied ';
            message='please provide permission to the app from the device setting .';
          });
        } else {
          print("permission granted .");
          updateUi();
        }
      } else {
        print("user denied the permission .");
      }
      print("permission is denied ");
    } else {
      updateUi();
    }
  }

  void updateUi({String ?cityName}) async {
    weatherData=null;
    if(cityName==null|| cityName==''){
      if (!await geolocatorPlatform.isLocationServiceEnabled()){
        setState(() {
          isErrorOcured=true;
          isDataLoaded=true;
          title='Location is turned off ';
          message='please Enable the location service to see weather condition for your location. ';
          return;
        });
      }
      weatherData=await weather.getLocationWeather();
    }
    else{
      weatherData=await weather.getCityWeather(cityName);
    }

    if (weatherData==null){
      setState(() {
        title='city name not found ';
        message='please make sure that you enter a right city name ';
        isDataLoaded=true;
        isErrorOcured=true;
        return;
      });
    }
    code=weatherData['weather'][0]['id'];
    var lon = weatherData['coord']['lon'];
    weatherModels = WeatherModels(
      description: weatherData['weather'][0]['description'],
      location: weatherData['name'] + ', ' + weatherData['sys']['country'],
      temp: weatherData['main']['temp'],
      humidity: weatherData['main']['humidity'],
      feelsLike: weatherData['main']['feels_like'],
      wind: weatherData['wind']['speed'],
      icon: 'images/weather-icons/${getIcoonPrefix(code)}${kWeathreIcons[code.toString()]!['icon']}.svg',
    );


    setState(() {

      isDataLoaded=true;
      isErrorOcured=false;
    });
  }

  @override
  void initState() {
    super.initState();
    getPermission();
  }

  @override
  Widget build(BuildContext context) {
    if (!isDataLoaded) {
      return const LoadingWidjet();
    } else {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kOverLay,
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        onSubmitted: (String value) {
                          setState(() {
                            isDataLoaded=false;
                            updateUi(cityName: value);
                          });
                        },
                        decoration: kTextFieldDecoration,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isDataLoaded=false;
                            getPermission();
                            updateUi();
                          });


                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white12,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: Container(
                          height: 60,
                          child: const Row(
                            children: [
                              Text(
                                'My location ',
                                style: kTextFieldTextStyle,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Icon(
                                Icons.gps_fixed,
                                color: Colors.white60,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              isErrorOcured ? ErrorMesasge(title: title!, message: message!):
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_city,
                          color: KligtColor,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          weatherModels!.location!,
                          style: KlocationTextStyle,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SvgPicture.asset(
                      weatherModels!.icon!,
                      height: 280,
                      colorFilter: const ColorFilter.mode(KligtColor, BlendMode.srcIn),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      "   ${weatherModels!.temp!.round()}° ",
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherModels!.description!.toUpperCase(),
                      style: KlocationTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: kOverLay,
                  child: Container(
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DetailsWidjet(
                          title: 'FEELS LIKE ',
                          value: '${weatherModels!=null ?weatherModels!.feelsLike!.round():0}°',
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: VerticalDivider(
                            thickness: 1,
                          ),
                        ),
                        DetailsWidjet(
                          title: 'HUMIDITY',
                          value: '${weatherModels!=null ?weatherModels!.humidity!:0}%',
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: VerticalDivider(
                            thickness: 1,
                          ),
                        ),
                        DetailsWidjet(
                          title: 'WIND',
                          value: '${weatherModels!=null ?weatherModels!.wind!.round():0}',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
