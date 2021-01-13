import 'package:flutter_svg/flutter_svg.dart';

import '../../helpers/global_scaffold.dart';
import '../../stores/auth.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthStore _authStore;

  bool isVisibility = true;

  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  Future _register() async {
    await _authStore
        .register(_name.text, _email.text, _password.text)
        .then((value) {
      value ? _auth() : null;
    });
  }

  Future<void> _auth() async {
    await _authStore.auth(_email.text, _password.text).then((value) {
      value ? Navigator.pushReplacementNamed(context, '/index') : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    _authStore = Provider.of<AuthStore>(context);

    return Scaffold(
      backgroundColor: Colors.blue[300],
      body: SingleChildScrollView(
          child: Observer(
        builder: (context) => bodyPage(),
      )),
    );
  }

  Widget bodyPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 50,
        ),
        Container(
          height: 200,
          child: SvgPicture.asset('assets/images/barber.svg'),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              loginInput(),
              _submitButton(),
              logIn(),
            ],
          ),
        ),
      ],
    );
  }

  Widget loginInput() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              _entryField(
                _name,
                false,
                "Name",
                Icon(Icons.person, color: Colors.black54),
              ),
              _entryField(
                _email,
                false,
                "Email",
                Icon(Icons.mail_outline, color: Colors.black54),
              ),
              _entryField(_password, false, "Password",
                  Icon(Icons.lock, color: Colors.black54),
                  isPassword: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _entryField(
      TextEditingController controller, bool focus, String title, Icon icon,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        autocorrect: false,
        autofocus: focus,
        obscureText: isPassword ? isVisibility : false,
        decoration: InputDecoration(
          fillColor: Colors.blue[200],
          filled: true,
          prefixIcon: icon,
          suffixIcon: isPassword
              ? IconButton(
                  icon: isVisibility
                      ? Icon(Icons.visibility_off, color: Colors.black54)
                      : Icon(Icons.visibility, color: Colors.black54),
                  onPressed: () {
                    setState(() {
                      isVisibility = !isVisibility;
                      print(isVisibility);
                    });
                  })
              : null,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue[200], width: 2.0),
            borderRadius: BorderRadius.circular(25.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.circular(25.0),
          ),
          labelText: title,
          labelStyle: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget _submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: 10),
      child: FlatButton(
        height: 50,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        color: Colors.blue[800],
        padding: EdgeInsets.all(8.0),
        onPressed: () => _authStore.isLoading ? null : _register(),
        child: Text(
          _authStore.isLoading ? 'Cadastrando...' : "Cadastrar".toUpperCase(),
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }

  Widget logIn() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.pushReplacementNamed(context, '/login');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ja Possui uma conta? ',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Text(
              'Faça Login',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }
}
