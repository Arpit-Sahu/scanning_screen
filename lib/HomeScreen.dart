import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:scanningscreen/Constanta.dart';
import 'package:http/http.dart' as http;
import 'package:scanningscreen/Scanner.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
String? imageUrl;

  Future<void> getDetails() async
  {
    Uri url = Uri.parse("https://fakeface.rest/face/json");
    var response = await http.get(
      Uri.https(url.authority, url.path, url.queryParametersAll)
    );
    if(response.statusCode == 200)
    {
      String data = response.body;
      setState(() {
        imageUrl = jsonDecode(data)['image_url'];
      });
    }
  }

  @override
  void initState() {
    getDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(imageUrl == null)
    {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('Savings', textAlign: TextAlign.center, style: TextStyle(color: Colors.black),),
        leading: Icon(Icons.arrow_back, color: Colors.black,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text('Pay through UPI', style: kBoldTextStyle),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter UPI Number',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple, width: 1.5),
                ) ,
              ),
            ),
          ),
          Expanded(
            flex: 4,
                    child: BuildView(),
          ),
          SizedBox(height: 20),
          Text('Search Contact', style: kBoldTextStyle,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.contacts, color: Colors.purple,),
                  hintText: 'Select Number',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 1.5),
                  ) ,
                ),
              ),
            ),
            Expanded(
                child: ListView(
                children: [
                  Card(
                      child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(imageUrl!),
                      ),
                      title: Text('Sumanth Verma', style: TextStyle(fontWeight: FontWeight.w700),),
                      subtitle: Text('7350009088'),
                    ),
                  ),
                ]
              ),
            ),
        ],),
      ),
     
    );
  }
}