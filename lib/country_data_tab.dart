import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'network_helper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  Widget cardsRow(String label, String data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(
            data,
            style: TextStyle(fontSize: 18),
          ),
          alignment: Alignment.center,
        )
      ],
    );
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
                shrinkWrap: true,
                itemCount: nh.allObjectsList.length,
                itemBuilder: (BuildContext context, int index) {
                  IndiaCovidData data = nh.allObjectsList[index];
                  return Container(
                    margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: Card(
                      margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                      borderOnForeground: true,
                      shadowColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
                        child: Column(
                          children: <Widget>[

                            cardsRow("Total Cases :", data.cases.toString()),
                            cardsRow(
                                "Cases Today :", data.todayCases.toString()),
                            cardsRow("Total Deaths :", data.deaths.toString()),
                            cardsRow(
                                "Deaths Today :", data.todayDeaths.toString()),
                            cardsRow("Recovered :", data.recovered.toString()),
                            cardsRow("Active Cases :", data.active.toString()),
                            cardsRow("Critical :", data.critical.toString()),
                            cardsRow("TimeStamp :", data.day),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
