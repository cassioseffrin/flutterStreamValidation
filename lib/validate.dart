/*
* Author: Cassio Seffrin
* email: cassioseffrin@gmail.com
*/

import 'dart:async';

mixin Validation {
  final eMailValidate =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (value.length == 0) {
      sink.addError('Enter the e-mail');
    } else if (!value.contains('@')) {
      sink.addError('The e-mail is invalid!');
    } else {
      sink.add(value);
    }
  });

  final passwordValidate =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (value.length == 0) {
      sink.addError('Enter the password');
    } else if (value.length < 6) {
      sink.addError('The password must have at least 6 characters');
    } else {
      sink.add(value);
    }
  });

  //another validations
  final onlyNumbers =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      sink.addError('This filed cannot be null');
    } else if (!regExp.hasMatch(value)) {
      sink.addError('Just numbers are accepted');
    } else {
      sink.add(value);
    }
  });

  final cannotBeNull =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (value.length == 0) {
      sink.addError('This field cannot be null');
    } else {
      sink.add(value);
    }
  });

  final zipCodeValidate =
      StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    int tamanho = value.length;
    if (tamanho == 0) {
      sink.addError("Zipcode is required");
    } else if (tamanho > 0 && tamanho < 9) {
      sink.addError("Zipcode is invalid");
    } else {
      sink.add(value);
    }
  });
}
