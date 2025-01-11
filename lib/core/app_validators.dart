class AppValidators {
  static String? validateName(String value) {
    if (value.isEmpty) {
      return "Name cannot be empty";
    }
    return null;
  }

  static String? validateEmail(String value) {
    final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value.isEmpty) {
      return "Email cannot be empty";
    } else if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email";
    }
    return null;
  }

  static String? validateAddress(String value) {
    if (value.isEmpty) {
      return "Address cannot be empty";
    }
    return null;
  }

  static String? validateMobileNo(String value) {
    if (value.isEmpty) {
      return "Mobile number cannot be empty";
    } else if (value.length != 10 || !RegExp(r'^\d+$').hasMatch(value)) {
      return "Enter a valid 10-digit mobile number";
    }
    return null;
  }

  static String? validateProfilePic(String value) {
    if (value.isEmpty) {
      return "Profile picture URL cannot be empty";
    }
    return null;
  }
}
