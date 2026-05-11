import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

sealed class LocationException implements Exception {
  final String message;
  LocationException(this.message);

  @override
  String toString() => message;
}

class ServiceDisabled extends LocationException {
  ServiceDisabled() : super('Layanan lokasi (GPS) tidak aktif.');
}

class PermissionDenied extends LocationException {
  PermissionDenied() : super('Izin lokasi ditolak.');
}

class PermanentlyDenied extends LocationException {
  PermanentlyDenied()
    : super('Izin lokasi ditolak permanen. Aktifkan di pengaturan HP.');
}

class GeocodingFailed extends LocationException {
  GeocodingFailed() : super('Gagal menerjemahkan lokasi ke nama kota.');
}

class LocationService {
  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationServiceDisabledException();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw PermissionDenied();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw PermanentlyDenied();
    }

    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }

  /// Menerjemahkan koordinat menjadi alamat (nama kota/provinsi)
  Future<String?> getAddressCoordinates(Position position) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      ).timeout(const Duration(seconds: 15));

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;

        String village = place.subLocality ?? '';
        String district = (place.locality ?? '').replaceAll(
          'Kecamatan',
          'Kec.',
        );
        String regency = (place.subAdministrativeArea ?? '').replaceAll(
          'Kabupaten',
          'Kab.',
        );
        String province = place.administrativeArea ?? '';

        final addressParts = [
          village,
          district,
          regency,
          province,
        ].where((s) => s.isNotEmpty).toList();

        if (addressParts.isEmpty) return 'Lokasi tidak diketahui';

        return addressParts.take(2).join(', ');
      }
      return null;
    } catch (e) {
      debugPrint('Geocoding Error: $e');
      throw GeocodingFailed();
    }
  }
}
