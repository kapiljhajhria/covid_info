import 'package:covidinfo/network_helper.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NetworkHelper nh = NetworkHelper();
  bool fetchedData = false;

  @override
  void initState() {
    // TODO: implement initState
    nh.fetchStateDataList().whenComplete(() {
      setState(() {
        fetchedData = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              fetchedData = false;
              nh.fetchStateDataList().whenComplete(() {
                fetchedData = true;
              });
            },
          )
        ],
      ),
      body: fetchedData?ListView.builder(
          itemCount: nh.statesData.length,
          itemBuilder: (BuildContext context, int index) {
            CountryState cState = nh.statesData[index];
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
//              textBaseline: TextBaseline.alphabetic,
//              textDirection: TextDirection.ltr,
              children: <Widget>[
                Expanded(
                  flex: 3,
                    child: Text(cState.name)),
                Expanded(child: Text(cState.indianCases.toString())),
                Expanded(child: Text(cState.foreignCases.toString())),
                Expanded(child: Text(cState.cured.toString())),
                Expanded(child: Text(cState.death.toString())),
              ],
            );
          }):Center(child: CircularProgressIndicator(),),
    );
  }
}
