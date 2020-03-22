class Validators {
  static final RegExp _usernameLengthCheckRegExp = RegExp(
    r'^\w{8,20}$',
  );
  static final RegExp _usernameStartUnderscoreCharRegExp = RegExp(
    r'^(?![_])',
  );
  static final RegExp _usernameAlphanumericRegExp = RegExp(r'^[a-zA-Z0-9_]+$');

  static _usernameEndingChar(String username) {
    return username.endsWith("_");
  }

  static _username2AdjacentSpecialCharsRegExp(String username) {
    return username.contains('__');
  }

  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static isValidUsername(String username) {
    if (!_usernameStartUnderscoreCharRegExp.hasMatch(username)) {
      return "Username can't start with special character.";
    } else if (_usernameEndingChar(username)) {
      return "Username can't end with special character.";
    } else if (_username2AdjacentSpecialCharsRegExp(username)) {
      return "Username can't have 2 adjacent underscores.";
    } else if (!_usernameAlphanumericRegExp.hasMatch(username)) {
      return "Username can have letters, numbers, underscores.";
    } else if (!_usernameLengthCheckRegExp.hasMatch(username)) {
      return "Username Length must be 8-20 characters.";
    } else
      return "VALID";
  }

  static isValidWhatsapp(String username) {
    if (!_usernameStartUnderscoreCharRegExp.hasMatch(username)) {
      return "Username can't start with special character.";
    } else if (_usernameEndingChar(username)) {
      return "Username can't end with special character.";
    } else if (_username2AdjacentSpecialCharsRegExp(username)) {
      return "Username can't have 2 adjacent underscores.";
    } else if (!_usernameAlphanumericRegExp.hasMatch(username)) {
      return "Username can have letters, numbers, underscores.";
    } else if (!_usernameLengthCheckRegExp.hasMatch(username)) {
      return "Username Length must be 8-20 characters.";
    } else
      return "VALID";
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }
}
