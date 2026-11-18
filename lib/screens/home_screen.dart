import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../widgets/empty_state.dart';
import '../widgets/task_tile.dart';

/// Halaman utama (1 Halaman Sesuai Ketentuan Penugasan).
/// Menggunakan StatefulWidget dan setState() untuk manajemen data lokal di memori.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 1. In-Memory Data: List penampung objek tugas
  final List<Task> _tasks = [];

  // Controller untuk menangani input dari TextField
  final TextEditingController _taskController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _taskController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // Hitung jumlah tugas yang sudah selesai
  int get _completedCount => _tasks.where((task) => task.isCompleted).length;

  // ================= LOGIKA UTAMA (CORE ACTIONS) =================

  /// Logika 1: Menambah tugas baru ke dalam list
  void _addTask() {
    final title = _taskController.text.trim();

    // Validasi: Tidak boleh kosong atau hanya spasi
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Judul tugas tidak boleh kosong!'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      createdAt: DateTime.now(),
    );

    // setState memberitahu Flutter bahwa data berubah, picu render ulang tampilan
    setState(() {
      _tasks.insert(0, newTask); // Masukkan di paling atas
    });

    _taskController.clear();
    _focusNode.unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Catatan "$title" berhasil disimpan!'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Logika 2: Mengubah status centang (selesai / belum)
  void _toggleTask(String id) {
    setState(() {
      final task = _tasks.firstWhere((t) => t.id == id);
      task.toggleCompleted();
    });
  }

  /// Logika 3: Menghapus catatan dari daftar
  void _deleteTask(String id) {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index == -1) return;

    final removedTask = _tasks[index];

    setState(() {
      _tasks.removeAt(index);
    });

    // UX Tambahan: Beri notifikasi SnackBar dengan tombol Undo
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('"${removedTask.title}" dihapus'),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Batalkan',
          onPressed: () {
            setState(() {
              _tasks.insert(index, removedTask);
            });
          },
        ),
      ),
    );
  }

  // ================= TAMPILAN (UI) =================

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mini Task Tracker',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          // Indikator Progres Ringkas
          if (_tasks.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$_completedCount / ${_tasks.length} Selesai',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // BAGIAN 1: FORM INPUT DATA
            _buildInputSection(theme),

            const Divider(height: 1),

            // BAGIAN 2 & 3: TAMPILAN DAFTAR (LIST) & AKSI
            Expanded(
              child: _tasks.isEmpty
                  ? const EmptyStateWidget()
                  : ListView.builder(
                      itemCount: _tasks.length,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemBuilder: (context, index) {
                        final task = _tasks[index];
                        return TaskTile(
                          key: ValueKey(task.id),
                          task: task,
                          onToggle: () => _toggleTask(task.id),
                          onDelete: () => _deleteTask(task.id),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  /// Komponen input baris untuk memasukkan judul catatan dan tombol simpan
  Widget _buildInputSection(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              // Kolom Teks Input Judul
              Expanded(
                child: TextField(
                  controller: _taskController,
                  focusNode: _focusNode,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _addTask(),
                  decoration: InputDecoration(
                    hintText: 'Tulis judul tugas atau catatan...',
                    prefixIcon: const Icon(Icons.edit_note_rounded),
                    filled: true,
                    fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.35),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(
                        color: theme.colorScheme.primary,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Tombol Simpan
              FilledButton.icon(
                onPressed: _addTask,
                icon: const Icon(Icons.add_rounded),
                label: const Text('Simpan'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
