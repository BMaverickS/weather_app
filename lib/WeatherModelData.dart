class weathermodeldata
{
  final tempnow;
  final tpres;
  final thumid;
  final tmax;
  final tmin;

  double get gettempnow => tempnow - 272.5;
  double get gettmaxnow => tmax - 272.5;
  double get gettminnow => tmin - 272.5;
  int get gethumid => thumid;
  int get getpress => tpres;

  weathermodeldata(this.tempnow, this.tpres, this.thumid, this.tmax, this.tmin);

  factory weathermodeldata.fromJSON(Map<String, dynamic> json)
  {
    return weathermodeldata
    (
      json["temp"],
      json["pressure"],
      json["humidity"],
      json["temp_max"],
      json["temp_min"]
    );
  }
}