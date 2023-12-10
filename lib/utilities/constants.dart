import 'package:flutter/material.dart';

const Kapikey='d66b92f23117bf7c8cc3ab9abba3f119';
const KligtColor=Colors.white;
const KligthColorText=Colors.white60;
const KDarkColor=Colors.white24;
const String KOPWMbaseUrl='https://api.openweathermap.org/data/2.5/weather';
const kTextFieldDecoration=InputDecoration(
  fillColor: kOverLay,
  filled: true,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide.none,
  ),
  hintText:'Enter city name :',
  hintStyle: kTextFieldTextStyle,
  prefixIcon:Icon(Icons.search),
);
const kOverLay =Colors.white10;
const kTextFieldTextStyle =TextStyle(
fontSize: 16,
color: KligtColor,
);
const KlocationTextStyle =TextStyle(
  fontSize: 20,
  color: KligtColor,
);

const kTempTextStyle=TextStyle(
  fontSize: 80,
  color: KligtColor,
);
const kDetailsTextStyle=TextStyle(
  fontSize: 20,
  color: KligtColor,
  fontWeight: FontWeight.bold,
);

const KTitalTextStyle=TextStyle(
  fontSize: 16,
  color:KDarkColor,
);
const kDetilsSufix=TextStyle(
  fontSize: 12,
  color: KligtColor,
);