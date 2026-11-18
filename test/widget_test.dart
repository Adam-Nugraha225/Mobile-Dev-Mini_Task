import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_task_tracker/main.dart';

void main() {
  testWidgets('Mini Task Tracker: Verifikasi penambahan tugas baru', (WidgetTester tester) async {
    // 1. Render aplikasi
    await tester.pumpWidget(const MiniTaskTrackerApp());

    // 2. Pastikan tampilan awal memunculkan Empty State
    expect(find.text('Belum ada tugas hari ini'), findsOneWidget);

    // 3. Masukkan teks tugas baru ke TextField
    final textFieldFinder = find.byType(TextField);
    expect(textFieldFinder, findsOneWidget);
    await tester.enterText(textFieldFinder, 'Tugas Pertama Seleksi');

    // 4. Tekan tombol Simpan
    final saveButtonFinder = find.widgetWithText(FilledButton, 'Simpan');
    expect(saveButtonFinder, findsOneWidget);
    await tester.tap(saveButtonFinder);
    await tester.pump(); // Render ulang setelah setState

    // 5. Pastikan tugas baru muncul di daftar dan Empty State menghilang
    expect(find.text('Tugas Pertama Seleksi'), findsOneWidget);
    expect(find.text('Belum ada tugas hari ini'), findsNothing);
  });
}
