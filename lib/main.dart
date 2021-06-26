import 'package:flutter/material.dart';
import 'package:invert_colors/invert_colors.dart';
import 'package:string_validator/string_validator.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RGB Control',
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
  int flag = 0;

  // ignore: non_constant_identifier_names
  String HEXinput = "000000";

  String hexOfRGB(Color c) {
    return '#${c.value.toRadixString(16).substring(2)}';
  }

  Widget _getHEX(BuildContext context) {
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
                color: ((_redSlider >= 235 && _redSlider <= 255) &&
                        (_blueSlider >= 235 && _blueSlider <= 255) &&
                        (_greenSlider >= 235 && _greenSlider <= 255))
                    ? Colors.black
                    : (finalColor),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: hexOfRGB(finalColor)));
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Copied to clipboard!')));
            Navigator.pop(context);
          },
          child: InvertColors(
              child: Text(
            'Copy to clipboard',
            style: TextStyle(color: finalColor),
          )),
          style: ElevatedButton.styleFrom(
            elevation: 10,
            primary: finalColor,
          ),
        ),
        ElevatedButton(
            onPressed: Navigator.of(context).pop,
            child: InvertColors(
                child: Text(
              'Okay',
              style: TextStyle(color: finalColor),
            )),
            style: ElevatedButton.styleFrom(
              elevation: 10,
              primary: (finalColor),
            )),
      ],
    );
  }

  Widget _setHEX(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return AlertDialog(
      title: Text(
        'Enter HEX code',
        textAlign: TextAlign.center,
      ),
      content: Container(
        height: 200,
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (value) {
                      if (!isHexColor(value.toString())) {
                        return 'Enter valid HEX!';
                      }
                    },
                    onSaved: (value) {
                      setState(() {
                        HEXinput = value.toString().toLowerCase();
                        if (HEXinput.substring(0, 1) == "#") {
                          HEXinput = HEXinput.substring(1);
                        }
                      });
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        final form = _formKey.currentState;
                        if (_formKey.currentState!.validate()) {
                          form!.save();
                          Navigator.pop(context);
                          flag = 1;
                        }
                      },
                      child: Text('Ok'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("HEX:" + HEXinput);
    print(
        "R: ${int.parse(HEXinput.substring(0, 2), radix: 16)} G: ${int.parse(HEXinput.substring(2, 4), radix: 16)} B: ${int.parse(HEXinput.substring(4), radix: 16)}");
    if (flag == 1) {
      _redSlider = int.parse(HEXinput.substring(0, 2), radix: 16).toDouble();
      _greenSlider = int.parse(HEXinput.substring(2, 4), radix: 16).toDouble();
      _blueSlider = int.parse(HEXinput.substring(4), radix: 16).toDouble();
    }
    Color finalColor = Color.fromRGBO(
        _redSlider.toInt(), _greenSlider.toInt(), _blueSlider.toInt(), 1);
    return Scaffold(
      appBar: AppBar(
        title: InvertColors(
          child: Text(
            widget.title,
            style: TextStyle(color: finalColor),
          ),
        ),
        backgroundColor: finalColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(45, 20, 45, 30),
                child: Container(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        _redSlider.toInt().toString(),
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        _greenSlider.toInt().toString(),
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        _blueSlider.toInt().toString(),
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _redSlider = 0;
                      _greenSlider = 0;
                      _blueSlider = 0;
                    });
                  },
                  child: InvertColors(
                      child: Text(
                    'Reset',
                    style: TextStyle(fontSize: 20, color: finalColor),
                  )),
                  style: ElevatedButton.styleFrom(
                      elevation: 10, primary: finalColor),
                ),
              ),
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
                        builder: (BuildContext ctx) => _getHEX(ctx));
                  },
                  child: InvertColors(
                    child: Text(
                      'Get HEX',
                      style: TextStyle(fontSize: 20, color: finalColor),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    primary: finalColor,
                    onPrimary: (finalColor == Colors.white)
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              if (MediaQuery.of(context).orientation != Orientation.landscape)
                SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext ctx) => _setHEX(ctx));
                    },
                    child: InvertColors(
                      child: Text(
                        'Set HEX',
                        style: TextStyle(fontSize: 20, color: finalColor),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      primary: finalColor,
                      onPrimary: (finalColor == Colors.white)
                          ? Colors.black
                          : Colors.white,
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
                    inactiveTrackColor: Colors.red[100]),
                child: Slider(
                    value: _redSlider,
                    min: 0,
                    max: 255,
                    divisions: 255,
                    label: _redSlider.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _redSlider = value;
                        flag = 0;
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
                    inactiveTrackColor: Colors.green[100]),
                child: Slider(
                    value: _greenSlider,
                    min: 0,
                    max: 255,
                    divisions: 255,
                    label: _greenSlider.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _greenSlider = value;
                        flag = 0;
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
                    inactiveTrackColor: Colors.blue[100]),
                child: Slider(
                    value: _blueSlider,
                    min: 0,
                    max: 255,
                    divisions: 255,
                    label: _blueSlider.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _blueSlider = value;
                        flag = 0;
                      });
                    }),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: finalColor,
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: ((_redSlider >= 235 && _redSlider <= 255) &&
                            (_blueSlider >= 235 && _blueSlider <= 255) &&
                            (_greenSlider >= 255 && _greenSlider <= 255))
                        ? Colors.black
                        : finalColor,
                    width: 2.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
