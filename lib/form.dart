/*
* Author: Cassio Seffrin
* email: cassioseffrin@gmail.com
*/

import 'package:StreamValidation/registration_bloc.dart';
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  FormPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  RegistrationBloc _blocRegistration;
  var _controllerEmail = TextEditingController();
  var _controllerConfirmPassword = TextEditingController();
  var _controllerPassword = TextEditingController();

  @override
  void initState() {
    _blocRegistration = RegistrationBloc();
    _controllerConfirmPassword = TextEditingController(text: '');
    _controllerPassword = TextEditingController(text: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: _buildForm(context),
      ),
    );
  }

  @override
  Widget _buildForm(BuildContext context) {
    return Column(
      children: <Widget>[
        StreamBuilder<Object>(
            stream: _blocRegistration.email$,
            builder: (context, snapshot) {
              return TextField(
                  controller: _controllerEmail,
                  onChanged: (value) {
                    _blocRegistration.setEmail(value);
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    errorText: snapshot.error,
                    suffixIcon: _controllerEmail.text.length > 0
                        ? IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              this.setState(() {
                                _controllerEmail.clear();
                              });
                            })
                        : null,
                    hintText: "E-mail",
                  ));
            }),
        StreamBuilder<Object>(
            stream: _blocRegistration.password$,
            builder: (context, snapshot) {
              return TextField(
                onChanged: (t) {
                  _blocRegistration.setPassword(t);
                },
                controller: _controllerPassword,
                obscureText: true,
                decoration: InputDecoration(
                  errorText: snapshot.error,
                  labelText: "Password",
                  suffixIcon: _controllerPassword.text.length > 0
                      ? IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            this.setState(() {
                              _controllerPassword.clear();
                            });
                          })
                      : null,
                ),
              );
            }),
        StreamBuilder<Object>(
            stream: _blocRegistration.confirmPassword$,
            builder: (context, snapshot) {
              return TextField(
                controller: _controllerConfirmPassword,
                onChanged: (value) {
                  _blocRegistration.setConfirmPassword(value);
                },
                obscureText: true,
                decoration: InputDecoration(
                  errorText: snapshot.error,
                  labelText: "Confirm the password",
                  suffixIcon: _controllerConfirmPassword.text.length > 0
                      ? IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            this.setState(() {
                              _controllerConfirmPassword.clear();
                            });
                          })
                      : null,
                ),
              );
            }),
      ],
    );
  }
}
