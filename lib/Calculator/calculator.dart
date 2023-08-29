import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'color.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = '';
  var output = '';
  var operator = '';

  onButtonClick(value) {
    if (value == "C") {
      input = '';
      output = '';
    } else if (value == "<=") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
      }
      input = output;
    } else {
      input = input + value;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              child: Container(
                color: Color.fromRGBO(35, 35, 35, 1),
                width: double.infinity,
                padding: EdgeInsets.all(2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      input,
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,

                      padding: EdgeInsets.all(15),
                      child: Text(
                        output,
                        style: TextStyle(
                          fontSize: 70,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Row(
            children: [
              button(
                  text: "C",
                  buttonBgColor: operatorColor,
                  tColor: orangeColor),
              button(text: "", buttonBgColor: Colors.transparent),
              button(
                  text: "<=",
                  buttonBgColor: operatorColor,
                  tColor: orangeColor),
              button(
                  text: "/", buttonBgColor: operatorColor, tColor: orangeColor),
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(
                  text: "x", tColor: orangeColor, buttonBgColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(
                  text: "-", tColor: orangeColor, buttonBgColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(
                  text: "+", tColor: orangeColor, buttonBgColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(
                  text: "%", tColor: orangeColor, buttonBgColor: operatorColor),
              button(text: "0"),
              button(text: "."),
              button(text: "=", tColor: orangeColor, buttonBgColor: operatorColor),
            ],
          )
        ],
      ),
    );
  }

  Widget button({
    text,
    tColor = Colors.black87,
    buttonBgColor = buttonColor,
  }) {
    return Expanded(
        child: Container(
          margin: const EdgeInsets.all(8),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(26),
              primary: buttonBgColor,
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(40), // Adjust the radius as needed
              ),
            ),
            onPressed: () => onButtonClick(text),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 30,
                color: tColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ));
  }
}
