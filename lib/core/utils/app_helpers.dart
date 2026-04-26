import 'package:intl/intl.dart';

class AppHelpers {
  static String formatDate([DateTime? date]) {
    final now = date ?? DateTime.now();
    return DateFormat('EEEE, d MMMM', 'id_ID').format(now);
  }

  static String formatDateFallback([DateTime? date]) {
    const days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
    const months = [
      '', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
    ];
    final now = date ?? DateTime.now();
    return '${days[now.weekday - 1]}, ${now.day} ${months[now.month]}';
  }
}
