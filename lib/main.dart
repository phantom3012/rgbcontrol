import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

void main() {
  // SystemChrome.setPreferredOrientations(
  //         [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp])
  //     .then((_) => runApp(MyApp()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'RGB Control'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _redSlider = 0;
  double _blueSlider = 0;
  double _greenSlider = 0;

  String hexOfRGB(Color c) {
    return '#${c.value.toRadixString(16).substring(2)}';
  }

  Widget _popupHEX(BuildContext context) {
    Color finalColor = Color.fromRGBO(
        _redSlider.toInt(), _greenSlider.toInt(), _blueSlider.toInt(), 1);
    return AlertDialog(
      title: Text(
        'HEX code:',
        textAlign: TextAlign.center,
      ),
      content: Container(
        height: 100,
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              hexOfRGB(finalColor),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: (finalColor == Colors.white) ? Colors.black : finalColor,
              ),
            )
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
            onPressed: Navigator.of(context).pop,
            child: Text('Okay'),
            style: ElevatedButton.styleFrom(
              elevation: 10,
              primary: (finalColor),
              onPrimary:
                  (finalColor == Colors.white) ? Colors.black : Colors.white,
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Color finalColor = Color.fromRGBO(
        _redSlider.toInt(), _greenSlider.toInt(), _blueSlider.toInt(), 1);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext ctx) => _popupHEX(ctx));
                },
                child: Text(
                  'Get HEX',
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  primary: finalColor,
                  onPrimary: (finalColor == Colors.white) ? Colors.black : Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                onPressed: () {}, 
                child: Text(
                  'Set HEX',
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  primary: finalColor,
                  onPrimary: (finalColor == Colors.white) ? Colors.black : Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Red',
              style: TextStyle(
                color: Colors.red,
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            SliderTheme(
              data: SliderThemeData(
                thumbColor: Colors.red,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 20),
                activeTrackColor: Colors.red,
              ),
              child: Slider(
                  value: _redSlider,
                  min: 0,
                  max: 255,
                  divisions: 255,
                  label: _redSlider.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _redSlider = value;
                    });
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Green',
              style: TextStyle(
                color: Colors.green,
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            SliderTheme(
              data: SliderThemeData(
                thumbColor: Colors.green,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 20),
                activeTrackColor: Colors.green,
              ),
              child: Slider(
                  value: _greenSlider,
                  min: 0,
                  max: 255,
                  divisions: 255,
                  label: _blueSlider.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _greenSlider = value;
                    });
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Blue',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            SliderTheme(
              data: SliderThemeData(
                thumbColor: Colors.blue,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 20),
                activeTrackColor: Colors.blue,
              ),
              child: Slider(
                  value: _blueSlider,
                  min: 0,
                  max: 255,
                  divisions: 255,
                  label: _greenSlider.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _blueSlider = value;
                    });
                  }),
            ),
            SizedBox(
              height: 30,
            ),
            // Text('Red Slider value ${_redSlider.toInt()}'),
            // Text('Blue Slider value ${_blueSlider.toInt()}'),
            // Text('Green Slider value ${_greenSlider.toInt()}'),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: finalColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: (_redSlider == 255 &&
                          _blueSlider == 255 &&
                          _greenSlider == 255)
                      ? Colors.black
                      : finalColor,
                  width: 2.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
