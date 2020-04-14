import 'package:covidinfo/charts-tab.dart';
import 'package:covidinfo/country_data_tab.dart';
import 'package:covidinfo/network_helper.dart';
import 'package:covidinfo/state-data.dart';
import 'package:flushbar/flushbar.dart';
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
          indiaDataList: nh.allObjectsList,
        ),
        StatesData(),
        ChartsTab(indiaDataList: nh.allObjectsList.reversed.toList())
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
      Flushbar(
        flushbarPosition: FlushbarPosition.BOTTOM,
        flushbarStyle: FlushbarStyle.FLOATING,
        reverseAnimationCurve: Curves.decelerate,
        forwardAnimationCurve: Curves.elasticOut,
        backgroundColor: Colors.red,
        boxShadows: [
          BoxShadow(
              color: Colors.blue[800],
              offset: Offset(0.0, 2.0),
              blurRadius: 3.0)
        ],
        backgroundGradient:
            LinearGradient(colors: [Colors.blueGrey, Colors.black]),
        isDismissible: false,
        duration: Duration(seconds: 4),
        icon: Icon(
          Icons.update,
          color: Colors.greenAccent,
        ),
        mainButton: FlatButton(
          onPressed: () {
            launch(nh.appDownloadUrl);
          },
          child: Text(
            "Download",
            style: TextStyle(color: Colors.amber),
          ),
        ),
        showProgressIndicator: true,
        progressIndicatorBackgroundColor: Colors.blueGrey,
        titleText: Text(
          "Update Available",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.yellow[600],
              fontFamily: "ShadowsIntoLightTwo"),
        ),
        messageText: Text(
          "Verison ${nh.latestAppVersion}  Available. \n ${nh.versionMsg}",
          style: TextStyle(
              fontSize: 18.0,
              color: Colors.green,
              fontFamily: "ShadowsIntoLightTwo"),
        ),
      )..show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return fetchedData
        ? DefaultTabController(
            length: 3,
            initialIndex: 0,
            child: Scaffold(
              appBar: AppBar(
                title: Text('Covid'),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {},
                  )
                ],
              ),
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
