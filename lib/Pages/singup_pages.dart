import 'package:flutter/material.dart';
import 'package:horester/Pages/login_page.dart';
import 'package:horester/models/user_models.dart';
import 'package:scoped_model/scoped_model.dart';

import 'home_page.dart';

class SingUpPage extends StatefulWidget {

  @override
  _SingUpPageState createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  final _nameController = TextEditingController();
  final _cpfController = TextEditingController();
  final _celularController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scafoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
        appBar: AppBar(
          title: Text("Criar Conta"),
          centerTitle: true,
           actions: <Widget>[
            FlatButton(
              child: Text(
                "Já tenho conta",
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()));
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
                    controller: _nameController,
                    decoration: InputDecoration(hintText: "Nome Completo"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text.isEmpty) {
                        return "Preencha este campo";
                      }
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  
                  TextFormField(
                    controller: _cpfController,
                    decoration: InputDecoration(hintText: "CPF"),
                    keyboardType: TextInputType.number,
                    validator: (text) {
                      if (text.isEmpty || text.length < 14) {
                        return "CPF invalido";
                      }
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _celularController,
                    decoration: InputDecoration(hintText: "Celular"),
                    keyboardType: TextInputType.number,
                    validator: (text) {
                      if (text.isEmpty) {
                        return "Celular invalido";
                      }
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
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
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _passController,
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
                      "Criar conta",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Map<String, dynamic> userData = {
                          "name": _nameController.text,
                          "cpf": _cpfController.text,
                          "cel": _celularController.text,
                          "email": _emailController.text
                        };
                        model.singUp(userData: userData, pass: _passController.text, onSucess: _onSuccess, onFail: _onFail);
                      }
                    },
                  )
                ],
              ),
            );
          },
        ));
  }
  void _onSuccess() {
    _scafoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text("Usuario criado com sucesso"),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 2),
      )
    );
    Future.delayed(Duration(seconds: 2)).then((value){
        Navigator.of(context).pop;
      });
  }
  void _onFail() {
  _scafoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Usuario criado com sucesso"),
          backgroundColor: Theme.of(context).primaryColor,
          duration: Duration(seconds: 2),
        )
      );
      Future.delayed(Duration(seconds: 2)).then((value){
        Navigator.of(context).pop;
      });
  }
}

