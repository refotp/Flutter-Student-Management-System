class Validator {
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName harus diisi';
    }
    return null;
  }

  static String? validatePassword(String? confirmPass, String? pass) {
    if (confirmPass == null || confirmPass.isEmpty) {
      if (pass != confirmPass) {
        return 'Periksa kembali password yang anda inputkan';
      }
      return 'Harap isi konfirmasi password terlebih dahulu';
    }

    return null;
  }
}
