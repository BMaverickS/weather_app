import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/FetchWeatherData.dart';
import 'package:weather_app/WeatherModelData.dart';
import 'package:weather_app/WeatherView.dart';
import '';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[700],
        body: BlocProvider(
          builder: (context) => blochandler(FetchWeatherData()),
          child: HomePage(),
        ),
      )
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class showWdata extends StatelessWidget
{
  weathermodeldata weathermodel;
  final cityname;

  showWdata(this.weathermodel, this.cityname);

  @override
  Widget build(BuildContext context)
  {
    return Container(
      padding: EdgeInsets.only(right: 30, left: 30, top: 10),
      child: Column(
        children: <Widget>[
          Text(cityname, style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),

          Text(weathermodel.gettempnow.floor().toString() + " C", style: TextStyle(color: Colors.white, fontSize: 50),),
          Text("Temperature", style: TextStyle(color: Colors.white, fontSize: 14),),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 20),),
                  Text(weathermodel.gettmaxnow.floor().toString() + " C", style: TextStyle(color: Colors.white, fontSize: 30),),
                  Text("Max Temperature", style: TextStyle(color: Colors.white, fontSize: 14),)
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 20),),
                  Text(weathermodel.gettminnow.floor().toString() + " C", style: TextStyle(color: Colors.white, fontSize: 30),),
                  Text("Min Temperature", style: TextStyle(color: Colors.white, fontSize: 14),)
                ],
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 20),),
                  Text(weathermodel.getpress.toString() + " mb", style: TextStyle(color: Colors.white, fontSize: 30),),
                  Text("Pressure", style: TextStyle(color: Colors.white, fontSize: 14),)
                ],
              ),

              Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 20),),
                  Text(weathermodel.gethumid.toString() + " %  ", style: TextStyle(color: Colors.white, fontSize: 30),),
                  Text("Humidity     ", style: TextStyle(color: Colors.white, fontSize: 14),)
                ],
              ),
            ],
          ),

          SizedBox(
            height: 20,
          ),

          Container(
            width: double.infinity,
            height: 70,
            padding: EdgeInsets.only(top: 20),
            child: FlatButton(
              shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
              onPressed: (){
                BlocProvider.of<blochandler>(context).add(resetsearch());
              },

              color: Colors.lightBlue,
              child: Text("SEARCH", style: TextStyle(color: Colors.white, fontSize: 20),),

            ),
          )

        ],
      ),
    );
  }
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final Blochandler = BlocProvider.of<blochandler>(context);
    var City = TextEditingController();

    return Column
    (
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /*
       Center(
         child: Container,
          Child
       )*/
        BlocBuilder<blochandler, statehandler>
          (
            builder: (context, state) {
              if (state is notsearch) { //show view to screen
                return Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: <Widget>[
                      Text("Search Weather Data", style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500, color: Colors.white),),
                      SizedBox(height: 25,),
                      TextFormField(
                        controller: City,

                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search, color: Colors.white,),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.white, style: BorderStyle.solid)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.blue, style: BorderStyle.solid)),

                          hintText: "City/Country/Continent Name",
                          hintStyle: TextStyle(color: Colors.white, fontSize: 20),

                        ),
                        style: TextStyle(color: Colors.white, fontSize: 20),

                      ),

                      SizedBox(height: 25,),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))),
                          onPressed: () {
                            Blochandler.add(Fetchdata(City.text));
                          },
                          color: Colors.lightBlue,
                          child: Text("SEARCH", style: TextStyle(color: Colors.white, fontSize: 20),),

                        ),
                      )

                    ],
                  ),
                );
              }
              else if (state is loading) {
                return Center(child: CircularProgressIndicator());
              }
              else if (state is loaded) {
                return showWdata(state.getweatherdata, City.text);
              }
              else
              {
                //return Text("Error, search box can not be empty !", style: TextStyle(color: Colors.red, fontSize: 30),);
                return Container(
                  padding: EdgeInsets.only(right: 30, left: 30, top: 10),
                  child: Column(
                    children: <Widget>[
                      Text("Error, search box can't be empty or city not found", style: TextStyle(color: Colors.red, fontSize: 30),),
                      Container(
                        padding: EdgeInsets.only(top: 30),
                        width: double.infinity,
                        height: 80,
                        child: FlatButton(
                          shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          onPressed: (){
                            BlocProvider.of<blochandler>(context).add(resetsearch());
                          },

                          color: Colors.lightBlue,
                          child: Text("BACK", style: TextStyle(color: Colors.white, fontSize: 20),),

                        ),
                      )

                    ],
                  ),
                );
              }

            }
        )
      ],
    );
  }
}
