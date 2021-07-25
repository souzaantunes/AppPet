import 'package:app/exceptions/auth_exception.dart';
import 'package:app/providers/Auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login }

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  GlobalKey<FormState> _form = GlobalKey();
  bool _isLoading = false;
  AuthMode _authMode = AuthMode.Login;
  final _passwordController = TextEditingController();
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Ocorreu um erro!'),
        content: Text(msg),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Fechar'),
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_form.currentState.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    _form.currentState.save();
    Auth auth = Provider.of(context, listen: false);
    try {
      if (_authMode == AuthMode.Login) {
        await auth.login(
          _authData["email"],
          _authData["password"],
        );
      } else {
        await auth.signup(
          _authData["email"],
          _authData["password"],
        );
      }
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog("Erro inesperado");
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Center(
      child: Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          // alignment: Alignment.center,
          height: _authMode == AuthMode.Login ? 290 : 371,
          width: deviceSize.width * 0.75,
          padding: EdgeInsets.all(16.0),
          child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return "Informe um email valido";
                      }
                      return null;
                    },
                    onSaved: (value) => _authData['email'] = value,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'senha'),
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty || value.length < 3) {
                        return "Informe uma senha valida";
                      }
                      return null;
                    },
                    onSaved: (value) => _authData['password'] = value,
                  ),
                  if (_authMode == AuthMode.Signup)
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Confirmar senha'),
                      obscureText: true,
                      validator: _authMode == AuthMode.Signup
                          ? (value) {
                              if (value != _passwordController.text) {
                                return "Senhas diferentes";
                              }
                              return null;
                            }
                          : null,
                    ),
                  Spacer(),
                  // SizedBox(height: 22),
                  if (_isLoading)
                    CircularProgressIndicator()
                  else
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: Theme.of(context).primaryColor,
                      textColor:
                          Theme.of(context).primaryTextTheme.button.color,
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 8.0,
                      ),
                      child: Text(
                        _authMode == AuthMode.Login ? 'ENTRAR' : 'REGISTRAR',
                      ),
                      onPressed: _submit,
                    ),
                  FlatButton(
                    onPressed: _switchAuthMode,
                    child: Text(
                        "Alternar P/${_authMode == AuthMode.Login ? 'REGISTRAR' : 'ENTRAR'}"),
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
