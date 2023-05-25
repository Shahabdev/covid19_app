import 'package:covid_app19/view/detailed_screen.dart';
import 'package:covid_app19/view_model/worldstateview_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  final TextEditingController _searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices services = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _searchcontroller,
              onChanged: (value)
              {
                setState(() {

                });
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'search with county name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  )),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: services.fetchcountrieslist(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade700,
                      highlightColor: Colors.grey.shade100,
                      child: ListView.builder(
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Container(
                                height: 50,
                                width: 50,
                                color: Colors.white,
                              ),
                              subtitle: Container(
                                height: 8.0,
                                width: double.infinity,
                                color: Colors.white,
                              ),
                              title: Container(
                                height: 8.0,
                                width: 100,
                                color: Colors.white,
                              ),
                            );
                          }),
                    );
                  } else {

                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name=snapshot.data![index]['country'];
                          if(_searchcontroller.text.isEmpty)
                            {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap:()
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
                                  image: snapshot.data![index]['countryInfo']['flag'],
                                  name: snapshot.data![index]['country'],
                                  totalCases: snapshot.data![index]['cases'],
                                  totalDeaths: snapshot.data![index]['deaths'],
                                  totalRecovered: snapshot.data![index]['recovered'],
                                  active: snapshot.data![index]['active'],
                                  todayRecovered: snapshot.data![index]['todayRecovered'],
                                  critical: snapshot.data![index]['critical'],

                                )));
                              },
                                    child: ListTile(
                                      leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag']),
                                      ),
                                      title: Text(snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]['cases'].toString()),
                                    ),
                                  )
                                ],
                              );
                            }
                          else if(name.toLowerCase().contains(_searchcontroller.text.toLowerCase()))
                            {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap:()
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
                                  image: snapshot.data![index]['countryInfo']['flag'],
                                  name: snapshot.data![index]['country'],
                                  totalCases: snapshot.data![index]['cases'],
                                  totalDeaths: snapshot.data![index]['deaths'],
                                  totalRecovered: snapshot.data![index]['recovered'],
                                  active: snapshot.data![index]['active'],
                                  todayRecovered: snapshot.data![index]['todayRecovered'],
                                  critical: snapshot.data![index]['critical'],

                                    )));
                              },
                                    child: ListTile(
                                      leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag']),
                                      ),
                                      title: Text(snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]['cases'].toString()),
                                    ),
                                  )
                                ],
                              );

                            }
                          else
                            {
                             return Container();
                            }
                          return Column(
                            children: [
                              ListTile(
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag']),
                                ),
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(snapshot.data![index]['cases'].toString()),
                              )
                            ],
                          );
                        });
                  }
                }),
          )
        ],
      ),
    );
  }
}
