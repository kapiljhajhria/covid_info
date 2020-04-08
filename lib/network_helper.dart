import 'dart:convert';
import 'package:http/http.dart';

void main() async {
  NetworkHelper nHelper = NetworkHelper();

  nHelper.convertMapListToObject(await nHelper.getListOfAllData());
  print(nHelper.allObjectsList.last.cases);
  print(nHelper.allObjectsList.last.todayCases);
  print(nHelper.allObjectsList.last.deaths);
  print(nHelper.allObjectsList.last.todayDeaths);
  print(nHelper.allObjectsList.last.recovered);
  print(nHelper.allObjectsList.last.active);
  print(nHelper.allObjectsList.last.critical);
  print(nHelper.allObjectsList.last.day);
}

class NetworkHelper {
  String url = "http://covid19.soficoop.com/country/in";
  List<IndiaCovidData> allObjectsList = [];

  Future<List> getListOfAllData() async {
    Client client = Client();
    Response response = await client.get(url);

    Map jsonMap = json.decode(response.body);
    print(jsonMap['snapshots'].last);
    return jsonMap['snapshots'];
  }

  convertMapListToObject(List mapsList) {
    List<IndiaCovidData> res = [];

    for(int i=0;i<mapsList.length;i++){
      Map element=mapsList[i];
      DateTime localTime = DateTime.parse(element['timestamp']).toLocal();
      String statsForDay = localTime.day.toString() +
          '/' +
          localTime.month.toString() +
          '/' +
          localTime.year.toString();

      res.add(IndiaCovidData(
          active: element['active'],
          cases: element['cases'],
          critical: element['critical'],
          deaths: element['deaths'],
          recovered: element['recovered'],
          todayCases: element['todayCases'],
          todayDeaths: element['todayDeaths'],
          day: statsForDay));

    }
    this.allObjectsList = List.from(res.reversed);
  }
}

class IndiaCovidData {
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int active;
  int critical;
  String day;

  IndiaCovidData(
      {this.todayCases,
      this.critical,
      this.todayDeaths,
      this.day,
      this.active,
      this.cases,
      this.deaths,
      this.recovered});
}
