import 'package:flutter_test/flutter_test.dart';
import 'package:mantine/mantine.dart';

void main() {
  test('MantineDebounced delays updates', () async {
    final debounced = MantineDebounced<String>('initial', delay: const Duration(milliseconds: 100));
    int callCount = 0;
    debounced.addListener(() => callCount++);

    debounced.set('update 1');
    expect(debounced.value, 'initial');
    expect(callCount, 0);

    await Future.delayed(const Duration(milliseconds: 50));
    debounced.set('update 2');
    expect(debounced.value, 'initial');
    expect(callCount, 0);

    await Future.delayed(const Duration(milliseconds: 150));
    expect(debounced.value, 'update 2');
    expect(callCount, 1);

    debounced.dispose();
  });

  test('MantineDebounced with immediate flag', () async {
    final debounced = MantineDebounced<String>('initial', delay: const Duration(milliseconds: 100), immediate: true);
    int callCount = 0;
    debounced.addListener(() => callCount++);

    debounced.set('update 1');
    expect(debounced.value, 'update 1');
    expect(callCount, 1);

    await Future.delayed(const Duration(milliseconds: 50));
    debounced.set('update 2');
    expect(debounced.value, 'update 1'); // Still 'update 1' because it's debouncing the next update
    expect(callCount, 1);

    await Future.delayed(const Duration(milliseconds: 150));
    expect(debounced.value, 'update 2');
    expect(callCount, 2);

    debounced.dispose();
  });
}
