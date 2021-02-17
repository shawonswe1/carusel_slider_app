import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Carousel Slider',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var slider;
  Future getSlider() async {
    var response = await http.get("https://queendohs.com/android/banner.php");
    setState(() {
      var decode = json.decode(response.body);
      slider = decode;
      print(slider);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getSlider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carousel Slider"),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 180,
            child: CarouselSlider.builder(itemCount: slider==null?0:slider.length,
                itemBuilder: (BuildContext context, index,item) {
                  return Image.network("https://queendohs.com/"+slider[index]['images'],fit: BoxFit.fill,
                    width: double.infinity,);
                },
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                  aspectRatio: 1.0,
                  initialPage: 2,
                )

            ),
          ),
        ],
      )
    );
  }
}