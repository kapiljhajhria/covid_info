import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import 'network_helper.dart';

class ChartsTab extends StatefulWidget {
  List<CovidData> indiaDataList;
  final Widget child;

  ChartsTab({Key key, this.indiaDataList, this.child}) : super(key: key);

  @override
  _ChartsTabState createState() => _ChartsTabState();
}

class _ChartsTabState extends State<ChartsTab> {
  List<CovidData> indiaDataList;
  List<charts.Series<BarChartClass, String>> _seriesData;
  List<charts.Series<PieChartClass, String>> _seriesPieData;
  List<charts.Series<TotalStatsClass, int>> _seriesLineData;

  _generateData() {
    int totalDays = widget.indiaDataList.length;
    var data1 = [
      new BarChartClass(
          "${widget.indiaDataList[totalDays - 4].localTime.day}/${widget.indiaDataList[totalDays - 4].localTime.month}",
          widget.indiaDataList[totalDays - 4].todayCases),
      new BarChartClass(
          "${widget.indiaDataList[totalDays - 3].localTime.day}/${widget.indiaDataList[totalDays - 3].localTime.month}",
          widget.indiaDataList[totalDays - 3].todayCases),
      new BarChartClass(
          "${widget.indiaDataList[totalDays - 2].localTime.day}/${widget.indiaDataList[totalDays - 2].localTime.month}",
          widget.indiaDataList[totalDays - 2].todayCases),
    ];
    var data2 = [
      new BarChartClass(
          "${widget.indiaDataList[totalDays - 4].localTime.day}/${widget.indiaDataList[totalDays - 4].localTime.month}",
          widget.indiaDataList[totalDays - 4].todayDeaths),
      new BarChartClass(
          "${widget.indiaDataList[totalDays - 3].localTime.day}/${widget.indiaDataList[totalDays - 3].localTime.month}",
          widget.indiaDataList[totalDays - 3].todayDeaths),
      new BarChartClass(
          "${widget.indiaDataList[totalDays - 2].localTime.day}/${widget.indiaDataList[totalDays - 2].localTime.month}",
          widget.indiaDataList[totalDays - 2].todayDeaths),
    ];

    double totalCases = (widget.indiaDataList.last.cases).toDouble();
    var piedata = [
      new PieChartClass('Total cases:${widget.indiaDataList.last.cases}',
          widget.indiaDataList.last.cases.toDouble(), Color(0xff3366cc)),
      new PieChartClass('Deaths:${widget.indiaDataList.last.deaths}',
          widget.indiaDataList.last.deaths.toDouble(), Color(0xff990099)),
      new PieChartClass('Recovered:${widget.indiaDataList.last.recovered}',
          widget.indiaDataList.last.recovered.toDouble(), Color(0xff109618)),
    ];

    var linesalesdata2 = widget.indiaDataList.asMap().entries.map((entry) {
      int idx = entry.key;
      CovidData val = entry.value;
      return TotalStatsClass(idx, val.cases);
    }).toList();
    var linesalesdata = widget.indiaDataList.asMap().entries.map((entry) {
      int idx = entry.key;
      CovidData val = entry.value;
      return TotalStatsClass(idx, val.deaths);
    }).toList();

    var linesalesdata1 = widget.indiaDataList.asMap().entries.map((entry) {
      int idx = entry.key;
      CovidData val = entry.value;
      return TotalStatsClass(idx, val.recovered);
    }).toList();

    _seriesData.add(
      charts.Series(
        domainFn: (BarChartClass pollution, _) => pollution.dateMonth,
        measureFn: (BarChartClass pollution, _) => pollution.numberOfPeopel,
        id: '2017',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (BarChartClass pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff990099)),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (BarChartClass pollution, _) => pollution.dateMonth,
        measureFn: (BarChartClass pollution, _) => pollution.numberOfPeopel,
        data: data2,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (BarChartClass pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff109618)),
      ),
    );

    _seriesPieData.add(
      charts.Series(
        domainFn: (PieChartClass task, _) => task.label,
        measureFn: (PieChartClass task, _) => task.labelValue,
        colorFn: (PieChartClass task, _) =>
            charts.ColorUtil.fromDartColor(task.colorValue),
        data: piedata,
        labelAccessorFn: (PieChartClass row, _) => '${row.labelValue}',
      ),
    );

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
        data: linesalesdata,
        domainFn: (TotalStatsClass sales, _) => sales.nDay,
        measureFn: (TotalStatsClass sales, _) => sales.noOfPeople,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff109618)),
        data: linesalesdata1,
        domainFn: (TotalStatsClass sales, _) => sales.nDay,
        measureFn: (TotalStatsClass sales, _) => sales.noOfPeople,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffff9900)),
        data: linesalesdata2,
        domainFn: (TotalStatsClass sales, _) => sales.nDay,
        measureFn: (TotalStatsClass sales, _) => sales.noOfPeople,
      ),
    );
  }

  List<Widget> chartsWidgetList = [];

  @override
  void initState() {
    indiaDataList = widget.indiaDataList;
    super.initState();
    _seriesData = List<charts.Series<BarChartClass, String>>();
    _seriesPieData = List<charts.Series<PieChartClass, String>>();
    _seriesLineData = List<charts.Series<TotalStatsClass, int>>();
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

class BarChartClass {
  String dateMonth;
  int numberOfPeopel;

  BarChartClass(this.dateMonth, this.numberOfPeopel);
}

class PieChartClass {
  String label;
  double labelValue;
  Color colorValue;

  PieChartClass(this.label, this.labelValue, this.colorValue);
}

class TotalStatsClass {
  int nDay;
  int noOfPeople;

  TotalStatsClass(this.nDay, this.noOfPeople);
}
