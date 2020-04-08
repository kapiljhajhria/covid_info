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
  print(nHelper.allObjectsList.last.timestamp);
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
    mapsList.forEach((element) {
      DateTime localTime = DateTime.parse(element['timestamp'])
          .toLocal();
      String localTimeInHumanFormat=localTime.day.toString()+'/'+localTime.month.toString()+'/'+localTime.year.toString()+' '+localTime.hour.toString()+':'+localTime.minute.toString() ;

      res.add(IndiaCovidData(
          active: element['active'],
          cases: element['cases'],
          critical: element['critical'],
          deaths: element['deaths'],
          recovered: element['recovered'],
          todayCases: element['todayCases'],
          todayDeaths: element['todayDeaths'],
          timestamp: localTimeInHumanFormat));
    });
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
  String timestamp;

  IndiaCovidData(
      {this.todayCases,
      this.critical,
      this.todayDeaths,
      this.timestamp,
      this.active,
      this.cases,
      this.deaths,
      this.recovered});
}
