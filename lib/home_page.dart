import 'package:covidinfo/country_data_tab.dart';
import 'package:covidinfo/state-data.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tabIndex = 0;
  List<Widget> _navigationTabsList = [CountryData(), StatesData(), StatesData()];
  var box;

  @override
  void initState() {
    box = Hive.box('covidData');
    box.put('test01', 'this is hive test8');
    super.initState();
  }
  Future<void> openHiveBox()async{
    final storageBox = await Hive.openBox('covidData');
    box = Hive.box('covidData');
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
        body: TabBarView(

            children: _navigationTabsList),
      ),
    );
  }
}
