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

  static String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 11) {
      return 'Selamat Pagi';
    } else if (hour >= 11 && hour < 15) {
      return 'Selamat Siang';
    } else if (hour >= 15 && hour < 18) {
      return 'Selamat Sore';
    } else {
      return 'Selamat Malam';
    }
  }
}
