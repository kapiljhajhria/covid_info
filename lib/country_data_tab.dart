import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'network_helper.dart';

class CountryData extends StatefulWidget {
  @override
  _CountryDataState createState() => _CountryDataState();
}

class _CountryDataState extends State<CountryData> {
  NetworkHelper nh = NetworkHelper();
  bool fetchedData = false;

  @override
  void initState() {
//    Hive.openBox('covidData');
    var result = Hive.box('covidData').get('test01');
    print('Test Result: $result');
    nh.getListOfAllData().then((value) {
      nh.convertMapListToObject(value);
      setState(() {
        fetchedData = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return fetchedData
        ? RefreshIndicator(
            onRefresh: () async {
              print('Data refreshed');
              await Future.delayed(Duration(seconds: 5));
              return;
            },
            child: ListView.builder(
                itemCount: nh.allObjectsList.length,
                itemBuilder: (BuildContext context, int index) {
                  IndiaCovidData data = nh.allObjectsList[index];
                  return Container(
                    width: double.infinity,
                    height: 180,
                    child: Column(
                      children: <Widget>[
                        Text("Total Cases :" + data.cases.toString()),
                        Text("Cases Today :" + data.todayCases.toString()),
                        Text("Total Deaths :" + data.deaths.toString()),
                        Text("Deaths Today :" + data.todayDeaths.toString()),
                        Text("Recovered :" + data.recovered.toString()),
                        Text("Active Cases :" + data.active.toString()),
                        Text("Critical :" + data.critical.toString()),
                        Text("TimeStamp :" + data.day),
                      ],
                    ),
                  );
                }),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
