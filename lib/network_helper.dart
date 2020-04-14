import 'dart:convert';
import 'package:http/http.dart';

//void main() async {
//  NetworkHelper nHelper = NetworkHelper();
//
//  nHelper.src2Map2CountryDataListWidHistory(
//      await nHelper.getListOfAllData(nHelper.src2IndiaDataUrl));
//  print(nHelper.allObjectsList.last.cases);
//  print(nHelper.allObjectsList.last.todayCases);
//  print(nHelper.allObjectsList.last.deaths);
//  print(nHelper.allObjectsList.last.todayDeaths);
//  print(nHelper.allObjectsList.last.recovered);
//  nHelper.getLatestAppVersion();
//}

class NetworkHelper {
  String src1IndiaDataUrl = "http://covid19.soficoop.com/country/in";
  String src2IndiaDataUrl = "https://api.covid19india.org/data.json";
  String appUpdateUrl =
      "https://raw.githubusercontent.com/kapiljhajhria/public-jsons/master/covid-update.json";
  String appDownloadUrl =
      "https://drive.google.com/open?id=12TeFhUPxpIl1UR81ZbS8IW2MOs-CU2Im";
  List<CovidData> allObjectsList = [];
  String latestAppVersion;
  String versionMsg;

  Future<Map> getListOfAllData(String url) async {
    Client client = Client();
    Response response = await client.get(url);
    Map jsonMap = json.decode(response.body);
    return jsonMap;
  }

  Future<String> getLatestAppVersion() async {
    Client client = Client();
    Response response = await client.get(appUpdateUrl);
    Map jsonMap = json.decode(response.body);
    print(jsonMap);
    latestAppVersion = jsonMap['version'].toString();
    versionMsg = jsonMap['msg'];
    return latestAppVersion;
  }

  src1Map2CountryDataListWidHistory(Map jsonMap) {
    List mapsList = jsonMap['snapshots'];
    List<CovidData> res = [];

    for (int i = 0; i < mapsList.length; i++) {
      Map element = mapsList[i];
      if (i == mapsList.length - 1) {
        res.add(CovidData(
          active: element['active'],
          cases: element['cases'],
          critical: element['critical'],
          deaths: element['deaths'],
          recovered: element['recovered'],
          todayCases: element['todayCases'],
          todayDeaths: element['todayDeaths'],
          ddmm:
              "${DateTime.parse(element['timestamp']).day}/${DateTime.parse(element['timestamp']).month}",
        ));
      } else if (DateTime.parse(mapsList[i]['timestamp']).toLocal().day !=
          DateTime.parse(mapsList[i + 1]['timestamp']).toLocal().day) {
        print(
            "adding data for day;${DateTime.parse(element['timestamp']).toLocal().day}");
        res.add(CovidData(
          active: element['active'],
          cases: element['cases'],
          critical: element['critical'],
          deaths: element['deaths'],
          recovered: element['recovered'],
          todayCases: element['todayCases'],
          todayDeaths: element['todayDeaths'],
          ddmm:
              "${DateTime.parse(element['timestamp']).day}/${DateTime.parse(element['timestamp']).month}",
        ));
      }
    }
    //only include one item per day

    this.allObjectsList = List.from(res.reversed);
  }

  src2Map2CountryDataListWidHistory(Map jsonMap) {
    List mapsList = jsonMap['cases_time_series'];
    List<CovidData> res = [];

    for (int i = 0; i < mapsList.length; i++) {
      Map element = mapsList[i];
      res.add(CovidData(
        cases: int.parse(element['totalconfirmed']),
        deaths: int.parse(element['totaldeceased']),
        recovered: int.parse(element['totalrecovered']),
        todayCases: int.parse(element['dailyconfirmed']),
        todayDeaths: int.parse(element['dailydeceased']),
        ddmm: element['date'],
      ));
    }

    this.allObjectsList = List.from(res.reversed);
  }
}

class CovidData {
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int active;
  int critical;
  String ddmm;

  CovidData({
    int cases,
    int todayCases,
    int deaths,
    int todayDeaths,
    int recovered,
    int active,
    int critical,
    String ddmm,
  }) {
    this.todayCases = todayCases;
    this.critical = critical;
    this.todayDeaths = todayDeaths;
    this.active = active;
    this.cases = cases;
    this.deaths = deaths;
    this.recovered = recovered;
    this.ddmm = ddmm;
  }
}
