import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
void main(){
  runApp(MaterialApp(
      home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController numero1Controller = TextEditingController();
  TextEditingController numero2Controller = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = 'Resultado: 0';
  bool condition = false;

  void _resetFields() {
    numero1Controller.text = '';
    numero2Controller.text = '';
    setState(() {
      _infoText = 'Resultado: 0';
      FocusScope.of(context).requestFocus(new FocusNode());
    });
  }

  void calculate(String operacao) {
    if (isNumeric(numero1Controller.text) &&
        isNumeric(numero2Controller.text)) {
      setState(() {
        double n1 = double.parse(numero1Controller.text);
        double n2 = double.parse(numero2Controller.text);

        double total = 0;
        if (operacao == "+") {
          total = n1 + n2;
        } else if (operacao == "-") {
          total = n1 - n2;
        } else if (operacao == "*") {
          total = n1 * n2;
        } else {
          total = n1 / n2;
        }
        _infoText = "Resultado: " + total.toStringAsPrecision(4);
      });
  }else{
      _showDialog('Aviso','Preencha somente números.');
  }
}

  @override
  void initState() {
    super.initState();

    numero1Controller.addListener(() {
     btnReset();
    });
    numero2Controller.addListener(() {
      btnReset();
    });
  }

  void btnReset(){
    setState(() {
      if(numero1Controller.text.isNotEmpty || numero2Controller.text.isNotEmpty) {
        condition = true;
      }else{
        condition = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          appBar: AppBar(
            title: Text('Calculadora'),
            backgroundColor: Colors.blueAccent,
            actions: <Widget>[
          Opacity(
          opacity: this.condition ? 1.0 : 0.0,//define a opacidade conforme o preenchimento dos campos.
              child: ButtonTheme(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: RaisedButton(
                    color: Colors.blueAccent,
                    textColor: Colors.white,
                    onPressed: () {
                      condition ? _resetFields() : null;//desativa o clique do botão.
                    },
                    child: Icon(Icons.delete),
                  )))

            ],
          ),//appbar
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Número 1",
                        labelStyle: TextStyle(color:Colors.blueAccent)
                    ),

                    style: TextStyle(color: Colors.blueAccent,fontSize: 25.0),
                    controller: numero1Controller,
                    validator: (value){
                      if(value.isEmpty){
                        return "Insira o número 1";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Número 2",
                        labelStyle: TextStyle(color:Colors.blueAccent)
                    ),

                    style: TextStyle(color: Colors.blueAccent,fontSize: 25.0),
                    controller: numero2Controller,
                    validator: (value){
                      if(value.isEmpty){
                        return "Insira o número 2";
                      }
                    },
                  ),

                  ButtonTheme.bar(
                    child:  ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: (){
                            if(_formKey.currentState.validate()){
                              calculate('+');
                            }
                          },
                          child: Text("+",style: TextStyle(color: Colors.white, fontSize: 25.0)),
                          color:Colors.blueAccent,
                        ),
                        RaisedButton(
                          onPressed: (){
                            if(_formKey.currentState.validate()){
                              calculate('-');
                            }
                          },
                          child: Text("-",style: TextStyle(color: Colors.white, fontSize: 25.0)),
                          color:Colors.blueAccent,
                        ),
                        RaisedButton(
                          onPressed: (){
                            if(_formKey.currentState.validate()){
                              calculate('*');
                            }
                          },
                          child: Text("*",style: TextStyle(color: Colors.white, fontSize: 25.0)),
                          color:Colors.blueAccent,
                        ),
                        RaisedButton(
                          onPressed: (){
                            if(_formKey.currentState.validate()){
                              calculate('/');
                            }
                          },
                          child: Text("/",style: TextStyle(color: Colors.white, fontSize: 25.0)),
                          color:Colors.blueAccent,
                        )
                      ],
                    ),
                  ),
                  Text(_infoText,textAlign: TextAlign.center, style: TextStyle(color: Colors.blueAccent, fontSize: 25.0),
                  )
                ],
              ),
            ),
          )
      );
  }
  void _showDialog(String title,String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(message),
          actions: <Widget>[
            // define os botões na base do dialogo
            new FlatButton(
              child: new Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
