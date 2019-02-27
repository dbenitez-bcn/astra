import 'package:astra/star.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
  List<Star> _starsModels;
  Star _starSelected;
  PageController _pageController;
  Image imageNew;
  TextEditingController tfTitle = TextEditingController();
  TextEditingController tfDesc = TextEditingController();

  void goToPage(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
  }

  @override
  void initState() {
    _starsModels = [];
    _pageController = PageController(initialPage: 1);
    imageNew = Image.asset("assets/noImage.png");
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      floatingActionButton: _buildFab(),
    );
  }

  Widget _buildBody() {
    return SizedBox.expand(
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: _buildFlareActor("assets/astra.flr", "main"),
          ),
          _buildPageView(),
        ],
      ),
    );
  }

  Widget _buildFab() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => goToPage(2),
    );
  }

  Widget _buildPageView() {
    return PageView(
      controller: _pageController,
      children: <Widget>[
        _buildSelected(),
        _buildStars(),
        _buildCreateStar(),
      ],
    );
  }

  Widget _buildFlareActor(sprite, animation) {
    return FlareActor(
      sprite,
      alignment: Alignment.center,
      fit: BoxFit.fitWidth,
      animation: animation,
    );
  }

  Widget _buildStars() {
    return SafeArea(
      child: Wrap(
          direction: Axis.horizontal,
          children: _starsModels
              .map((model) => GestureDetector(
                    onTap: () {
                      setState(() => _starSelected = model);
                      goToPage(0);
                    },
                    child: _buildStarIcon(model.starIcon, 60.0),
                  ))
              .toList()),
    );
  }

  Widget _buildStarIcon(String sprite, double size) {
    return SizedBox(
      width: size,
      height: size,
      child: _buildFlareActor(sprite, "shine"),
    );
  }

  Widget _buildSelected() {
    return _starSelected != null
        ? _buildMyCard(
            <Widget>[
              ListTile(
                leading: _buildStarIcon(_starSelected.starIcon, 48.0),
                title: Text(_starSelected.title),
                subtitle: Text(_starSelected.description),
              ),
              Container(
                  margin: EdgeInsets.all(16.0), child: _starSelected.image),
            ],
          )
        : _buildStarIcon("assets/greenStar.flr", 64.0);
  }

  Widget _buildCreateStar() {
    return _buildMyCard(
      <Widget>[
        TextField(
          controller: tfTitle,
          decoration: InputDecoration(labelText: "Title"),
        ),
        TextField(
          controller: tfDesc,
          decoration: InputDecoration(labelText: "Description"),
        ),
        SizedBox.fromSize(size: Size.square(8.0)),
        Container(
          height: 200.0,
          child: GestureDetector(
            onTap: () async {
              imageNew = Image.file(
                  await ImagePicker.pickImage(source: ImageSource.camera));
              setState(() {});
            },
            child: imageNew,
          ),
        ),
        RaisedButton(
          child: Text("Add star"),
          onPressed: () {
            Star newStar = Star(
                title: tfTitle.text,
                description: tfDesc.text,
                starIcon: "assets/purpleStar.flr",
                image: imageNew);
            setState(() {
              imageNew = Image.asset("assets/noImage.png");
              _starsModels.add(newStar);
              goToPage(1);
            });
          },
        )
      ],
    );
  }

  Widget _buildMyCard(List<Widget> children) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: children),
          ),
        ),
      ),
    );
  }
}
