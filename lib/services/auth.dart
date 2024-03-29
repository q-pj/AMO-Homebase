import 'package:amo/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:amo/services/database.dart';
//import 'package:amo/screens/authenticate/register.dart';

class AuthService {

	final FirebaseAuth _auth = FirebaseAuth.instance;

	// create user object based on firebaseuser
	User _userFromFirebaseUser(FirebaseUser user){
		return user != null ? User(uid: user.uid) : null;
	}

	Stream<User> get user {
		return _auth.onAuthStateChanged
			.map(_userFromFirebaseUser);
	}

	Future signInWithEmailAndPassword(String email, String password) async {
		try{
			AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
			FirebaseUser user = result.user;

			return _userFromFirebaseUser(user);
		} catch(e){
			print(e.toString());
			return null;
		}
	}

	// Register with email and password
	Future registerWithEmailAndPassword(String email, String password) async { //, String firstname, String lastname) async {
		try{
			AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password); //, firstname: firstname, lastname: lastname);
			FirebaseUser user = result.user;
			return _userFromFirebaseUser(user);
		} catch(e){
			print(e.toString());
			return null;
		}
	}

	//Sign out
	Future signOut() async {
		try{
			return await _auth.signOut();
		} catch(e){
			print(e.toString());
			return null;
		}
	}
}