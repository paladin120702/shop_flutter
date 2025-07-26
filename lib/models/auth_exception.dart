class AuthException implements Exception {
  static const Map<String, String> errors = {
    'EMAIL_EXISTS': 'E-mail already registered.',
    'OPERATION_NOT_ALLOWED': 'This operation is not allowed.',
    'TOO_MANY_ATTEMPTS_TRY_LATER': 'Too many attempts. Try again later.',
    'USER_DISABLED': 'This user is disabled.',
    'INVALID_LOGIN_CREDENTIALS': 'Invalid e-mail or password.',
  };

  final String key;

  AuthException(this.key);

  @override
  String toString() {
    return errors[key] ?? 'An error occurred in the authentication process.';
  }
}
