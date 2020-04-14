import 'dart:convert';

import 'package:http/http.dart';
import 'package:package_info/package_info.dart';

void main() async {
  NetworkHelper nHelper = NetworkHelper();

  nHelper.convertMapListToObject(await nHelper.getListOfAllData());
//  print(nHelper.allObjectsList.last.cases);
//  print(nHelper.allObjectsList.last.todayCases);
//  print(nHelper.allObjectsList.last.deaths);
//  print(nHelper.allObjectsList.last.todayDeaths);
//  print(nHelper.allObjectsList.last.recovered);
//  print(nHelper.allObjectsList.last.active);
//  print(nHelper.allObjectsList.last.critical);
//  print(nHelper.allObjectsList.last.day);
}

class NetworkHelper {
  String url = "http://covid19.soficoop.com/country/in";
  String appUpdateUrl =
      "https://raw.githubusercontent.com/kapiljhajhria/covid_info/master/lib/updates-info.json";
  String appDownloadUrl =
      "https://drive.google.com/open?id=12TeFhUPxpIl1UR81ZbS8IW2MOs-CU2Im";
  List<IndiaCovidData> allObjectsList = [];
  String versionAvailable;

  Future<List> getListOfAllData() async {
    Client client = Client();
    Response response = await client.get(url);

    Map jsonMap = json.decode(response.body);
    print(jsonMap['snapshots'].last);
    return jsonMap['snapshots'];
  }

  Future<bool> checkForUpdates() async {
    versionAvailable = "";
    Client client = Client();
    Response response = await client.get(appUpdateUrl);
    Map jsonMap = json.decode(response.body);
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    List versionList = packageInfo.version.split(".");
    String version = versionList[0] + "." + versionList[1] + versionList[2];
    String buildNumber = packageInfo.buildNumber;

    ///TODO: do the same for latest version as well
    double latestVersion = jsonMap['version'];
    versionAvailable = latestVersion.toString();
    print(
        'appName:$appName , packageName:$packageName , version:$version , latestVersion:$latestVersion buildNumber:$buildNumber');
    return jsonMap['version'] > double.parse(version);
  }

  convertMapListToObject(List mapsList) {
    List<IndiaCovidData> res = [];

    for (int i = 0; i < mapsList.length; i++) {
      Map element = mapsList[i];
      DateTime localTime = DateTime.parse(element['timestamp']).toLocal();
      String statsForDay = localTime.day.toString() +
          '/' +
          localTime.month.toString() +
          '/' +
          localTime.year.toString();
      if (i == mapsList.length - 1) {
        res.add(IndiaCovidData(
            active: element['active'],
            cases: element['cases'],
            critical: element['critical'],
            deaths: element['deaths'],
            recovered: element['recovered'],
            todayCases: element['todayCases'],
            todayDeaths: element['todayDeaths'],
            day: statsForDay,
            localTime: localTime));
      } else if (DateTime.parse(mapsList[i]['timestamp']).toLocal().day !=
          DateTime.parse(mapsList[i + 1]['timestamp']).toLocal().day) {
        print(
            "adding data for day;${DateTime.parse(mapsList[i]['timestamp']).toLocal().day}");
        res.add(IndiaCovidData(
            active: element['active'],
            cases: element['cases'],
            critical: element['critical'],
            deaths: element['deaths'],
            recovered: element['recovered'],
            todayCases: element['todayCases'],
            todayDeaths: element['todayDeaths'],
            day: statsForDay,
            localTime: localTime));
      }
    }
    //only include one item per day

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
  DateTime localTime;

  IndiaCovidData(
      {this.todayCases,
      this.critical,
      this.todayDeaths,
      this.day,
      this.active,
      this.cases,
      this.deaths,
      this.recovered,
      this.localTime});
}
