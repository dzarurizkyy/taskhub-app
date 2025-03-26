String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return "Email cannot be null or empty";
  }

  if (!value.contains("@") || !value.contains(".com")) {
    return "Invalid email address";
  }

  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return "Password cannot be null or empty";
  }

  if (value.length < 6) {
    return "Password must be at least 6 characters";
  }

  return null;
}
