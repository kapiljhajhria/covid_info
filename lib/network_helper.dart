import 'dart:convert';

import 'package:http/http.dart';

void main() async {
  NetworkHelper nHelper = NetworkHelper();

  nHelper.src2Map2CountryDataListWidHistory(
      await nHelper.getListOfAllData(nHelper.src2IndiaDataUrl));
  List casesList = [];

  nHelper.countryDataHistoryList
      .forEach((d) => casesList.add(d.totalConfirmed));
  print(casesList.reversed.join(","));
}

class NetworkHelper {
  String src1IndiaDataUrl = "http://covid19.soficoop.com/country/in";
  String src2IndiaDataUrl = "https://api.covid19india.org/data.json";
  String appUpdateUrl =
      "https://raw.githubusercontent.com/kapiljhajhria/public-jsons/master/covid-update.json";
  String appDownloadUrl =
      "https://drive.google.com/open?id=12TeFhUPxpIl1UR81ZbS8IW2MOs-CU2Im";
  List<CovidCountryData> countryDataHistoryList = [];
  List<CovidStateData> statesDataList = [];
  CovidStateData latestCountryData;
  String latestAppVersion;
  String versionMsg;

  Future<Map> getListOfAllData(String url) async {
    Client client = Client();
    Response response = await client.get(url);
    Map jsonMap = json.decode(response.body);
//    countryDataHistoryList=jsonMap['cases_time_series'];
//    statesDataList=jsonMap['statewise'];
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

  src2Map2CountryDataListWidHistory(Map jsonMap) {
    List countryDataList = jsonMap['cases_time_series'];
    List statesDataList = jsonMap['statewise'];
    List<CovidCountryData> resCountry = [];
    List<CovidStateData> resStates = [];

    for (int i = 0; i < statesDataList.length; i++) {
      Map item = statesDataList[i];
      CovidStateData tempData = CovidStateData(
        active: item['active'],
        confirmed: item['confirmed'],
        deaths: item['deaths'],
        deltaConfirmed: item['deltaconfirmed'],
        deltaDeaths: item['deltadeaths'],
        deltaRecovered: item['deltarecovered'],
        lastUpdatedTime: item['lastupdatedtime'],
        recovered: item['recovered'],
        state: item['state'],
        stateCode: item['statecode'],
        stateNotes: item['statnotes'],
      );
      if (i == 0)
        latestCountryData = tempData;
      else
        resStates.add(tempData);
    }

    for (int i = 0; i < countryDataList.length; i++) {
      Map element = countryDataList[i];
      resCountry.add(CovidCountryData(
        totalConfirmed: element['totalconfirmed'],
        totalDeceased: element['totaldeceased'],
        totalRecovered: element['totalrecovered'],
        dailyConfirmed: element['dailyconfirmed'],
        dailyDeceased: element['dailydeceased'],
        dailyRecovered: element['dailyrecovered'],
        ddmm: element['date'],
      ));
    }

    ///TODO: add latest data here at the state of country list
    this.countryDataHistoryList = List.from(resCountry.reversed);
    resStates.sort((a, b) => a.state.compareTo(b.state));
    this.statesDataList = List.from(resStates);
  }
}

class CovidCountryData {
  int dailyConfirmed;
  int dailyDeceased;
  int dailyRecovered;
  int totalConfirmed;
  int totalDeceased;
  int totalRecovered;
  String ddmm;

  CovidCountryData({
    String dailyConfirmed,
    String dailyDeceased,
    String dailyRecovered,
    String totalConfirmed,
    String totalDeceased,
    String totalRecovered,
    String ddmm,
  }) {
    this.dailyConfirmed = int.parse(dailyConfirmed);
    this.dailyDeceased = int.parse(dailyDeceased);
    this.dailyRecovered = int.parse(dailyRecovered);
    this.totalConfirmed = int.parse(totalConfirmed);
    this.totalDeceased = int.parse(totalDeceased);
    this.totalRecovered = int.parse(totalRecovered);
    this.ddmm = ddmm;
  }
}

class CovidStateData {
  int active;
  int confirmed;
  int deaths;
  int deltaConfirmed;
  int deltaDeaths;
  int deltaRecovered;
  int recovered;
  String state;
  String stateCode;
  String stateNotes;
  String lastUpdatedTime;

  CovidStateData({
    String active,
    String confirmed,
    String deaths,
    String deltaConfirmed,
    String deltaDeaths,
    String deltaRecovered,
    String recovered,
    String state,
    String stateCode,
    String stateNotes,
    String lastUpdatedTime,
  }) {
    this.active = int.parse(active);
    this.confirmed = int.parse(confirmed);
    this.deaths = int.parse(deaths);
    this.deltaConfirmed = int.parse(deltaConfirmed);
    this.deltaDeaths = int.parse(deltaDeaths);
    this.deltaRecovered = int.parse(deltaRecovered);
    this.recovered = int.parse(recovered);
    this.state = state;
    this.stateCode = stateCode;
    this.stateNotes = stateNotes;
    this.lastUpdatedTime = lastUpdatedTime;
  }
}
