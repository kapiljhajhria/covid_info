import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';

import 'network_helper.dart';

class CountryData extends StatefulWidget {
  List<CovidCountryData> indiaDataList;
  CovidStateData latestCountryData;

  CountryData({Key key, this.indiaDataList, this.latestCountryData})
      : super(key: key);

  @override
  _CountryDataState createState() => _CountryDataState();
}

class _CountryDataState extends State<CountryData> {
  List<CovidCountryData> allObjectsList = [];
  CovidStateData latestCountryData;

  @override
  void initState() {
    allObjectsList = widget.indiaDataList;
    latestCountryData = widget.latestCountryData;
    var result = Hive.box('covidData').get('test01');
    print('Test Result: $result');

    super.initState();
  }

  DraggableScrollableSheet _buildDraggableScrollableSheet() {
    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.4,
      maxChildSize: 0.8,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Scrollbar(
            child: ListView.builder(
                controller: scrollController,
                shrinkWrap: true,
                itemCount: allObjectsList.length,
                itemBuilder: (BuildContext context, int index) {
                  CovidCountryData data = allObjectsList[index];
                  return Container(
                    margin: EdgeInsets.fromLTRB(8, 5, 5, 0),
                    child: Card(
                      borderOnForeground: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_today,
                                            color: Color.fromARGB(
                                                120, 11, 126, 255),
                                          ),
                                          Container(
                                            margin:
                                                EdgeInsets.fromLTRB(5, 0, 0, 0),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 4, horizontal: 6),
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    120, 11, 126, 255),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(3))),
                                            child: Text(data.ddmm),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        padding: EdgeInsets.all(0),
                                        icon: Icon(
                                          FontAwesomeIcons.solidChartBar,
                                          color:
                                              Color.fromARGB(120, 11, 126, 255),
                                        ),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
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
                                                    Text(
                                                      'Infected',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black45),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                  child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        data.totalConfirmed
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
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
                                                    Text(
                                                      'cured',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black45),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                  child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        data.totalRecovered
                                                            .toString(),
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
                                                    Text(
                                                      'deaths',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black45),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                  child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        data.totalDeceased
                                                            .toString(),
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
                                                Text(
                                                  'Infected',
                                                  style: TextStyle(
                                                      color: Colors.black45),
                                                )
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    data.dailyConfirmed
                                                        .toString(),
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
                                                Text(
                                                  'deaths',
                                                  style: TextStyle(
                                                      color: Colors.black45),
                                                )
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    data.dailyDeceased
                                                        .toString(),
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
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        print('Data refreshed');
        await Future.delayed(Duration(seconds: 5));
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 10,
          title: Text("Country Data"),
          centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black38,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: Color.fromARGB(120, 11, 126, 255),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 6),
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(120, 11, 126, 255),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3))),
                                  child: Text(latestCountryData.lastUpdatedTime
                                      .toString()),
                                ),
                              ],
                            ),
                            IconButton(
                              padding: EdgeInsets.all(0),
                              icon: Icon(
                                FontAwesomeIcons.solidChartBar,
                                color: Color.fromARGB(120, 11, 126, 255),
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
                                          Text(
                                            'Infected',
                                            style: TextStyle(
                                                color: Colors.black45),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          latestCountryData.confirmed
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    )
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
                                          Text(
                                            'cured',
                                            style: TextStyle(
                                                color: Colors.black45),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              latestCountryData.recovered
                                                  .toString(),
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
                                          Text(
                                            'deaths',
                                            style: TextStyle(
                                                color: Colors.black45),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              latestCountryData.deaths
                                                  .toString(),
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
                    margin: EdgeInsets.only(top: 15, bottom: 15),
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
                                      Text(
                                        'Infected',
                                        style: TextStyle(color: Colors.black45),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          latestCountryData.deltaConfirmed
                                              .toString(),
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
                                      Text(
                                        'deaths',
                                        style: TextStyle(color: Colors.black45),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          latestCountryData.deltaDeaths
                                              .toString(),
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
            _buildDraggableScrollableSheet(),
          ],
        ),
      ),
    );
  }
}
