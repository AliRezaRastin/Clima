
import 'dart:convert';
import 'package:clima/screens/home.dart';
import 'package:clima/utilities/constants.dart';
import 'package:http/http.dart' as http;


class NetHelper {
  String  url;
  NetHelper(this.url);
  Future getData()async {
    http.Response response= await http.get(Uri.parse(url));
    if (response.statusCode==200){
      String data=response.body;

      return jsonDecode(data);

    }
    else{
      print(response.statusCode);
    }


  }



}