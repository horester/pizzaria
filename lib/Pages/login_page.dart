import 'package:flutter/material.dart';
import 'package:horester/Pages/singup_pages.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:horester/models/user_models.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scafoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
        appBar: AppBar(
          title: Text("Entrar"),
          centerTitle: true,
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Criar Conta",
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SingUpPage()));
              },
            ),
            FlatButton(
              child: Text(
                "Voltar",
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            )
          ],
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if(model.isLoading){
              return Center(child: CircularProgressIndicator(),);
            }
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(hintText: "Email"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text.isEmpty || !text.contains("@")) {
                        return "Email Invalido";
                      }
                    },
                  ),
                  TextFormField(
                      controller: _passController ,
                      decoration: InputDecoration(hintText: "Senha"),
                      obscureText: true,
                      validator: (text) {
                        if (text.isEmpty || text.length < 6) {
                          return "Email Invalido";
                        }
                      }),
               
                  SizedBox(
                    height: 16.0,
                  ),
                  RaisedButton(
                    child: Text(
                      "Entrar",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {}
                      model.singIn(email: _emailController.text , pass: _passController.text, onSucces: _onSuccess, onFail: _onFail);
                    },
                  )
                ],
              ),
            );
          },
        )
        );
  }
  void _onSuccess() {
   Navigator.of(context).pushReplacement(
     MaterialPageRoute(builder: (context)=> HomePage())
   );
  }
  void _onFail() {
  _scafoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Falha ao fazer login"),
          backgroundColor: Theme.of(context).primaryColor,
          duration: Duration(seconds: 2),
        )
      );
      Future.delayed(Duration(seconds: 2)).then((value){
        Navigator.of(context).pop;
      });
  }
}

