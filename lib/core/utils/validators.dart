String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a username';
  }

  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an email address';
  } else if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$").hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null;
}
