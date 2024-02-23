class SiswaModel {
  final String id;
  final String nisn;
  final String namaLengkap;
  final String email;
  final String namaLembaga;

  SiswaModel(
      this.id, this.namaLengkap, this.email, this.namaLembaga, this.nisn);
  Map<String, dynamic> toJson() {
    return {
      'NamaLengkap': namaLengkap,
      'Email': email,
      'NamaLembaga': namaLembaga,
      'Nisn': nisn
    };
  }
}
