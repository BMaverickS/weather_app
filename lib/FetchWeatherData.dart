import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather_app/WeatherModelData.dart';

class FetchWeatherData
{
  Future<weathermodeldata> fetchweather(String City) async
  {
    final res = await http.Client().get("https://api.openweathermap.org/data/2.5/weather?q=$City&APPID=43ea6baaad7663dc17637e22ee6f78f2");
    if (res.statusCode != 200)
    {
      throw Exception();
    }
    else
    {
      return parseddata(res.body);
    }
  }

  weathermodeldata parseddata(final resp)
  {
    final jsonDecoder = json.decode(resp);

    final  webweatherdata = jsonDecoder["main"];

    return weathermodeldata.fromJSON(webweatherdata);
  }
}