import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculator",
      theme: ThemeData(primarySwatch: Colors.blue),
      home :simpleCalculator(),
    );
  }
}

class simpleCalculator extends StatefulWidget {
  @override
  _simpleCalculatorState createState() => _simpleCalculatorState();
}

class _simpleCalculatorState extends State<simpleCalculator> {


  String equation = "0";
  String result = "0";
  String expression = "0";
  double eqfontsize = 38.0;
  double resfontsize = 48.0;

  buttonPressed(String buttonText){
    print(buttonText);
    setState(() {
      if(buttonText == "C"){
          equation = "0";
          result = "0";
          eqfontsize = 38.0;
          resfontsize = 48.0;
      }
      else if(buttonText =="⌫" ){
          equation = equation.substring(0,equation.length - 1);
          eqfontsize = 48.0;
          resfontsize = 38.0;
          if(equation == ""){
            equation ="0";
          }
      }
      else if(buttonText == "="){
        eqfontsize = 38.0;
        resfontsize = 48.0;

        expression = equation;
        expression = expression.replaceAll('÷', "/");
        expression = expression.replaceAll('×', "*");

        try{
          Parser p = Parser();

          Expression exp = p.parse(expression);
          //
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = "ERROR!";
        }
      }
      else{
        eqfontsize = 48.0;
        resfontsize = 38.0;
        if(equation =="0"){
          equation = buttonText;
        }else
        equation = equation + buttonText;
      }
    });
  }


  Widget buildButton(String buttonText,double height,Color buttonColor){
    return Container(
      height: MediaQuery.of(context).size.height * .1*height,
      color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(color: Colors.white,width: 1,style: BorderStyle.solid),
        ),
        padding: EdgeInsets.all(16),
        onPressed: () => buttonPressed(buttonText),
        child: Text(buttonText,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 30),),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CALCULATOR"),),
      body: Column(children: <Widget>[
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Text(equation,style: TextStyle(fontSize: eqfontsize,fontWeight: FontWeight.bold),),
        ),
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
          child: Text(result,style: TextStyle(fontSize: resfontsize,fontWeight: FontWeight.bold),),
        ),
        new Expanded(child: new Divider()),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * .75,
              child: Table(
                children: [
                  TableRow(
                    children: [
                      buildButton("C", 1, Colors.redAccent),
                      buildButton("⌫", 1, Colors.blue),
                      buildButton("÷", 1, Colors.blue),
                    ]
                  ),
                  TableRow(
                      children: [
                        buildButton("7", 1, Colors.black54),
                        buildButton("8", 1, Colors.black54),
                        buildButton("9", 1, Colors.black54),
                      ]
                  ),
                  TableRow(
                      children: [
                        buildButton("4", 1, Colors.black54),
                        buildButton("5", 1, Colors.black54),
                        buildButton("6", 1, Colors.black54),
                      ]
                  ),
                  TableRow(
                      children: [
                        buildButton("1", 1, Colors.black54),
                        buildButton("2", 1, Colors.black54),
                        buildButton("3", 1, Colors.black54),
                      ]
                  ),
                  TableRow(
                      children: [
                        buildButton(".", 1, Colors.black54),
                        buildButton("0", 1, Colors.black54),
                        buildButton("00", 1, Colors.black54),
                      ]
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .25,
              child: Table(
                children: [
                  TableRow(
                    children: [
                      buildButton("×", 1, Colors.blue),
                              ]
                          ),
                TableRow(
                  children: [
                    buildButton("+", 1, Colors.blue),
                  ]
                ),
                TableRow(
                  children: [
                    buildButton("-", 1, Colors.blue),
                ]
                ),
                  TableRow(
                    children: [
                      buildButton("=", 2, Colors.redAccent),
                  ]
                  ),
                          ],
                      ),
              ),
          ]
            ),
          ],
        ),
      );
  }
}
