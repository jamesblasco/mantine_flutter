import 'dart:async';
import 'package:flutter/widgets.dart';

/// Abstract interface for storage backend.
/// The consumer of the library should provide an implementation (e.g. using shared_preferences).
abstract interface class MantineStorageBackend {
  Future<String?> getItem(String key);
  Future<void> setItem(String key, String value);
  Future<void> removeItem(String key);
}

/// Serializer to convert T to and from String.
abstract interface class MantineLocalStorageSerializer<T> {
  String encode(T value);
  T decode(String value);
}

class MantineLocalStorage<T> extends ValueNotifier<T> {
  MantineLocalStorage({
    required this.key,
    required T defaultValue,
    required this.backend,
    this.serializer,
  }) : super(defaultValue) {
    _load();
  }

  final String key;
  final MantineStorageBackend backend;
  final MantineLocalStorageSerializer<T>? serializer;

  Future<void> _load() async {
    try {
      final storedValue = await backend.getItem(key);
      if (storedValue != null) {
        final decoded = _getSerializer().decode(storedValue);
        super.value = decoded;
      }
    } catch (e) {
      debugPrint('Error loading from MantineLocalStorage: $e');
    }
  }

  @override
  set value(T newValue) {
    if (super.value == newValue) return;
    super.value = newValue;
    _save(newValue);
  }

  Future<void> _save(T newValue) async {
    try {
      final encoded = _getSerializer().encode(newValue);
      await backend.setItem(key, encoded);
    } catch (e) {
      debugPrint('Error saving to MantineLocalStorage: $e');
    }
  }

  MantineLocalStorageSerializer<T> _getSerializer() {
    if (serializer != null) return serializer!;

    final defaultSerializer = _getDefaultSerializer<T>();
    if (defaultSerializer != null) return defaultSerializer as MantineLocalStorageSerializer<T>;

    throw StateError(
      'No serializer provided for MantineLocalStorage<$T> and no default serializer found for this type.',
    );
  }

  static MantineLocalStorageSerializer<dynamic>? _getDefaultSerializer<T>() {
    if (T == String) return const _StringSerializer();
    if (T == int) return const _IntSerializer();
    if (T == double) return const _DoubleSerializer();
    if (T == bool) return const _BoolSerializer();
    if (T == List<String>) return const _StringListSerializer();
    return null;
  }
}

class _StringSerializer implements MantineLocalStorageSerializer<String> {
  const _StringSerializer();
  @override
  String encode(String value) => value;
  @override
  String decode(String value) => value;
}

class _IntSerializer implements MantineLocalStorageSerializer<int> {
  const _IntSerializer();
  @override
  String encode(int value) => value.toString();
  @override
  int decode(String value) => int.parse(value);
}

class _DoubleSerializer implements MantineLocalStorageSerializer<double> {
  const _DoubleSerializer();
  @override
  String encode(double value) => value.toString();
  @override
  double decode(String value) => double.parse(value);
}

class _BoolSerializer implements MantineLocalStorageSerializer<bool> {
  const _BoolSerializer();
  @override
  String encode(bool value) => value.toString();
  @override
  bool decode(String value) => value.toLowerCase() == 'true';
}

class _StringListSerializer implements MantineLocalStorageSerializer<List<String>> {
  const _StringListSerializer();
  @override
  String encode(List<String> value) => value.join(';;;');
  @override
  List<String> decode(String value) => value.isEmpty ? [] : value.split(';;;');
}
