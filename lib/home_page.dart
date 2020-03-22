import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:async';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Covid'),
      ),
      body: Container(child: RaisedButton(child: Text("Print body"),onPressed: (){

      },),),
    );
  }
}
