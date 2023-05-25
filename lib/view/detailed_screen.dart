import 'package:covid_app19/view/world_states.dart';
import 'package:flutter/material.dart';
class DetailScreen extends StatefulWidget {
  String image;
  String name;

  int totalCases,totalDeaths,totalRecovered,active,todayRecovered,critical;

  DetailScreen({
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.todayRecovered,
    required this.critical
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [


              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.06),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height:MediaQuery.of(context).size.height*0.067 ,),
                      ReUsableRow(title:'Cases',value: widget.totalCases.toString(),),
                      ReUsableRow(title:'totalCases',value: widget.totalCases.toString(),),
                      ReUsableRow(title:'Recovered',value: widget.totalRecovered.toString(),),
                      ReUsableRow(title:'Deaths',value: widget.totalDeaths.toString(),),
                      ReUsableRow(title:'Active',value: widget.active.toString(),),
                      ReUsableRow(title:'Today Recovered',value: widget.todayRecovered.toString(),),
                      ReUsableRow(title:'Critical',value: widget.critical.toString(),),


                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage:NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
