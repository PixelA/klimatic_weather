// TODO Implement this library.
import 'dart:convert';

import 'package:flutter/material.dart';
import '../util/utils.dart' as util;
import 'dart:async';
import 'package:http/http.dart' as http;


class Klimatic extends StatefulWidget {
  @override
  _KlimaticState createState() => _KlimaticState();
}

class _KlimaticState extends State<Klimatic> {

  Future _goToNextScreen(BuildContext context) async {
    Map results = await Navigator.of(context).push(
      new MaterialPageRoute<Map>(builder: (BuildContext context) {
        return new ChangeCity();
      })
    );

  }

  void showStuff() async {
    Map data = await getWeather(util.apiId, util.defaultCity);
    print(data.toString());
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Klimatic Weather'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.menu),
              onPressed: () {
                _goToNextScreen(context);})
        ],
      ),
      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset('images/umbrella.png',
                width: 470.0,
                height: 1200.0,
                fit: BoxFit.fill,),
          ),
          new Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.fromLTRB(0.0, 10.9, 20.9, 0.0),
            child: new Text('Spokane',
              style: cityStyle(),),

          ),
          new Container(
              alignment: Alignment.center,
              child: new Image.asset('images/light_rain.png')

          ),
          //container that will hold weather data
          new Container(
            margin: const EdgeInsets.fromLTRB(30.0, 290.0, 0.0, 0.0),
            child: updateTempWidget("Miami"),
          )
        ],
      ),
    );
  }

  Future<Map> getWeather(String apiId, String city) async {
    String apiUrl = 'http://api.openweathermap.org/data/2.5/weather?q=$city&appid='
        '${util.apiId}&units=imperial';

    http.Response response = await http.get(apiUrl);

    return json.decode(response.body);
  }

  Widget updateTempWidget(String city) {
    return new FutureBuilder(
      future: getWeather(util.apiId, city),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
      //where we get all of the info for JSON data, and set up widgets etc,
          if (snapshot.hasData) {
              Map content = snapshot.data;
              return new Container(
                child: new Column(
                 children: <Widget>[
                  new ListTile(
                     title: new Text(content['main']['temp'].toString(),
                       style: new TextStyle(
                         fontStyle: FontStyle.normal,
                         fontSize: 49.9,
                         fontWeight: FontWeight.w500,
                         color: Colors.white
                       ),

                     ),
          )
                ],
        ),
       );
    }else {
            return new Container();
          }
            
    });
  }



}
class ChangeCity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.red,
        title: new Text('Change City'),
        centerTitle: true,
      ),

    body: new Stack(
      children: <Widget>[
        new Center(
          child: new Image.asset('images/white_snow.png',
            width: 490.0,
            height: 1200.0,
            fit: BoxFit.fill, ),
        )
      ],
    ),













    );
  }
}



TextStyle cityStyle() {
  return new TextStyle(
    color: Colors.white,
    fontSize: 22.9,
    fontStyle: FontStyle.italic,

  );
}

TextStyle tempStyle() {
  return new TextStyle(
    color: Colors.white,
    fontSize: 29.9,
    fontStyle: FontStyle.italic,

  );
}