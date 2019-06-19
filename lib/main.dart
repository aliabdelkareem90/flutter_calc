import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

main() => runApp(MyCalc());

class MyCalc extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			debugShowCheckedModeBanner: false,
			home: _MyCalcPage(),
			theme:
				new ThemeData(primaryColor: Colors.teal, accentColor: Colors.white),
		);
	}
}

class _MyCalcPage extends StatefulWidget {
	@override
	State<StatefulWidget> createState() => _MyCalcPageState();
}

class _MyCalcPageState extends State<_MyCalcPage> {
  String result = "0", _result = "0";
  int num1 = 0, num2 = 0;
  String operand = "";

  buttonPressed(String btnText) {
    if (btnText == "CLEAR") {
      _result = "0";
      num1 = num2 = 0;
      operand = "";
    } else if (btnText == '+' || btnText == '-' || btnText == '*' || btnText == '/') {
      num1 = int.parse(result);
      operand = btnText;
      _result = '0';
    } else if (btnText == '=') {
      num2 = int.parse(result);
      if (operand == '+') { _result = (num1 + num2).toString(); }
      if (operand == '-') { _result = (num1 - num2).toString(); }
      if (operand == '*') { _result = (num1 * num2).toString(); }
      if (operand == '/') { _result = (num1 / num2).toString(); }

      num1 = num2 = 0;
      operand = "";
    } else {
      _result = _result + btnText;
    }

    this.setState(() => { result = int.parse(_result).toString()});
  }
	
	Widget createButton(String btnText) {
		if (btnText == '/' || btnText == '*' || btnText == '-' || btnText == '+') {
      return RaisedButton(
        splashColor: Theme.of(context).accentColor,
        color: Theme.of(context).primaryColor,
        child: new Text(btnText,
          style: TextStyle(
            fontSize: 20.0, color: Theme.of(context).accentColor)),
        onPressed: () {buttonPressed(btnText);},
		  );
    } else {
      return OutlineButton(
        splashColor: Theme.of(context).primaryColor,
        child: new Text(btnText,
          style: TextStyle(
            fontSize: 20.0, color: Theme.of(context).primaryColor)),
        onPressed: () {buttonPressed(btnText);},
		  );
    }
	}

	Widget build(BuildContext context) {
		return Scaffold(
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget> [
          Column(
            children: <Widget> [
              Container(
                padding: EdgeInsets.symmetric(vertical:50, horizontal: 20),
                alignment: Alignment.topRight,
                child: new Text(result, style: new TextStyle(fontSize: 50.0, color: Colors.teal,),),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: new Text(operand, style: new TextStyle(fontSize: 35.0, color: Colors.teal,),),
              ),
              Divider()
            ]
          ),
          Container(
            height: 445,
              child: new GridView.count(
              crossAxisCount: 4,
              childAspectRatio: 1.0,
              padding: const EdgeInsets.all(4.0),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              children: <String>[
                '7','8','9','/',
                '4','5','6','*',
                '1','2','3','-',
                'CLEAR','0','=','+',
              ].map((String txt) {
                return new GridTile(
                  child: createButton(txt)
                );
              }
            ).toList()),
          ),
        ]
      ),
		);
	}
}
