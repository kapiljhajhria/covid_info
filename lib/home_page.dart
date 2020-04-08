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
    nh.getListOfAllData().then((value){
      nh.convertMapListToObject(value);
        setState(() {
      fetchedData = true;
    });
    });
//    nh.getListOfAllData().whenComplete(() {
//      setState(() {
//        fetchedData = true;
//      });
//    });

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
              setState(() {

              });
              nh.getListOfAllData().then((value){
                nh.convertMapListToObject(value);
                setState(() {
                  fetchedData = true;
                });
              });
            },
          )
        ],
      ),
      body: fetchedData?ListView.builder(
          itemCount: nh.allObjectsList.length,
          itemBuilder: (BuildContext context, int index) {
            IndiaCovidData data = nh.allObjectsList[index];
            return Container(
              width: double.infinity,
              height: 180,
              child: Column(
                children: <Widget>[
                  Text("Total Cases :"+data.cases.toString()),
                  Text("Cases Today :"+data.todayCases.toString()),
                  Text("Total Deaths :"+data.deaths.toString()),
                  Text("Deaths Today :"+data.todayDeaths.toString()),
                  Text("Recovered :"+data.recovered.toString()),
                  Text("Active Cases :"+data.active.toString()),
                  Text("Critical :"+data.critical.toString()),
                  Text("TimeStamp :"+data.timestamp),
                ],
              ),
            );
          }):Center(child: CircularProgressIndicator(),),
    );
  }
}
