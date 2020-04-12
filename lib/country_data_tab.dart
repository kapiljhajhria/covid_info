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
                            Container(
                              padding: EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                ),
                              ),

                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 15),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Column(
                                                  children: <Widget>[
                                                    Image.asset(
                                                      "assets/icons/total-infected.png",
                                                      height: 45,
                                                      width: 45,
                                                    ),
                                                    Text('Infected',style: TextStyle(color: Colors.black45),)
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                  child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        data.cases.toString(),
                                                        style: TextStyle(
                                                            fontSize: 22,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,),
                                                      )))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Column(
                                                  children: <Widget>[
                                                    Image.asset(
                                                      "assets/icons/recovered.png",
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text('cured',style: TextStyle(color: Colors.black45),)
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                  child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        data.recovered.toString(),
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                        ),
                                                      )))
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Column(
                                                  children: <Widget>[
                                                    Image.asset(
                                                      "assets/icons/deaths.png",
                                                      height: 40,
                                                      width: 40,
                                                    ),
                                                    Text('deaths',style: TextStyle(color: Colors.black45),)
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                  child: Container(
                                                      alignment:
                                                      Alignment.center,
                                                      child: Text(
                                                        data.deaths.toString(),
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                        ),
                                                      )))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Column(
                                              children: <Widget>[
                                                Image.asset(
                                                  "assets/icons/infected2.png",
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text('Infected',style: TextStyle(color: Colors.black45),)
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              child: Container(
                                                  alignment:
                                                  Alignment.center,
                                                  child: Text(
                                                    data.todayCases.toString(),
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                  )))
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(

                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Column(
                                              children: <Widget>[
                                                Image.asset(
                                                  "assets/icons/deaths.png",
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                Text('deaths',style: TextStyle(color: Colors.black45),)
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              child: Container(
                                                  alignment:
                                                  Alignment.center,
                                                  child: Text(
                                                    data.todayDeaths.toString(),
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                  )))
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
