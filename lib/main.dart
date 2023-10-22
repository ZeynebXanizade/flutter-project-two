import 'package:bilgi_testi/test_veri.dart';
import 'package:flutter/material.dart';
import 'const.dart';

void main() => runApp(BilgiTesti());

class BilgiTesti extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.blue[200],
            body: SafeArea(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: SoruSayfasi(),
            ))));
  }
}

class SoruSayfasi extends StatefulWidget {
  @override
  _SoruSayfasiState createState() => _SoruSayfasiState();
}

class _SoruSayfasiState extends State<SoruSayfasi> {
  List<Widget> secimler = [];
  testVeri test_1 = testVeri();

  void butonFunksiyonu(bool secilenButon) {
    if( test_1.testBittiMi()==true){
      //alert
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("BRAVO TESTI BİTİRDINIZ"),
           // content: new Text("Alert Dialog body"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new TextButton(
                child: new Text("BAŞA DÖN"),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    //secimler sifirlandi
                    secimler=[];
                    //testi sifirla
                    test_1.testiSifirla();
                  });
                },
              ),
            ],
          );
        },
      );

    }else{
      setState(() {
        test_1.getSoruYaniti() == secilenButon
            ? secimler.add(dogruIconu)
            : secimler.add(yalnisIconu);
        test_1.sonrakiSoru();
      });

    }



  }

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                test_1.getSoruMetni(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 3,
          runSpacing: 3,
          children: secimler,
        ),
        Expanded(
          flex: 2,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(children: <Widget>[
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: ElevatedButton(
                          onPressed: () {
                            butonFunksiyonu(false);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(12),
                            primary: Colors.red[400],
                            textStyle: TextStyle(color: Colors.white),
                          ),
                          child: Icon(
                            Icons.thumb_down,
                            size: 30.0,
                          ),
                        ))),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: ElevatedButton(
                          onPressed: () {
                            butonFunksiyonu(true);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(12),
                            primary: Colors.green[700],
                            textStyle: TextStyle(color: Colors.white),
                          ),
                          child: Icon(Icons.thumb_up, size: 30.0),
                        ))),
              ])),
        )
      ],
    );
  }
}
