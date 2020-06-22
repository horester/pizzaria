import 'package:flutter/material.dart';
import 'package:horester/Pages/login_page.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:horester/models/user_models.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Horester Pizzaria"),
            centerTitle: true,
             actions: <Widget>[
               !model.isLogged() ?
            FlatButton(
              child: Text(
                "Acessar",
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            )
            :
            FlatButton(
              child: Text(
                "Sair",
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              onPressed: () {
                model.singOut();                
              },
            )
          ],
          ),
          body: Text(
            "Bem Vindo ${!model.isLogged() ? "" : model.userData["name"]}",
            style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
