import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../shared.dart';

class NavLinkScreen extends StatefulWidget {
  const NavLinkScreen({super.key});

  @override
  State<NavLinkScreen> createState() => _NavLinkScreenState();
}

class _NavLinkScreenState extends State<NavLinkScreen> {
  int _active = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MantineTitle('NavLink', order: MantineTitleOrder.h2),
          MantineText(
            'Navigation link for sidebars with active state, icon, and collapsible children.',
            dimmed: true,
          ),
          const SizedBox(height: 24),
          GallerySection(
            title: 'Usage',
            child: Column(
              children: [
                MantineNavLink(
                  label: const Text('With icon'),
                  leftSection: PhosphorIcon(PhosphorIcons.house()),
                ),
                MantineNavLink(
                  label: const Text('With right section'),
                  leftSection: PhosphorIcon(PhosphorIcons.gauge()),
                  rightSection: PhosphorIcon(PhosphorIcons.caretRight()),
                ),
                MantineNavLink(
                  label: const Text('Disabled'),
                  leftSection: PhosphorIcon(PhosphorIcons.prohibit()),
                  disabled: true,
                ),
                MantineNavLink(
                  label: const Text('With description'),
                  description: const Text('Additional information'),
                  leftSection: MantineBadge(
                    size: MantineSize.xs,
                    color: 'red',
                    variant: MantineBadgeVariant.filled,
                    child: const Text('3'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          GallerySection(
            title: 'Active',
            child: Column(
              children: [
                MantineNavLink(
                  label: const Text('Dashboard'),
                  description: const Text('Item with description'),
                  leftSection: PhosphorIcon(PhosphorIcons.gauge()),
                  active: _active == 0,
                  onTap: () => setState(() => _active = 0),
                ),
                MantineNavLink(
                  label: const Text('Security'),
                  leftSection: PhosphorIcon(PhosphorIcons.fingerprint()),
                  rightSection: PhosphorIcon(PhosphorIcons.caretRight()),
                  active: _active == 1,
                  onTap: () => setState(() => _active = 1),
                ),
                MantineNavLink(
                  label: const Text('Activity'),
                  leftSection: PhosphorIcon(PhosphorIcons.pulse()),
                  active: _active == 2,
                  onTap: () => setState(() => _active = 2),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          GallerySection(
            title: 'Variants',
            child: Column(
              children: [
                MantineNavLink(
                  label: const Text('Active subtle'),
                  leftSection: PhosphorIcon(PhosphorIcons.heartbeat()),
                  rightSection: PhosphorIcon(PhosphorIcons.caretRight()),
                  variant: MantineNavLinkVariant.subtle,
                  active: true,
                ),
                MantineNavLink(
                  label: const Text('Active light'),
                  leftSection: PhosphorIcon(PhosphorIcons.heartbeat()),
                  rightSection: PhosphorIcon(PhosphorIcons.caretRight()),
                  variant: MantineNavLinkVariant.light,
                  active: true,
                ),
                MantineNavLink(
                  label: const Text('Active filled'),
                  leftSection: PhosphorIcon(PhosphorIcons.heartbeat()),
                  rightSection: PhosphorIcon(PhosphorIcons.caretRight()),
                  variant: MantineNavLinkVariant.filled,
                  active: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          GallerySection(
            title: 'Nested NavLinks',
            child: Column(
              children: [
                MantineNavLink(
                  label: const Text('First parent link'),
                  leftSection: PhosphorIcon(PhosphorIcons.gauge()),
                  children: [
                    const MantineNavLink(label: Text('First child link')),
                    const MantineNavLink(label: Text('Second child link')),
                    MantineNavLink(
                      label: const Text('Nested parent link'),
                      children: [
                        const MantineNavLink(label: Text('First child link')),
                        const MantineNavLink(label: Text('Second child link')),
                        const MantineNavLink(label: Text('Third child link')),
                      ],
                    ),
                  ],
                ),
                MantineNavLink(
                  label: const Text('Second parent link'),
                  leftSection: PhosphorIcon(PhosphorIcons.fingerprint()),
                  defaultOpened: true,
                  children: [
                    const MantineNavLink(label: Text('First child link')),
                    const MantineNavLink(label: Text('Second child link')),
                    const MantineNavLink(label: Text('Third child link')),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          GallerySection(
            title: 'Sizing',
            child: Column(
              children: [
                MantineNavLink(
                  label: const Text('Extra small'),
                  size: MantineSize.xs,
                  leftSection: PhosphorIcon(PhosphorIcons.star()),
                ),
                MantineNavLink(
                  label: const Text('Small'),
                  size: MantineSize.sm,
                  leftSection: PhosphorIcon(PhosphorIcons.star()),
                ),
                MantineNavLink(
                  label: const Text('Medium'),
                  size: MantineSize.md,
                  leftSection: PhosphorIcon(PhosphorIcons.star()),
                ),
                MantineNavLink(
                  label: const Text('Large'),
                  size: MantineSize.lg,
                  leftSection: PhosphorIcon(PhosphorIcons.star()),
                ),
                MantineNavLink(
                  label: const Text('Extra large'),
                  size: MantineSize.xl,
                  leftSection: PhosphorIcon(PhosphorIcons.star()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
