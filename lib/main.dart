import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

void main() {
// render
  runApp(MaterialApp(
    title: "BMI calculator",
    theme: ThemeData(fontFamily: 'Bebas'),
    home: new Home(),
  ));
}

//STATEFULL
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightC = new TextEditingController();
  TextEditingController heightC = new TextEditingController();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String _infoText = "Enter Your data";

  void _resetFields() {
    weightC.text = "";
    heightC.text = "";
    //att screen
    setState(() {
      _infoText = "Enter your data";
      _formKey = GlobalKey<FormState>();
    });
  }

  void calculate() {
    setState(() {
      double weight = double.parse(weightC.text);
      double height = double.parse(heightC.text) / 100; //to meter
      double imc = weight / (height * height);
      if (imc < 18.6) {
        _infoText = " underweight range | BMI:  ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Healthy Weight range | BMI: ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "overweight range | BMI: ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "obese range I | BMI:"
            "${imc.toStringAsPrecision(4)}";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "obese range II | BMI:"
            "${imc.toStringAsPrecision(4)}";
      } else if (imc >= 40.0) {
        _infoText = "obese range III | BMI:"
            "${imc.toStringAsPrecision(4)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.black,
        appBar: GradientAppBar(
          backgroundColorStart: Colors.purple,
          backgroundColorEnd: Colors.indigo,
          title: Text("BMI CALCULATOR",
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.normal)),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
              color: Colors.white,
              iconSize: 30.0,
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Stack(children: <Widget>[

                  Image.asset("images/background.jpg",
                    fit: BoxFit.cover,
                    height: 800.0,

                  ),
                  Container(
                    height: 800.0,
                    color: Colors.black54,
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 150.0, 15.0, 100.0),
                    child: Column(
                      //parametro para ocupar toda a largura horizontal.

                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[


                        //INPUT 1:
                        TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              enabledBorder: new UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white)),
                              labelText: "  WEIGHT  (KG)",
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white, fontSize: 30.0),
                            controller: weightC,
                            // ignore: missing_return
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Enter your weight!";
                              }
                            }),

                        //INPUT 2:

                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              enabledBorder: new UnderlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white)),
                              labelText: "  HEIGHT  (CM)",
                              labelStyle: TextStyle(color: Colors.white)),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontSize: 30.0),
                          controller: heightC,
                          // ignore: missing_return
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Enter your height!";
                            }
                          },
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                          child: Container(
                            //shadow
                            decoration: new BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 50.0,
                                // has the effect of softening the shadow
                                spreadRadius: 0.5,
                                // has the effect of extending the shadow
                                offset: Offset(
                                  10.0, // horizontal, move right 10
                                  10.0, // vertical, move down 10
                                ),
                              )
                            ]),
                            //end shadow
                            height: 50.0,

                            //BUTTON
                            child: RaisedButton(
                              //ON CLICK :

                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  calculate();
                                }
                              },

                              child: Text("CALCULATE",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30.0)),
                              color: Colors.deepPurple,
                            ),
                          ),
                        ),

                        FlatButton(
                            child: Text(_infoText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30.0)),
                            onPressed: () {}),
                      ],
                    ),
                  ),
                ])
                //MY ALTERATIONS---

                //COLUMN HERE----:
                ))

        //scroll screen
        );
  }
}
