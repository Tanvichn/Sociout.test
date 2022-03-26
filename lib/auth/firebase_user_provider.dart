import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class Sociout2FirebaseUser {
  Sociout2FirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

Sociout2FirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<Sociout2FirebaseUser> sociout2FirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<Sociout2FirebaseUser>(
            (user) => currentUser = Sociout2FirebaseUser(user));
