class AuthException implements Exception {
  static const Map<String, String> errors = {
    "EMAIL_EXISTS": "E-mail existe",
    "OPERATION_NOT_ALLOWED": "Operaçao nao permitida",
    "TOO_MANY_ATTEMPTS_TRY_LATER": "tente mais tarde",
    "EMAIL_NOT_FOUND": "Email nao encontrado",
    "INVALID_PASSWORD": "Senha invalida",
  };
  final String key;

  const AuthException(this.key);

  @override
  String toString() {
    if (errors.containsKey(key)) {
      return errors[key];
    } else {
      return "ocorreu um erro na autenticaçao";
    }
    // return key;
  }
}
