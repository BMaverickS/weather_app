import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/FetchWeatherData.dart';
import 'package:weather_app/WeatherModelData.dart';

class eventhandler extends Equatable
{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Fetchdata extends eventhandler
{
  final cityname;
  Fetchdata(this.cityname);

  @override
  // TODO: implement props
  List<Object> get props => [cityname];
}

class resetsearch extends eventhandler
{

}

class statehandler extends Equatable
{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class notsearch extends statehandler
{

}

class loading extends statehandler
{

}

class loaded extends statehandler
{
  final wdata;

  loaded(this.wdata);
  weathermodeldata get getweatherdata => wdata;

  @override
  // TODO: implement props
  List<Object> get props => [wdata];
}

class notloaded extends statehandler
{

}

class blochandler extends Bloc<eventhandler, statehandler>
{
  FetchWeatherData fetchWeatherData;
  blochandler(this.fetchWeatherData);

  @override
  // TODO: implement initialState
  statehandler get initialState => notsearch();

  @override
  Stream<statehandler> mapEventToState(eventhandler event) async* {
    // TODO: implement mapEventToState
    if (event is Fetchdata)
    {
      yield loading();

      try
      {
        weathermodeldata wmodel = await fetchWeatherData.fetchweather(event.cityname);

        yield loaded(wmodel);
      }
      catch (_)
      {
        yield notloaded();
      }
    }
    else if (event is resetsearch)
    {
      yield notsearch();
    }
  }
  
}
