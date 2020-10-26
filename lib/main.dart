import 'package:flutter/material.dart';

import 'ResponseUsers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String output = "No Data";
  String outputList = "No Data";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Api Demo ARRAY"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Request(https://reqres.in/api/users?page=2)"),
              Text("Hasil Object"),
              Text(output, textAlign: TextAlign.center,),
              Text("Hasil Array"),
              Text(outputList, textAlign: TextAlign.center,),
              RaisedButton(
                onPressed: () {
                  ResponseUsers.callApiArray("2").then((value) {
                    output = "";
                    output = '{"page": ' +
                        value.page.toString() +
                        ',"per_page": ' +
                        value.perPage.toString() +
                        ',"total": ' +
                        value.total.toString() +
                        ',"total_pages": ' +
                        value.totalPages.toString() +
                        ', "ad" : {"company": "' +
                        value.ad.company.toString() +
                        '" , "url" : "' +
                        value.ad.url.toString() +
                        '" , "text" : "' +
                        value.ad.text.toString() +
                        '"}';
                    outputList = "";
                    for(int i=0; i<value.data.length; i++){
                      outputList = outputList + "[ " +value.data[i].firstName+" "+value.data[i].lastName +"("+value.data[i].id.toString()+") ] ";
                    }
                    setState(() {

                    });
                  });
                },
                child: Text("GET LIST"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
