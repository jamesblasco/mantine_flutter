import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class SelectSection extends StatefulWidget {
  const SelectSection({super.key});

  @override
  State<SelectSection> createState() => _SelectSectionState();
}

class _SelectSectionState extends State<SelectSection> {
  String? _value1;
  String? _value2;
  String? _value3;
  String? _value4;
  String? _value5;

  @override
  Widget build(BuildContext context) {
    return MantineStack(
      children: [
        MantineSelect(
          label: 'Basic select',
          placeholder: 'Pick one',
          data: const ['React', 'Angular', 'Vue', 'Svelte'],
          value: _value1,
          onChanged: (v) => setState(() => _value1 = v),
        ),
        MantineSelect(
          label: 'Searchable select',
          placeholder: 'Pick one',
          searchable: true,
          data: const ['React', 'Angular', 'Vue', 'Svelte'],
          value: _value2,
          onChanged: (v) => setState(() => _value2 = v),
        ),
        MantineSelect(
          label: 'Clearable select',
          placeholder: 'Pick one',
          clearable: true,
          data: const ['React', 'Angular', 'Vue', 'Svelte'],
          value: _value3,
          onChanged: (v) => setState(() => _value3 = v),
        ),
        MantineSelect(
          label: 'Creatable select',
          placeholder: 'Pick or create',
          searchable: true,
          creatable: true,
          data: const ['React', 'Angular', 'Vue', 'Svelte'],
          value: _value4,
          onChanged: (v) => setState(() => _value4 = v),
        ),
        MantineSelect(
          label: 'Grouped select',
          placeholder: 'Pick one',
          data: const [
            MantineSelectItem(value: 'react', label: 'React', group: 'Frontend'),
            MantineSelectItem(value: 'angular', label: 'Angular', group: 'Frontend'),
            MantineSelectItem(value: 'node', label: 'Node', group: 'Backend'),
            MantineSelectItem(value: 'django', label: 'Django', group: 'Backend'),
          ],
          value: _value5,
          onChanged: (v) => setState(() => _value5 = v),
        ),
        const MantineSelect(
          label: 'Disabled select',
          placeholder: 'Cannot pick',
          disabled: true,
          data: ['React', 'Angular', 'Vue', 'Svelte'],
        ),
        const MantineSelect(
          label: 'Select with error',
          placeholder: 'Pick one',
          error: 'Please select a framework',
          data: ['React', 'Angular', 'Vue', 'Svelte'],
        ),
      ],
    );
  }
}
