import 'package:amo/shared/loading.dart';
import 'package:amo/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:amo/shared/constants.dart';

class SignIn extends StatefulWidget {

	final Function toggleView;
	SignIn ({ this.toggleView });

	@override
	_SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn>{

	final AuthService _auth = AuthService();
	final _formKey = GlobalKey<FormState>();
	bool loading = false;

	String email = '';
	String password = '';
	String error = '';

	@override
	Widget build(BuildContext context){
		return loading ? Loading() : Scaffold(
			backgroundColor: Colors.grey[500],
			appBar: AppBar(
				backgroundColor: Color(0xFFA28629),
				title: Text('Sign in'),
				actions: <Widget> [
					FlatButton.icon(
						icon: Icon(Icons.person),
						label: Text('Register'),
						onPressed: () {
							widget.toggleView();
						},
					),
				],
			),

			body: Container(
				padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
				child: Form(

					key: _formKey,

					child: Column(
						children: <Widget>[

							SizedBox(height: 20.0),

							TextFormField(
								decoration: textInputDecoration.copyWith(hintText: 'Email'),
								validator: (val) => val.isEmpty ? 'Enter an email' : null,
								onChanged: (val) {
									setState(() => email = val);
								}
							),

							SizedBox(height: 20.0),

							TextFormField(
								decoration: textInputDecoration.copyWith(hintText: 'Password'),
								validator: (val) => val.length < 6 ? 'Enter a password 6 characters or more' : null,
								obscureText: true,
								onChanged: (val) {
									setState(() => password = val);
								}
							),

							SizedBox(height: 20.0),

							RaisedButton(
								color: Colors.white,
								child: Text('Sign in',
									style: TextStyle(color: Color(0xFFA28629)),
								),
								onPressed: () async {
									if(_formKey.currentState.validate()){
										setState(() => loading = true);
										dynamic result = await _auth.signInWithEmailAndPassword(email, password);
										if(result == null){
											setState(() => error = 'Could not sign in with those credentials');
											loading = false;
										}
									}
								},
							),

							SizedBox(height: 20.0),

							Text(error,
								style: TextStyle(color: Colors.red, fontSize: 14.0),
							),

						],					
					),
				),
			),
		);
	}
}