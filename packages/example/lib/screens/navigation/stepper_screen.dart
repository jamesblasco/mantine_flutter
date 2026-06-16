import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';
import '../shared.dart';

class StepperScreen extends StatelessWidget {
  const StepperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GalleryScreen(
      title: 'Stepper',
      sections: [
        GallerySection(title: 'Basic usage', child: _BasicExample()),
        GallerySection(title: 'Vertical orientation', child: _VerticalExample()),
        GallerySection(title: 'Step states', child: _StatesExample()),
        GallerySection(title: 'Sizes', child: _SizesExample()),
      ],
    );
  }
}

class _BasicExample extends StatefulWidget {
  const _BasicExample();

  @override
  State<_BasicExample> createState() => _BasicExampleState();
}

class _BasicExampleState extends State<_BasicExample> {
  int _active = 1;

  void _nextStep() => setState(() => _active = (_active < 3 ? _active + 1 : _active));
  void _prevStep() => setState(() => _active = (_active > 0 ? _active - 1 : _active));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MantineStepper(
          active: _active,
          onStepClick: (step) => setState(() => _active = step),
          children: [
            MantineStep(
              label: const Text('First step'),
              description: const Text('Create an account'),
              child: const Center(child: Text('Step 1 content: Create an account', style: TextStyle(fontSize: 18))),
            ),
            MantineStep(
              label: const Text('Second step'),
              description: const Text('Verify email'),
              child: const Center(child: Text('Step 2 content: Verify email', style: TextStyle(fontSize: 18))),
            ),
            MantineStep(
              label: const Text('Final step'),
              description: const Text('Get full access'),
              child: const Center(child: Text('Step 3 content: Get full access', style: TextStyle(fontSize: 18))),
            ),
            MantineStepperCompleted(
              child: const Center(child: Text('Completed, click back button to step to previous step', style: TextStyle(fontSize: 18))),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MantineButton(
              variant: MantineButtonVariant.outline,
              color: 'gray',
              onPressed: _prevStep,
              child: const Text('Back'),
            ),
            const SizedBox(width: 10),
            MantineButton(
              onPressed: _nextStep,
              child: const Text('Next step'),
            ),
          ],
        ),
      ],
    );
  }
}

class _VerticalExample extends StatefulWidget {
  const _VerticalExample();

  @override
  State<_VerticalExample> createState() => _VerticalExampleState();
}

class _VerticalExampleState extends State<_VerticalExample> {
  int _active = 1;

  @override
  Widget build(BuildContext context) {
    return MantineStepper(
      active: _active,
      onStepClick: (step) => setState(() => _active = step),
      orientation: MantineStepperOrientation.vertical,
      children: [
        MantineStep(
          label: const Text('Step 1'),
          description: const Text('Create an account'),
          child: const Padding(
            padding: EdgeInsets.only(left: 54),
            child: Text('Step 1 content'),
          ),
        ),
        MantineStep(
          label: const Text('Step 2'),
          description: const Text('Verify email'),
          child: const Padding(
            padding: EdgeInsets.only(left: 54),
            child: Text('Step 2 content'),
          ),
        ),
        MantineStep(
          label: const Text('Step 3'),
          description: const Text('Get full access'),
          child: const Padding(
            padding: EdgeInsets.only(left: 54),
            child: Text('Step 3 content'),
          ),
        ),
      ],
    );
  }
}

class _StatesExample extends StatelessWidget {
  const _StatesExample();

  @override
  Widget build(BuildContext context) {
    return MantineStepper(
      active: 1,
      children: [
        MantineStep(
          label: const Text('Step 1'),
          description: const Text('Completed step'),
          child: const Text('Step 1 content'),
        ),
        MantineStep(
          label: const Text('Step 2'),
          description: const Text('Active step'),
          child: const Text('Step 2 content'),
        ),
        MantineStep(
          label: const Text('Step 3'),
          description: const Text('Step with error'),
          error: true,
          child: const Text('Step 3 content'),
        ),
        MantineStep(
          label: const Text('Step 4'),
          description: const Text('Step in loading state'),
          loading: true,
          child: const Text('Step 4 content'),
        ),
      ],
    );
  }
}

class _SizesExample extends StatelessWidget {
  const _SizesExample();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: MantineSize.values.map((size) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Size: ${size.name}', style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              MantineStepper(
                active: 1,
                size: size,
                children: [
                  MantineStep(label: Text('Step 1'), child: const SizedBox.shrink()),
                  MantineStep(label: Text('Step 2'), child: const SizedBox.shrink()),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
