import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _opacity = 0.0;
  var _ifLogin = false;

  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration(milliseconds: 400), (){
        setState(() => _opacity = 1.0);
      });

      await Future.delayed(Duration(seconds: 3), (){
        setState(() => _opacity = 0.0);
      });

      await Future.delayed(Duration(milliseconds: 600), (){
        setState(() => _ifLogin = true);
      });

      await Future.delayed(Duration(milliseconds: 200), (){
        setState(() => _opacity = 1.0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: AnimatedOpacity(
              opacity: _opacity,
              duration: Duration(milliseconds: 500),
              child: Center(
                  child: _ifLogin
                      ? Container(
                      constraints: BoxConstraints(maxWidth: 350),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextField(
                            decoration: InputDecoration(
                              hintText: "Login",
                            ),
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Padding(padding: EdgeInsets.only(top: 15.0)),
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Senha",
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Padding(padding: EdgeInsets.only(top: 25.0)),
                          SizedBox(
                            height: 50.0,
                            width: double.infinity,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              color: Color(0xFF000080),
                              textColor: Color(0xFFFFFFFF),
                              onPressed: () {},
                              child: new Text(
                                "Entrar",
                              ),
                            ),
                          )
                        ],
                      ))
                      : FractionallySizedBox(
                    heightFactor: 0.2,
                    child: Image.asset('assets/images/logo_dcomp.jpg'),
                  )))),
    );
  }
}