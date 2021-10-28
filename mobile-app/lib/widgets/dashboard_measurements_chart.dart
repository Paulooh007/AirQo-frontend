import 'package:app/constants/app_constants.dart';
import 'package:app/models/chartData.dart';
import 'package:app/utils/date.dart';
import 'package:app/utils/pm.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class DashboardBarChart extends StatefulWidget {
  final List<charts.Series<TimeSeriesData, DateTime>> seriesList;
  final String header;

  DashboardBarChart(this.seriesList, this.header);

  @override
  _DashboardBarChartState createState() => _DashboardBarChartState();
}

class _DashboardBarChartState extends State<DashboardBarChart> {
  var display = null;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Center(
              child: Text(
                widget.header,
                softWrap: true,
                style: TextStyle(
                    fontSize: 19,
                    color: ColorConstants.appColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          if (display != null)
            Column(
              children: [
                Text(
                  pmToString(display['value']).replaceAll('\n', ' '),
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.appColor),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  child: Row(
                    children: [
                      // const Spacer(
                      //   flex: 1,
                      // ),
                      Text(
                        widget.header.trim().toLowerCase() == 'forecast'
                            ? chartDateToString(display['time'], false)
                            : chartDateToString(display['time'], true),
                        softWrap: true,
                        style: TextStyle(color: ColorConstants.appColor),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Text(
                        display['value'].toString(),
                        softWrap: true,
                        style: TextStyle(color: ColorConstants.appColor),
                      ),
                      // const Spacer(
                      //   flex: 1,
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            height: 200,
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: charts.TimeSeriesChart(
              widget.seriesList,
              animate: true,
              defaultRenderer: charts.BarRendererConfig<DateTime>(
                  strokeWidthPx: 0, stackedBarPaddingPx: 0),
              defaultInteractions: true,
              domainAxis: const charts.DateTimeAxisSpec(
                  tickProviderSpec: charts.DayTickProviderSpec(increments: [1]),
                  tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
                    day: charts.TimeFormatterSpec(
                        format: 'EEE, hh a',
                        transitionFormat: 'EEE, hh a',
                        noonFormat: 'EEE, hh a'),
                  )),
              behaviors: [
                // charts.SeriesLegend(
                //   position: charts.BehaviorPosition.top,
                //   horizontalFirst: false,
                //   desiredMaxRows: 2,
                //   cellPadding: EdgeInsets.only(right: 4.0, bottom: 4.0),
                // ),
                charts.DomainHighlighter(),
                charts.SelectNearest(
                    eventTrigger: charts.SelectionTrigger.tapAndDrag),
                // charts.LinePointHighlighter(
                //   symbolRenderer: CustomCircleSymbolRenderer(size: size),
                // ),
              ],
              selectionModels: [
                charts.SelectionModelConfig(
                    changedListener: (charts.SelectionModel model) {
                  if (model.hasDatumSelection) {
                    try {
                      setState(() {
                        display = {
                          'time': (model.selectedSeries[0]
                                  .domainFn(model.selectedDatum[0].index))
                              .toString(),
                          'value': double.parse((model.selectedSeries[0]
                                  .measureFn(model.selectedDatum[0].index))
                              .toString())
                        };
                      });
                    } on Error catch (e) {
                      print(e);
                    }
                  }
                })
              ],
              primaryMeasureAxis: const charts.NumericAxisSpec(
                  tickProviderSpec:
                      charts.BasicNumericTickProviderSpec(desiredTickCount: 5)),
            ),
          )
        ],
      ),
    );
  }
}