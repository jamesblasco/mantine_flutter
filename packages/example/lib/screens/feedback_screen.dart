import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';
import 'shared.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _timeout = MantineTimeout();
  String _timeoutStatus = 'Idle';

  @override
  void dispose() {
    _timeout.dispose();
    super.dispose();
  }

  void _startTimeout() {
    setState(() => _timeoutStatus = 'Pending...');
    _timeout.start(const Duration(seconds: 2), () {
      setState(() => _timeoutStatus = 'Completed');
    });
  }

  void _clearTimeout() {
    _timeout.clear();
    setState(() => _timeoutStatus = 'Cleared');
  }

  @override
  Widget build(BuildContext context) {
    return GalleryScreen(
      title: 'Feedback',
      sections: [
        GallerySection(
          title: 'Loader — Oval',
          child: MantineGroup(
            align: CrossAxisAlignment.center,
            children: MantineSize.values
                .map((s) => MantineLoader(type: MantineLoaderType.oval, size: s))
                .toList(),
          ),
        ),
        GallerySection(
          title: 'Loader — Bars',
          child: MantineGroup(
            align: CrossAxisAlignment.center,
            children: MantineSize.values
                .map((s) => MantineLoader(type: MantineLoaderType.bars, size: s))
                .toList(),
          ),
        ),
        GallerySection(
          title: 'Loader — Dots',
          child: MantineGroup(
            align: CrossAxisAlignment.center,
            children: MantineSize.values
                .map((s) => MantineLoader(type: MantineLoaderType.dots, size: s))
                .toList(),
          ),
        ),
        GallerySection(
          title: 'Loader colors',
          child: MantineGroup(
            align: CrossAxisAlignment.center,
            children: ['blue', 'violet', 'teal', 'red', 'orange']
                .map((c) => MantineLoader(
                      color: context.mantineTheme.colors.resolve(c)[
                          context.mantineTheme.primaryShade],
                    ))
                .toList(),
          ),
        ),
        GallerySection(
          title: 'Button loading states',
          child: MantineGroup(
            wrap: true,
            children: [
              MantineButton(
                onPressed: () {},
                loading: true,
                child: const Text('Left loader'),
              ),
              MantineButton(
                onPressed: () {},
                loading: true,
                loaderPosition: MantineLoaderPosition.right,
                child: const Text('Right loader'),
              ),
              MantineButton(
                onPressed: () {},
                loading: true,
                loaderPosition: MantineLoaderPosition.center,
                child: const Text('Hidden'),
              ),
            ],
          ),
        ),
        GallerySection(
          title: 'MantineTimeout',
          child: ListenableBuilder(
            listenable: _timeout,
            builder: (context, _) {
              return MantineStack(
                align: CrossAxisAlignment.start,
                children: [
                  MantineText('Status: $_timeoutStatus'),
                  MantineText('Pending: ${_timeout.pending}', dimmed: true),
                  MantineGroup(
                    children: [
                      MantineButton(
                        onPressed: _timeout.pending ? null : _startTimeout,
                        child: const Text('Start (2s)'),
                      ),
                      MantineButton(
                        onPressed: _timeout.pending ? _clearTimeout : null,
                        variant: MantineButtonVariant.outline,
                        color: 'red',
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                  const MantineText('Demonstrating sizes:'),
                  MantineGroup(
                    align: CrossAxisAlignment.center,
                    children: MantineSize.values.map((s) {
                      return MantineButton(
                        onPressed: _timeout.pending ? null : _startTimeout,
                        size: s,
                        child: Text('Start ${s.name}'),
                      );
                    }).toList(),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
