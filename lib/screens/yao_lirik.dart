import 'package:flutter/material.dart';
import 'package:stb_app/models/lirik.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:stb_app/screens/yao_lirik_detail.dart';

class YaoLirik extends StatefulWidget {
  const YaoLirik({Key? key}) : super(key: key);

  @override
  State<YaoLirik> createState() => _YaoLirikState();
}

class _YaoLirikState extends State<YaoLirik> {
  late Stream<List<Lirik>> lirikList;
  Stream<List<Lirik>> getLirik() {
    final stream = Stream.fromFuture(http.get(Uri.parse(
        'https://script.google.com/macros/s/AKfycby3s3agn_xJK1wfziE_xcFN_QXKijWrT5CV-biW9MLaNuD4WRTEdFhXoygFt718UY5Ozw/exec')));
    return stream.asyncMap((response) {
      if (response.statusCode == 200) {
        final data = convert.json.decode(response.body) as List;
        return data.map((lirikList) => Lirik.fromJson(lirikList)).toList();
      } else {
        throw Exception("tidak bisa terhubunh ke server");
      }
    });
  }

  @override
  void initState() {
    lirikList = getLirik();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final lebar = MediaQuery.of(context).size.width;
    // final tinggi = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              lirikList = getLirik();
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: StreamBuilder<List<Lirik>>(
                    stream: lirikList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Card(
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => YaoLirikDetail(
                                            lirikDetail: snapshot.data![index],
                                          ),
                                        ),
                                      );
                                    },
                                    title: Text(
                                      snapshot.data![index].judul!,
                                      style: const TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data![index].lirik!,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.grey,
                                          ),
                                          maxLines: 2,
                                        ),
                                        Text(
                                          snapshot.data![index].karya!,
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });

                        //   return ListItem(
                        //       judul: snapshot.data![index].judul!,
                        //       lirik: snapshot.data![index].lirik!,
                        //       karya: snapshot.data![index].karya!);
                        // });
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String judul;
  final String lirik;
  final String karya;
  const ListItem(
      {Key? key, required this.judul, required this.lirik, required this.karya})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: ListTile(
          onTap: () {},
          title: Text(
            judul,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lirik,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
                maxLines: 2,
              ),
              Text(
                karya,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
