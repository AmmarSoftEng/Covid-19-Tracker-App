import 'package:covid_tracker/Services/states_srvices.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  StatesServices statesServices = StatesServices();

  TextEditingController textEditingController = TextEditingController();

  void onChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Countries List'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .04,
              ),
              TextFormField(
                controller: textEditingController,
                onChanged: (value) {
                  onChange();
                },
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              Expanded(
                child: FutureBuilder<List<dynamic>>(
                    future: statesServices.getcountries(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Shimmer.fromColors(
                            child: ListView.builder(
                                itemCount: 4,
                                itemBuilder: (context, indext) {
                                  return Column(
                                    children: [
                                      ListTile(
                                          leading: CircleAvatar(),
                                          title: Container(
                                            width: 50,
                                            height: 20,
                                            color: Colors.black26,
                                          )),
                                    ],
                                  );
                                }),
                            baseColor: Colors.black12,
                            highlightColor: Colors.black26);
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              String name = snapshot.data![index]['country'];
                              if (textEditingController.text.isEmpty) {
                                return Column(
                                  children: [
                                    ListTile(
                                      leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']
                                                ['flag']),
                                      ),
                                      title: Text(
                                          snapshot.data![index]['country']),
                                    ),
                                  ],
                                );
                              } else if (name.toLowerCase().contains(
                                  textEditingController.text.toLowerCase())) {
                                return Column(
                                  children: [
                                    ListTile(
                                      leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']
                                                ['flag']),
                                      ),
                                      title: Text(
                                          snapshot.data![index]['country']),
                                    ),
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            });
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
