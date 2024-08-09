import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
            bodyMedium:TextStyle(color: Colors.white)

        ),
      ),

      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 50;
  double resultFontSize = 38;

  buttonPressed(buttonText) {
    setState(() {
      if(buttonText=="C"){
        equation="0";
        result="0";
      }else if(buttonText=="⌫"){
        equationFontSize = 50;
        resultFontSize = 38;
        equation=equation.substring(0,equation.length-1);
        if(equation==""){
          equationFontSize = 50;
          resultFontSize = 38;
          equation="0";
        }
      }else if(buttonText=="=") {
        equationFontSize = 38;
        resultFontSize = 48;
        expression=equation;

        expression=expression.replaceAll("×", "*");
        expression=expression.replaceAll("÷", "/");
        try{
          Parser p=Parser();
          Expression exp =p.parse(expression);
          ContextModel cm=ContextModel();
          result ='${exp.evaluate(EvaluationType.REAL, cm)}';

        }catch(e){
          result ="error";
        }
      }
      else{
        equationFontSize = 50;
        resultFontSize = 38;
        if(equation=="0"){equation=buttonText;}//agar kuch kai nhi toh buttontext hi aaega na
        else {
          equation = equation + buttonText;
        }

      }
    });
  }


  Widget buildButton(String buttonText, double buttonheight, Color buttoncolor,Color backgroundcolor ) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child:  Container(
        height: MediaQuery.of(context).size.height * .1 * buttonheight, //10 percent area
        color: buttoncolor,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: backgroundcolor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(
                  color: Colors.white,
                  width: 1,
                  style: BorderStyle.solid
              ),
            ),
            padding: const EdgeInsets.all(16),
          ),
          child: Text(buttonText,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.normal,
              color: Colors.white,

            ),
          ),
          onPressed: () => buttonPressed(buttonText),
        ),


      ),
    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
      ),
      body: Column(
        children: [
          //expression input
          // Expression input
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.fromLTRB(10, 20, 30, 0),
                child: Text(
                  equation,
                  style: TextStyle(fontSize: equationFontSize),
                  overflow: TextOverflow.visible, // Allows text to overflow without clipping
                ),
              ),
            ),
          ),


          //result output
          Expanded(
              child:
              SingleChildScrollView(scrollDirection: Axis.horizontal,
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.fromLTRB(10, 20, 30,0),
                  child: Text(
                    result,
                    style: TextStyle(fontSize: resultFontSize),
                    overflow: TextOverflow.visible, // Allows text to overflow without clipping,
                  ),
                ),
              )
          ),

          const Expanded(child: Divider(),),

          //row 1-- numbers ,row 2-- signs
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                width: MediaQuery.of(context).size.width * .75, //75 percent area
                child: Table(
                  children: [
                    //contain 3 number
                    TableRow(
                        children: [
                          //single number container
                          buildButton("C", 1, Colors.transparent,Colors.pinkAccent),
                          buildButton("⌫", 1, Colors.transparent,Colors.pinkAccent),
                          buildButton("÷", 1, Colors.transparent,Colors.pinkAccent),
                        ]
                    ),

                    TableRow(
                        children: [
                          //single number container
                          buildButton("1", 1, Colors.transparent,Colors.black87),
                          buildButton("2", 1, Colors.transparent,Colors.black87),
                          buildButton("3", 1, Colors.transparent,Colors.black87),
                        ]
                    ),
                    TableRow(
                        children: [
                          //single number container
                          buildButton("4", 1, Colors.transparent,Colors.black87),
                          buildButton("5", 1, Colors.transparent,Colors.black87),
                          buildButton("6", 1, Colors.transparent,Colors.black87),
                        ]
                    ),
                    TableRow(
                        children: [
                          //single number container
                          buildButton("7", 1, Colors.transparent,Colors.black87),
                          buildButton("8", 1, Colors.transparent,Colors.black87),
                          buildButton("9", 1, Colors.transparent,Colors.black87),
                        ]
                    ),
                    TableRow(
                        children: [
                          //single number container
                          buildButton(".", 1, Colors.transparent,Colors.black87),
                          buildButton("0", 1, Colors.transparent,Colors.black87),
                          buildButton("00", 1, Colors.transparent,Colors.black87),
                        ]
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * .25,
                child: Table(
                  children: [


                    TableRow(
                        children: [
                          buildButton("×", 1, Colors.transparent,Colors.pinkAccent),

                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("-", 1, Colors.transparent,Colors.pinkAccent),

                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("+", 1, Colors.transparent,Colors.pinkAccent),

                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("=", 2, Colors.transparent,Colors.pinkAccent),

                        ]
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}