import 'package:covidinfo/charts-tab.dart';
import 'package:covidinfo/country_data_tab.dart';
import 'package:covidinfo/network_helper.dart';
import 'package:covidinfo/state-data.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NetworkHelper nh = NetworkHelper();
  bool fetchedData = false;
  int _tabIndex = 0;
  List<Widget> _navigationTabsList = [CountryData(), StatesData(), ChartsTab()];
  var box;

  @override
  void initState() {
    box = Hive.box('covidData');
    box.put('test01', 'this is hive test8');
    nh.getListOfAllData(nh.src2IndiaDataUrl).then((value) {
      nh.src2Map2CountryDataListWidHistory(value);
      _navigationTabsList = [
        CountryData(
          indiaDataList: nh.countryDataHistoryList,
          latestCountryData: nh.latestCountryData,
        ),
        StatesData(
          statesDataList: nh.statesDataList,
        ),
        ChartsTab(
          indiaDataList: nh.countryDataHistoryList.reversed.toList(),
          latestCountryData: nh.latestCountryData,
        )
      ];
      setState(() {
        fetchedData = true;
      });
    });
    checkFOrUpdates(context);
    super.initState();
  }

  Future<void> openHiveBox() async {
    final storageBox = await Hive.openBox('covidData');
    box = Hive.box('covidData');
  }

  checkFOrUpdates(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    List versionList = packageInfo.version.split(".");
    String version = versionList[0] + "." + versionList[1] + versionList[2];
    String buildNumber = packageInfo.buildNumber;
    String latestAvailableVersion = await nh.getLatestAppVersion();
    print(
        '${nh.versionMsg}  \n appName:$appName , packageName:$packageName , version:$version , latestVersion:$latestAvailableVersion buildNumber:$buildNumber');
//    > double.parse(version)
    bool updateAvailable =
        double.parse(latestAvailableVersion) > double.parse(version);
    if (updateAvailable) {
      Scaffold.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        elevation: 14.0,
        content: Text(
            "Verison ${nh.latestAppVersion}  Available. \n${nh.versionMsg}"),
        duration: Duration(seconds: 5),
        action: SnackBarAction(
          label: "Download",
          onPressed: () {
            launch(nh.appDownloadUrl);
          },
        ),
      ));
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return fetchedData
        ? DefaultTabController(
            key: _scaffoldKey,
            length: 3,
            initialIndex: 0,
            child: Scaffold(
//              appBar: AppBar(
//                title: Text('Covid'),
//                actions: <Widget>[
//                  Builder(
//                    builder: (context) => IconButton(
//                      icon: Icon(Icons.refresh),
//                      onPressed: () {
//                        Scaffold.of(context).showSnackBar(SnackBar(
//                          behavior: SnackBarBehavior.floating,
//                          elevation: 4.0,
//                          content: Text(
//                              "Verison ${nh.latestAppVersion}  Available. \n${nh.versionMsg}"),
//                          duration: Duration(seconds: 3),
//                          action: SnackBarAction(
//                            label: "Download",
//                            onPressed: () {
//                              launch(nh.appDownloadUrl);
//                            },
//                          ),
//                        ));
//                      },
//                    ),
//                  )
//                ],
//              ),
              bottomNavigationBar: TabBar(
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.home),
                  ),
                  Tab(
                    icon: Icon(Icons.supervisor_account),
                  ),
                  Tab(
                    icon: Icon(Icons.assessment),
                  ),
                ],
                labelColor: Colors.yellow,
                unselectedLabelColor: Colors.blue,
                indicatorColor: Colors.red,
              ),
              body: TabBarView(children: _navigationTabsList),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Covid'),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
