


import 'package:covid_app19/view_model/worldstateview_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import 'package:flutter/services.dart';

import '../model/woldstate_model.dart';
import 'countrieslist_screen.dart';



class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({Key? key}) : super(key: key);

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
  AnimationController(duration: const Duration(microseconds: 1000), vsync: this)
    ..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  StatesServices newListViewModel = StatesServices();
  final colorList = const [
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                FutureBuilder(
                    future: newListViewModel.fetchWorldRecord(),
                    builder: (context, AsyncSnapshot<WorlstateModel> snapshot) {

                      if(snapshot.hasData)
                        {
                          return Column(
                            children: [
                              PieChart(
                                dataMap:  {
                                  "Total": double.parse(snapshot.data!.cases.toString()),
                                  "Recovered":double.parse(snapshot.data!.recovered.toString()),
                                  "Death": double.parse(snapshot.data!.deaths.toString())
                                },
                                chartRadius: MediaQuery.of(context).size.width / 3,
                                legendOptions: const LegendOptions(
                                  legendPosition: LegendPosition.left,
                                ),
                                chartType: ChartType.ring,
                                colorList: colorList,
                                chartValuesOptions: const ChartValuesOptions(
                                  showChartValues: true,
                                  showChartValueBackground: true,
                                  decimalPlaces: 2,
                                  showChartValuesOutside: false,
                                  showChartValuesInPercentage: true

                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                    MediaQuery.of(context).size.height * 0.04),
                                child: Card(
                                  child: Column(children: [
                                    ReUsableRow(title: "Total", value: snapshot.data!.cases.toString()),
                                    ReUsableRow(title: "Deaths", value:  snapshot.data!.deaths.toString()),
                                    ReUsableRow(title: "Recovered", value:  snapshot.data!.recovered.toString()),
                                    ReUsableRow(title: "Active", value:  snapshot.data!.active.toString()),
                                    ReUsableRow(title: "Critical", value:  snapshot.data!.critical.toString()),
                                    ReUsableRow(title: "Today Deaths", value:  snapshot.data!.todayDeaths.toString()),
                                    // ReUsableRow(title: "Today Cases", value:  snapshot.data!.todayCases.toString()),
                                    ReUsableRow(title: "Total Recovered", value:  snapshot.data!.todayRecovered.toString()),

                                  ]),
                                ),
                              ),
                              InkWell(
                                onTap: ()
                                {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CountriesList()));
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Color(0xff1aa260),
                                      borderRadius: BorderRadius.circular(10)),
                                  child:const  Center(
                                      child: Text(
                                        'Track Countries',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500, fontSize: 20),
                                      )),
                                ),
                              )
                            ],
                          );
                        }
                      else{
                        return  SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50.0,
                         // controller: _controller,
                        );
                      }
                    }),
              ],
            ),
          )),
    );
  }
}

class ReUsableRow extends StatelessWidget {
  String title, value;
  ReUsableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
              Text(value,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
            ],
          ),
          const SizedBox(
            height: 3,
          ),
          Divider()
        ],
      ),
    );
  }
}
