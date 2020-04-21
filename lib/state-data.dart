import 'package:covidinfo/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StatesData extends StatefulWidget {
  List<CovidStateData> statesDataList;

  StatesData({Key key, this.statesDataList}) : super(key: key);

  @override
  _StatesDataState createState() => _StatesDataState();
}

class _StatesDataState extends State<StatesData> {
  List<CovidStateData> statesDataList = [];
  List<ExpansionTile> expansionList;

  @override
  void initState() {
    statesDataList = widget.statesDataList;
//    expansionList = widget.statesDataList
//        .map((data) => ExpansionTile(
//              title: Text(data.state),
//              children: <Widget>[listBuilderItem(data)],
//            ))
//        .toList();
    // TODO: implement initState
    super.initState();
  }

  listBuilderItem(CovidStateData data) {
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
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data.state,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Serif'),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
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
                              child: Text(data.lastUpdatedTime.toString()),
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
                                        style: TextStyle(color: Colors.black45),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          data.confirmed.toString(),
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
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
                                        style: TextStyle(color: Colors.black45),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                        alignment: Alignment.center,
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
                                      data.deltaConfirmed.toString(),
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
                                      data.deltaDeaths.toString(),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text("States Data"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: expansionList.length,
            itemBuilder: (BuildContext context, int index) {
//              CovidStateData data = statesDataList[index];
              return expansionList[index];
            }),
      ),
    );
  }
}
