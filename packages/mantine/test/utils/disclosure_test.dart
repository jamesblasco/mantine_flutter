import 'package:flutter_test/flutter_test.dart';
import 'package:mantine/mantine.dart';

void main() {
  group('MantineDisclosure', () {
    test('initial value', () {
      final disclosure = MantineDisclosure(false);
      expect(disclosure.value, isFalse);
    });

    test('open()', () {
      final disclosure = MantineDisclosure(false);
      disclosure.open();
      expect(disclosure.value, isTrue);
    });

    test('close()', () {
      final disclosure = MantineDisclosure(true);
      disclosure.close();
      expect(disclosure.value, isFalse);
    });

    test('toggle()', () {
      final disclosure = MantineDisclosure(false);
      disclosure.toggle();
      expect(disclosure.value, isTrue);
      disclosure.toggle();
      expect(disclosure.value, isFalse);
    });

    test('onOpen callback', () {
      bool opened = false;
      final disclosure = MantineDisclosure(false, onOpen: () => opened = true);
      disclosure.open();
      expect(opened, isTrue);
    });

    test('onClose callback', () {
      bool closed = false;
      final disclosure = MantineDisclosure(true, onClose: () => closed = true);
      disclosure.close();
      expect(closed, isTrue);
    });

    test('callbacks only fire on change', () {
      int openCount = 0;
      final disclosure = MantineDisclosure(false, onOpen: () => openCount++);

      disclosure.open();
      expect(openCount, 1);

      disclosure.open();
      expect(openCount, 1);
    });
  });
}
