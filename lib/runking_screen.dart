import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RunkingScreen extends StatefulWidget {
  @override
  _RunkingScreenState createState() => _RunkingScreenState();
}

class _RunkingScreenState extends State<RunkingScreen> {
  Future getdataGas() {
    return Dio()
        .get(
      "https://script.google.com/macros/s/AKfycbw8EqvlcRuvSCbTif1rvGPGFwvC0knhohcbae2wVrJC1lPogVPojqZ7ptQXez1Thv08Xg/exec",
    )
        .then((response) {
      print(response.data);
      print(response.data[0]['日付']);
      return response.data;
    }).catchError((err) {
      print(err);
      return null;
    });
  }

  // var data =  Dio()
  //     .get(
  //   "https://script.google.com/macros/s/AKfycbw8EqvlcRuvSCbTif1rvGPGFwvC0knhohcbae2wVrJC1lPogVPojqZ7ptQXez1Thv08Xg/exec",
  // )
  //     .then((response) {
  //   print(response.data);
  //   print(response.data[0]['日付']);
  //   return response.data;
  // }).catchError((err) {
  //   print(err);
  //   return null;
  // });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("ランキング一覧")),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("現在の順位"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder(
                    future: getdataGas(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      //if (snapshot.hasData) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text("1位："),
                              Text(snapshot.data[0]['名前'].toString()),
                              Text(
                                snapshot.data[0]['連勝記録'].toString(),
                                style: TextStyle(color: Colors.red),
                              ),
                              Text("連勝"),
                            ],
                          ),
                          Row(
                            children: [
                              Text("2位："),
                              Text(snapshot.data[1]['名前'].toString()),
                              Text(
                                snapshot.data[1]['連勝記録'].toString(),
                                style: TextStyle(color: Colors.red),
                              ),
                              Text("連勝"),
                            ],
                          ),
                          Row(
                            children: [
                              Text("3位："),
                              Text(snapshot.data[2]['名前'].toString()),
                              Text(
                                snapshot.data[2]['連勝記録'].toString(),
                                style: TextStyle(color: Colors.red),
                              ),
                              Text("連勝"),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
