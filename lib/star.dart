import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class StarModel{
  String title;
  String description;
  String starIcon;
  DateTime date;
  Image image;

  StarModel({this.title, this.description, this.starIcon, this.date,
      this.image});
}

class Star extends StatefulWidget {
  StarModel model;

  Star(this.model);

  @override
  _StarState createState() => new _StarState();
}

class _StarState extends State<Star> {

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      width: 50,
      height: 50,
      child: FlareActor(
        widget.model.starIcon,
        alignment: Alignment.center,
        fit: BoxFit.contain,
        animation: "shine",
      ),
    );
  }


}
