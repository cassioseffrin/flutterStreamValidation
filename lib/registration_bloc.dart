/*
* Author: Cassio Seffrin
* email: cassioseffrin@gmail.com
*/

import 'package:StreamValidation/validate.dart';
import 'package:rxdart/rxdart.dart';

class RegistrationBloc with Validation {
  final _email = BehaviorSubject<String>();
  Stream<String> get email$ => _email.stream.transform(eMailValidate);
  void setEmail(String value) => _email.sink.add(value);
  void clearEmail() => _email.sink.add(null);
  String get geEmailTxt => _email.value;

  final _password = BehaviorSubject<String>();
  Stream<String> get password$ => _password.stream.transform(passwordValidate);
  void setPassword(String value) => _password.sink.add(value);
  void clearPassword() => _password.sink.add('');
  String get gePasswordStr => _password.value;

  final _confirmPassword = BehaviorSubject<String>();
  Stream<String> get confirmPassword$ =>
      _confirmPassword.stream.transform(passwordValidate).doOnData((String c) {
        if (0 != gePasswordStr.compareTo(c)) {
          _confirmPassword.addError("The passwords do not match");
        }
      });

  void setConfirmPassword(String value) => _confirmPassword.sink.add(value);
  void clearConfirmPassword() => _confirmPassword.sink.add(null);
  String get geConfirmPasswordStr => _confirmPassword.value;

  void dispose() {
    _email?.close();
    _password?.close();
    _confirmPassword?.close();
  }
}
