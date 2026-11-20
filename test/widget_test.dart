import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_task_tracker/main.dart';

void main() {
  testWidgets('Menambah tugas baru dan menampilkan ke daftar', (WidgetTester tester) async {
    await tester.pumpWidget(const MiniTaskTrackerApp());

    expect(find.text('Belum ada tugas hari ini'), findsOneWidget);

    final textField = find.byType(TextField);
    await tester.enterText(textField, 'Tugas Pertama Seleksi');

    final saveButton = find.widgetWithText(FilledButton, 'Simpan');
    await tester.tap(saveButton);
    await tester.pump();

    expect(find.text('Tugas Pertama Seleksi'), findsOneWidget);
    expect(find.text('Belum ada tugas hari ini'), findsNothing);
  });
}
