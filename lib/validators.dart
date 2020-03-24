class Validators {
  static final RegExp _usernameLengthCheckRegExp = RegExp(
    r'^\w{8,20}$',
  );
  static final RegExp _usernameStartUnderscoreCharRegExp = RegExp(
    r'^(?![_])',
  );

  static final RegExp _phoneNumberMatchRegExp = RegExp(r'^[\d ()-]*$');
  static final RegExp _usernameAlphanumericRegExp = RegExp(r'^[a-zA-Z0-9_]+$');
  static final RegExp _handleMatchRegExp = RegExp(r'^[a-zA-Z0-9_\.-]*$');
  static final RegExp _emailMatchRegExp = RegExp(r'^[a-zA-z0-9\._%+-]+@[a-zA-Z0-9\.-]+\.[a-zA-Z]{2,}$');

  static final RegExp _justTheNumbers = RegExp(r'+?\d*$');

  static _usernameEndingChar(String username) {
    return username.endsWith("_");
  }

  static _usernameContainsStar(String username) {
    return username.contains('*');
  }

  static _username2AdjacentSpecialCharsRegExp(String username) {
    return username.contains('__') || username.contains('..') || username.contains('--');
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
      return "Username can have letters, numbers, underscores.";
    } else if (!_usernameLengthCheckRegExp.hasMatch(username)) {
      return "Username Length must be 8-20 characters.";
    } else
      return "VALID";
  }
  static isValidEmail(String email) {
    if(email == "") {
      return "VALID";
    } else if (!_usernameStartUnderscoreCharRegExp.hasMatch(email)) {
      return "Email can't start with special character.";
    } else if (_usernameEndingChar(email)) {
      return "Email can't end with special character.";
    } else if (_usernameContainsStar(email)) {
      return "Handle can't have * symbol";
    } else if (_username2AdjacentSpecialCharsRegExp(email)) {
      return "Email can't have 2 adjacent underscores.";
    } else if (!_emailMatchRegExp.hasMatch(email)) {
      return "Not valid username@domain format";
    } else
      return "VALID";
  }

  static isValidPhoneNumber(String number) {
    if (!_phoneNumberMatchRegExp.hasMatch(number)) {
      return "Phone number can have numbers, underscores, hyphens and spaces.";
    } else
      return "VALID";
  }

  static isValidHandle(String handle) {
    if (!_usernameStartUnderscoreCharRegExp.hasMatch(handle)) {
      return "Handle can't start with special character.";
    } else if (_usernameEndingChar(handle)) {
      return "Handle can't end with special character.";
    } else if (_usernameContainsStar(handle)) {
      return "Handle can't have * symbol";
    } else if (_username2AdjacentSpecialCharsRegExp(handle)) {
      return "Handle can't have 2 adjacent underscores.";
    } else if (!_handleMatchRegExp.hasMatch(handle)) {
      return "Handle can have letters, numbers, underscores.";
    } else
      return "VALID";
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }

  static getNumbersFromPhoneNumber(String phoneNumber) {

    print(phoneNumber.length);
  }
}
