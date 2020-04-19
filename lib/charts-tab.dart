import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import 'network_helper.dart';

class ChartsTab extends StatefulWidget {
  List<CovidCountryData> indiaDataList;
  CovidStateData latestCountryData;
  final Widget child;

  ChartsTab({Key key, this.indiaDataList, this.child, this.latestCountryData})
      : super(key: key);

  @override
  _ChartsTabState createState() => _ChartsTabState();
}

class _ChartsTabState extends State<ChartsTab> {
  List<CovidCountryData> indiaDataList;
  CovidStateData latestCountryData;
  List<charts.Series<BarChartClass, String>> _seriesData;
  List<charts.Series<PieChartClass, String>> _seriesPieData;
  List<charts.Series<TotalStatsClass, int>> _seriesLineData;

  _generateData() {
    int totalDays = widget.indiaDataList.length;
    var data1 = [
      new BarChartClass(widget.indiaDataList[totalDays - 7].ddmm,
          widget.indiaDataList[totalDays - 7].dailyConfirmed),
      new BarChartClass(widget.indiaDataList[totalDays - 6].ddmm,
          widget.indiaDataList[totalDays - 6].dailyConfirmed),
      new BarChartClass(widget.indiaDataList[totalDays - 5].ddmm,
          widget.indiaDataList[totalDays - 5].dailyConfirmed),
      new BarChartClass(widget.indiaDataList[totalDays - 4].ddmm,
          widget.indiaDataList[totalDays - 4].dailyConfirmed),
      new BarChartClass(widget.indiaDataList[totalDays - 3].ddmm,
          widget.indiaDataList[totalDays - 3].dailyConfirmed),
      new BarChartClass(widget.indiaDataList[totalDays - 2].ddmm,
          widget.indiaDataList[totalDays - 2].dailyConfirmed),
      new BarChartClass(widget.indiaDataList[totalDays - 1].ddmm,
          widget.indiaDataList[totalDays - 1].dailyConfirmed),
    ];

    double totalCases = (widget.indiaDataList.last.totalConfirmed).toDouble();
    var piedata = [
      new PieChartClass('Total cases:${widget.latestCountryData.confirmed}',
          widget.latestCountryData.confirmed.toDouble(), Color(0xff3366cc)),
      new PieChartClass('Deaths:${widget.latestCountryData.deaths}',
          widget.latestCountryData.deaths.toDouble(), Color(0xff990099)),
      new PieChartClass('Recovered:${widget.latestCountryData.recovered}',
          widget.latestCountryData.recovered.toDouble(), Color(0xff109618)),
    ];

    var linesalesdata2 = widget.indiaDataList.asMap().entries.map((entry) {
      int idx = entry.key;
      CovidCountryData val = entry.value;
      return TotalStatsClass(idx, val.totalConfirmed);
    }).toList();
    var linesalesdata = widget.indiaDataList.asMap().entries.map((entry) {
      int idx = entry.key;
      CovidCountryData val = entry.value;
      return TotalStatsClass(idx, val.totalDeceased);
    }).toList();

    var linesalesdata1 = widget.indiaDataList.asMap().entries.map((entry) {
      int idx = entry.key;
      CovidCountryData val = entry.value;
      return TotalStatsClass(idx, val.totalRecovered);
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
    latestCountryData = widget.latestCountryData;
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
                  'Last 7 days Confirmed cases',
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
