import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:skincare_recomendation/core/services/location_service.dart';
import 'package:skincare_recomendation/core/services/storage_service.dart';

class LocationProvider extends ChangeNotifier {
  final LocationService _locationService;
  final StorageService _storageService;

  // State data
  String _address = 'Sedang mencari lokasi...';
  Position? _currentPosition;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  String get address => _address;
  Position? get currentPosition => _currentPosition;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  LocationProvider(this._locationService, this._storageService) {
    _loadCache();
    initLocation();
  }

  void _loadCache() {
    final cachedAddress = _storageService.getString(
      StorageService.keyLastLocation,
    );
    if (cachedAddress != null) {
      _address = cachedAddress;
    }
  }

  Future<void> initLocation() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentPosition = await _locationService.getCurrentPosition();
      final newAddress = await _locationService.getAddressCoordinates(
        _currentPosition!,
      );

      if (newAddress != null) {
        _address = newAddress;
        _storageService.setString(StorageService.keyLastLocation, newAddress);
      }
    } on LocationException catch (e) {
      _errorMessage = e.message;
    } catch (e) {
      _errorMessage = 'Terjadi kesalahan yang tidak terduga.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshLocation() => initLocation();
}
