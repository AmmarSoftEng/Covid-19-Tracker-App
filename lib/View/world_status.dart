import 'package:covid_tracker/Modle/world_status_modle.dart';
import 'package:covid_tracker/View/countrieslist.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Services/states_srvices.dart';

TextStyle textH3 = TextStyle(fontSize: 18, fontWeight: FontWeight.normal);

class WordState extends StatelessWidget {
  StatesServices states_services = StatesServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              FutureBuilder<WorldStatusModle>(
                  future: states_services.getApi(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              'data': double.parse(
                                  snapshot.data!.cases!.toString()),
                              'recovery': double.parse(
                                  snapshot.data!.recovered!.toString()),
                              'Deaths': double.parse(
                                  snapshot.data!.deaths!.toString()),
                            },
                            chartType: ChartType.ring,
                            legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left),
                            animationDuration:
                                const Duration(milliseconds: 1200),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          Card(
                            child: Column(
                              children: [
                                ReuseableCard(
                                    'Data', snapshot.data!.cases.toString()),
                                ReuseableCard('recovery',
                                    snapshot.data!.recovered.toString()),
                                ReuseableCard(
                                    'Deaths', snapshot.data!.deaths.toString()),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CountriesList()));
                            },
                            child: Container(
                              height: 47,
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.green,
                              ),
                              child: Center(
                                child: Text(
                                  'Track Countries',
                                  style: textH3,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Center(
                          child: Text(
                        "No data",
                        style: TextStyle(color: Colors.white, fontSize: 32),
                      ));
                    }
                  }),
              // PieChart(
              //   dataMap: const {
              //     'data': 222222,
              //     'recovery': 1222222,
              //     'Deaths': 222222,
              //   },
              //   chartType: ChartType.ring,
              //   legendOptions:
              //       const LegendOptions(legendPosition: LegendPosition.left),
              //   animationDuration: const Duration(milliseconds: 1200),
              // ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.1,
              // ),
              // Card(
              //   child: Column(
              //     children: [
              //       ReuseableCard('Data', "1213123"),
              //       ReuseableCard('Data', "1213123"),
              //       ReuseableCard('Data', "1213123"),
              //       ReuseableCard('Data', "1213123"),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReuseableCard extends StatelessWidget {
  ReuseableCard(@required this.title, @required this.value);
  String title, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: textH3),
          Text(
            value,
            style: textH3,
          ),
        ],
      ),
    );
  }
}
