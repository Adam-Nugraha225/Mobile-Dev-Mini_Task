/// Model representasi data sebuah Catatan / Tugas harian.
/// Dibuat terpisah agar kode mengikuti prinsip Clean Code dan OOP (Object-Oriented Programming).
class Task {
  final String id;
  String title;
  bool isCompleted;
  final DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.createdAt,
  });

  /// Method pembantu untuk mengubah status selesai / belum selesai.
  void toggleCompleted() {
    isCompleted = !isCompleted;
  }
}
