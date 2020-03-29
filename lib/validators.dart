import 'package:flutter/cupertino.dart';

class Validators {
  static final RegExp _usernameLengthCheckRegExp = RegExp(
    r'^\w{8,20}$',
  );
  static final RegExp _usernameStartUnderscoreCharRegExp = RegExp(
    r'^(?![_])',
  );

  static final RegExp _phoneNumberMatchRegExp = RegExp(r'^[\d ()x\+-]*$');
  static final RegExp _usernameAlphanumericRegExp = RegExp(r'^[a-zA-Z0-9_]+$');
  static final RegExp _handleMatchRegExp = RegExp(r'^[a-zA-Z0-9_\.-]*$');
  static final RegExp _emailMatchRegExp =
      RegExp(r'^[a-zA-z0-9\._%+-]+@[a-zA-Z0-9\.-]+\.[a-zA-Z]{2,}$');

  static _usernameEndingChar(String username) {
    return username.endsWith("_");
  }

  static _usernameContainsStar(String username) {
    return username.contains('*');
  }

  static _username2AdjacentSpecialCharsRegExp(String username) {
    return username.contains('__') ||
        username.contains('..') ||
        username.contains('--');
  }

  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static isValidUsername(String username) {
    if (!_usernameStartUnderscoreCharRegExp.hasMatch(username)) {
      return "Username can't start with special character.";
    } else if (_usernameEndingChar(username)) {
      return "Username can't end with special character.";
    } else if (_usernameContainsStar(username)) {
      return "Handle can't have * symbol";
    } else if (_username2AdjacentSpecialCharsRegExp(username)) {
      return "Username can't have 2 adjacent underscores.";
    } else if (!_usernameAlphanumericRegExp.hasMatch(username)) {
      return "Only letters, numbers, underscores.";
    } else if (!_usernameLengthCheckRegExp.hasMatch(username)) {
      return "Username Length must be 8-20 characters.";
    } else
      return "VALID";
  }

  static isValidEmail(String email) {
    if (email == "") {
      return "VALID";
    } else if (!_usernameStartUnderscoreCharRegExp.hasMatch(email)) {
      return "Email can't start with special character.";
    } else if (_usernameEndingChar(email)) {
      return "Email can't end with special character.";
    } else if (_usernameContainsStar(email)) {
      return "Email can't have * symbol";
    } else if (_username2AdjacentSpecialCharsRegExp(email)) {
      return "Email can't have 2 adjacent underscores.";
    } else if (!_emailMatchRegExp.hasMatch(email)) {
      return "Not valid username@domain format";
    } else
      return "VALID";
  }

  static isValidPhoneNumber(String number) {
    if (!_phoneNumberMatchRegExp.hasMatch(number)) {
      return "Only numbers, hyphens and spaces.";
    } else if (number == "") {
      return "VALID";
    } else if (hasMiddlePlus(number)) {
      return "Invalid + sign";
    } else if (getNumbersFromPhoneNumber(number).length < 4) {
      return "Please enter at least 4 digits";
    } else if (getNumbersFromPhoneNumber(number).length > 20) {
      return "Please enter less than 20 digits";
    } else
      return "VALID";
  }

  static isValidHandle(String handle) {
    if (_usernameContainsStar(handle)) {
      return "Handle can't have * symbol";
    } else if (_username2AdjacentSpecialCharsRegExp(handle)) {
      return "Handle can't have 2 adjacent underscores.";
    } else if (!_handleMatchRegExp.hasMatch(handle)) {
      return "Only letters, numbers, underscores.";
    } else
      return "VALID";
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }

  static hasMiddlePlus(String phoneNumber) {
    phoneNumber = phoneNumber.substring(1);
    return phoneNumber.contains("+");
  }

  static final RegExp _onlyNumbers = RegExp(r'[^0-9\+x]');

  static String getNumbersFromPhoneNumber(String phoneNumber) {
    return phoneNumber.replaceAll(_onlyNumbers, "");
  }
}
