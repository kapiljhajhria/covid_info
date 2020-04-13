import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import 'network_helper.dart';

class ChartsTab extends StatefulWidget {
  List<IndiaCovidData> indiaDataList;
  final Widget child;

  ChartsTab({Key key, this.indiaDataList, this.child}) : super(key: key);

  @override
  _ChartsTabState createState() => _ChartsTabState();
}

class _ChartsTabState extends State<ChartsTab> {
  List<IndiaCovidData> indiaDataList;
  List<charts.Series<Pollution, String>> _seriesData;
  List<charts.Series<Task, String>> _seriesPieData;
  List<charts.Series<Sales, int>> _seriesLineData;

  _generateData() {
    int totalDays = widget.indiaDataList.length;
    var data1 = [
      new Pollution(
          "${widget.indiaDataList[totalDays - 3].localTime.day}/${widget.indiaDataList[totalDays - 3].localTime.month}",
          widget.indiaDataList[totalDays - 3].todayCases),
      new Pollution(
          "${widget.indiaDataList[totalDays - 2].localTime.day}/${widget.indiaDataList[totalDays - 2].localTime.month}",
          widget.indiaDataList[totalDays - 2].todayCases),
      new Pollution(
          "${widget.indiaDataList[totalDays - 1].localTime.day}/${widget.indiaDataList[totalDays - 1].localTime.month}",
          widget.indiaDataList[totalDays - 1].todayCases),
    ];
    var data2 = [
      new Pollution(
          "${widget.indiaDataList[totalDays - 3].localTime.day}/${widget.indiaDataList[totalDays - 3].localTime.month}",
          widget.indiaDataList[totalDays - 3].todayDeaths),
      new Pollution(
          "${widget.indiaDataList[totalDays - 2].localTime.day}/${widget.indiaDataList[totalDays - 2].localTime.month}",
          widget.indiaDataList[totalDays - 2].todayDeaths),
      new Pollution(
          "${widget.indiaDataList[totalDays - 1].localTime.day}/${widget.indiaDataList[totalDays - 1].localTime.month}",
          widget.indiaDataList[totalDays - 1].todayDeaths),
    ];
    var data3 = [
      new Pollution(
          "${widget.indiaDataList[totalDays - 3].localTime.day}/${widget.indiaDataList[totalDays - 3].localTime.month}",
          0),
      new Pollution(
          "${widget.indiaDataList[totalDays - 2].localTime.day}/${widget.indiaDataList[totalDays - 2].localTime.month}",
          0),
      new Pollution(
          "${widget.indiaDataList[totalDays - 1].localTime.day}/${widget.indiaDataList[totalDays - 1].localTime.month}",
          0),
    ];
    double totalCases = (widget.indiaDataList.last.cases).toDouble();
    var piedata = [
      new Task('Total cases:${widget.indiaDataList.last.cases}',
          widget.indiaDataList.last.cases.toDouble(), Color(0xff3366cc)),
      new Task('Deaths:${widget.indiaDataList.last.deaths}',
          widget.indiaDataList.last.deaths.toDouble(), Color(0xff990099)),
      new Task('Recovered:${widget.indiaDataList.last.recovered}',
          widget.indiaDataList.last.recovered.toDouble(), Color(0xff109618)),
    ];

    var linesalesdata2 = widget.indiaDataList.asMap().entries.map((entry) {
      int idx = entry.key;
      IndiaCovidData val = entry.value;
      return Sales(idx, val.cases);
    }).toList();
    var linesalesdata = widget.indiaDataList.asMap().entries.map((entry) {
      int idx = entry.key;
      IndiaCovidData val = entry.value;
      return Sales(idx, val.deaths);
    }).toList();

    var linesalesdata1 = widget.indiaDataList.asMap().entries.map((entry) {
      int idx = entry.key;
      IndiaCovidData val = entry.value;
      return Sales(idx, val.recovered);
    }).toList();

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2017',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff990099)),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        data: data2,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff109618)),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        data: data3,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xffff9900)),
      ),
    );

    _seriesPieData.add(
      charts.Series(
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        data: piedata,
        labelAccessorFn: (Task row, _) => '${row.taskvalue}',
      ),
    );

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
        data: linesalesdata,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff109618)),
        data: linesalesdata1,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffff9900)),
        data: linesalesdata2,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
  }

  List<Widget> chartsWidgetList = [];

  @override
  void initState() {
    indiaDataList = widget.indiaDataList;
    super.initState();
    _seriesData = List<charts.Series<Pollution, String>>();
    _seriesPieData = List<charts.Series<Task, String>>();
    _seriesLineData = List<charts.Series<Sales, int>>();
    _generateData();
    chartsWidgetList = [
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  'Country\'s Stats',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: charts.LineChart(_seriesLineData,
                      defaultRenderer: new charts.LineRendererConfig(
                          includeArea: true, stacked: true),
                      animate: true,
                      animationDuration: Duration(seconds: 2),
                      behaviors: [
                        new charts.ChartTitle('no. of days',
                            behaviorPosition: charts.BehaviorPosition.bottom,
                            titleOutsideJustification:
                                charts.OutsideJustification.middleDrawArea),
                        new charts.ChartTitle('people',
                            behaviorPosition: charts.BehaviorPosition.start,
                            titleOutsideJustification:
                                charts.OutsideJustification.middleDrawArea),
                        new charts.ChartTitle(
                          'Deaths, Recovered, Infected',
                          behaviorPosition: charts.BehaviorPosition.end,
                          titleOutsideJustification:
                              charts.OutsideJustification.middleDrawArea,
                        )
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  'Last 3 days Stats',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: charts.BarChart(
                    _seriesData,
                    animate: true,
                    barGroupingType: charts.BarGroupingType.grouped,
                    //behaviors: [new charts.SeriesLegend()],
                    animationDuration: Duration(seconds: 5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  'Total Data Pie Chart',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: charts.PieChart(_seriesPieData,
                      animate: true,
                      animationDuration: Duration(seconds: 5),
                      behaviors: [
                        new charts.DatumLegend(
                          outsideJustification:
                              charts.OutsideJustification.endDrawArea,
                          horizontalFirst: false,
                          desiredMaxRows: 2,
                          cellPadding:
                              new EdgeInsets.only(right: 4.0, bottom: 4.0),
                          entryTextStyle: charts.TextStyleSpec(
                              color: charts.MaterialPalette.purple.shadeDefault,
                              fontFamily: 'Georgia',
                              fontSize: 11),
                        )
                      ],
                      defaultRenderer: new charts.ArcRendererConfig(
                          arcWidth: 100,
                          arcRendererDecorators: [
                            new charts.ArcLabelDecorator(
                                labelPosition: charts.ArcLabelPosition.inside)
                          ])),
                ),
              ],
            ),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: chartsWidgetList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(height: 400, child: chartsWidgetList[index]);
        });
  }
}

class Pollution {
  String place;
  int quantity;
  Pollution(this.place, this.quantity);
}

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}

class Sales {
  int yearval;
  int salesval;

  Sales(this.yearval, this.salesval);
}
