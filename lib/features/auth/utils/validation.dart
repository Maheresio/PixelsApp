String? emailValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Email is required';
  }
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  if (!emailRegex.hasMatch(value)) {
    return 'Enter a valid email address';
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password cannot be empty';
  }

  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }

  if (!RegExp(r'[A-Z]').hasMatch(value)) {
    return 'Password must include at least one uppercase letter';
  }

  if (!RegExp(r'[a-z]').hasMatch(value)) {
    return 'Password must include at least one lowercase letter';
  }

  if (!RegExp(r'\d').hasMatch(value)) {
    return 'Password must include at least one number';
  }

  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
    return 'Password must include at least one special character';
  }

  return null;
}
