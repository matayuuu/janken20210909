import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test20210907/runking_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int countUp = 0;
  String _myPon = "";
  String cpPon = "";
  void _handleRadioButton(myPon) => setState(() {
        _myPon = myPon;
      });
  String _yourName = 'あなた';

  List<String> cp = ["ぐー", "ちょき", "ぱー"];
  void cpPonFunc() {
    var rand = math.Random();
    int randInt = rand.nextInt(3);
    cpPon = cp[randInt];
  }

  String hantei = "";
  String errerMsg = "";
  String errerMsgName = "";

  //GETでGASにデータを送る
  // 参考 https://pub.dev/packages/dio#examples
  void _request() async {
    var uri =
        "https://script.google.com/macros/s/AKfycbxsZN-28w9IVonrS3tAxHYrCwvTZRa2wbDUR1tsx_cOsVgLWsS6zMyWnSbtdLRTPyyV/exec?score=" +
            countUp.toString() +
            "&name=" +
            _yourName;
    try {
      await Dio().get(uri);
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("シンプルなじゃんけんアプリ")),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "現在",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                Text(
                  countUp.toString(),
                  style: TextStyle(fontSize: 40, color: Colors.redAccent),
                ),
                Text(
                  "連勝中",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text("コンピュータ：" + cpPon, style: TextStyle(fontSize: 20)),
            SizedBox(
              height: 30,
            ),
            // Text(_yourName + "は「" + _myPon + "」を選びますか？",
            //     style: TextStyle(fontSize: 20)),
            // SizedBox(
            //   height: 30,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                    value: "ぐー",
                    groupValue: _myPon,
                    onChanged: _handleRadioButton),
                Text("ぐー"),
                Radio(
                    value: "ちょき",
                    groupValue: _myPon,
                    onChanged: _handleRadioButton),
                Text("ちょき"),
                Radio(
                    value: "ぱー",
                    groupValue: _myPon,
                    onChanged: _handleRadioButton),
                Text("ぱー"),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 300,
              child: TextField(
                enabled: true,
                // 入力数
                maxLength: 10,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
                obscureText: false,
                maxLines: 1,
                // inputFormatters: <TextInputFormatter>[
                //   WhitelistingTextInputFormatter.digitsOnly,
                // ],
                decoration: const InputDecoration(
                  icon: Icon(Icons.face),
                  hintText: 'お名前を入力してください',
                  labelText: 'お名前 *',
                  labelStyle: TextStyle(fontSize: 15),
                  hintStyle: TextStyle(fontSize: 15),
                ),
                //パスワード
                onChanged: (text) {
                  if (text.length > 0) {
                    setState(() {
                      _yourName = text;
                    });
                  } else {
                    setState(() {
                      _yourName = 'あなた';
                    });
                  }
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              child: Text(
                "っぽん!!",
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
              ),
              onPressed: () {
                if (_yourName == 'あなた') {
                  //名前入力を促す
                  setState(() {
                    errerMsgName = "お名前を入力して下さい";
                  });
                } else {
                  setState(() {
                    cpPonFunc();
                    hanteiFunc();
                    errerMsgName = '';
                  });
                }
              },
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              hantei,
              style: TextStyle(fontSize: 30, color: Colors.redAccent),
            ),
            Text(errerMsg),
            Text(errerMsgName),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              child: Text(
                "ランキング一覧",
                style: TextStyle(fontSize: 15),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.white70,
                onPrimary: Colors.redAccent,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RunkingScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void hanteiFunc() async {
    if (_myPon == "ぐー" && cpPon == "ぐー") {
      hantei = "あいこ";
      errerMsg = "";
    } else if (_myPon == "ぐー" && cpPon == "ちょき") {
      hantei = "勝ち";
      errerMsg = "";
      countUp++;
    } else if (_myPon == "ぐー" && cpPon == "ぱー") {
      hantei = "負け";
      errerMsg = "";
      _request();
      await showResult();
      countUp = 0;
      setState(() {
        hantei = "";
      });
    } else if (_myPon == "ちょき" && cpPon == "ぐー") {
      hantei = "負け";
      errerMsg = "";
      _request();
      await showResult();
      countUp = 0;
      setState(() {
        hantei = "";
      });
    } else if (_myPon == "ちょき" && cpPon == "ちょき") {
      hantei = "あいこ";
      errerMsg = "";
    } else if (_myPon == "ちょき" && cpPon == "ぱー") {
      hantei = "勝ち";
      errerMsg = "";
      countUp++;
    } else if (_myPon == "ぱー" && cpPon == "ぐー") {
      hantei = "勝ち";
      errerMsg = "";
      countUp++;
    } else if (_myPon == "ぱー" && cpPon == "ちょき") {
      hantei = "負け";
      errerMsg = "";
      _request();
      await showResult();
      countUp = 0;
      setState(() {
        hantei = "";
      });
    } else if (_myPon == "ぱー" && cpPon == "ぱー") {
      hantei = "あいこ";
      errerMsg = "";
    } else {
      hantei = "";
      errerMsg = "あなたのじゃんけんを選択して下さい";
    }
  }

  Future<void> showResult() {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("結果"),
          content: Text("あなたの連勝記録は" + countUp.toString() + "回です"),
          actions: <Widget>[
            // ボタン領域
            TextButton(
              child: Text("OK"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
