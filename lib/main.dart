import 'package:astra/star.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Astra',
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
  List<StarModel> _starsModels;

  @override
  void initState() {
    _starsModels = [
      StarModel(
        title: "Starting Astra",
        description:
        "Start coding the app from scratch, just makeing the idea real.",
        starIcon: "assets/greenStar.flr",
        date: DateTime.parse("2019-02-24"),
        image: Image.asset("assets/starImage1.jgep"),
      ),
      StarModel(
        title: "First bug found D:",
        description:
        "I used a bad callback on .map function. (FIXED)",
        starIcon: "assets/greenStar.flr",
        date: DateTime.parse("2019-02-24"),
        image: Image.asset("assets/starImage2.png"),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SizedBox.expand(
      child: Stack(
        children: <Widget>[
          _buildBg(),
          _buildStars(),
        ],
      ),
    );
  }

  Widget _buildBg() {
    return Positioned.fill(
      child: FlareActor(
        "assets/astra.flr",
        alignment: Alignment.center,
        fit: BoxFit.contain,
        animation: "main",
      ),
    );
  }

  Widget _buildStars() {
    return SafeArea(
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        direction: Axis.horizontal,
        children: _starsModels.map((model)=>Star(model)).toList(),
      ),
    );
  }
}
