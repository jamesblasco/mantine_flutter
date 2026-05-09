import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class MenuSection extends StatelessWidget {
  const MenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MantineStack(
      spacing: MantineSize.xl,
      children: [
        _buildBasicMenu(context),
        _buildSizedMenus(context),
        _buildColoredMenu(context),
      ],
    );
  }

  Widget _buildBasicMenu(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MantineText('Basic Menu', weight: FontWeight.w600),
        const SizedBox(height: 12),
        MantineMenu(
          width: 200,
          target: MantineMenuTarget(
            child: MantineButton(
              onPressed: () {},
              child: const Text('Open menu'),
            ),
          ),
          dropdown: MantineMenuDropdown(
            children: [
              const MantineMenuLabel(child: Text('Application')),
              MantineMenuItem(
                leftSection: const PhosphorIcon(PhosphorIconsFill.gear),
                child: const Text('Settings'),
                onPressed: () {},
              ),
              MantineMenuItem(
                leftSection: const PhosphorIcon(PhosphorIconsFill.chatCircle),
                child: const Text('Messages'),
                onPressed: () {},
              ),
              MantineMenuItem(
                leftSection: const PhosphorIcon(PhosphorIconsFill.image),
                child: const Text('Gallery'),
                onPressed: () {},
              ),
              MantineMenuItem(
                leftSection:
                    const PhosphorIcon(PhosphorIconsFill.magnifyingGlass),
                rightSection: const Text('⌘K'),
                child: const Text('Search'),
                onPressed: () {},
              ),
              const MantineMenuDivider(),
              const MantineMenuLabel(child: Text('Danger zone')),
              MantineMenuItem(
                leftSection:
                    const PhosphorIcon(PhosphorIconsFill.arrowsLeftRight),
                child: const Text('Transfer my data'),
                onPressed: () {},
              ),
              MantineMenuItem(
                color: 'red',
                leftSection: const PhosphorIcon(PhosphorIconsFill.trash),
                child: const Text('Delete my account'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSizedMenus(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MantineText('Sizes', weight: FontWeight.w600),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: MantineSize.values.map((size) {
            return MantineMenu(
              size: size,
              width: 150,
              target: MantineMenuTarget(
                child: MantineButton(
                  onPressed: () {},
                  size: size,
                  child: Text(size.name.toUpperCase()),
                ),
              ),
              dropdown: MantineMenuDropdown(
                children: [
                  MantineMenuLabel(child: Text('Menu size ${size.name}')),
                  MantineMenuItem(
                    leftSection: const PhosphorIcon(PhosphorIconsFill.user),
                    child: const Text('Profile'),
                    onPressed: () {},
                  ),
                  MantineMenuItem(
                    leftSection: const PhosphorIcon(PhosphorIconsFill.signOut),
                    child: const Text('Logout'),
                    onPressed: () {},
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildColoredMenu(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MantineText('Colored items', weight: FontWeight.w600),
        const SizedBox(height: 12),
        MantineMenu(
          width: 200,
          target: MantineMenuTarget(
            child: MantineButton(
              onPressed: () {},
              variant: MantineButtonVariant.outline,
              child: const Text('Colored menu'),
            ),
          ),
          dropdown: MantineMenuDropdown(
            children: [
              MantineMenuItem(
                color: 'blue',
                leftSection: const PhosphorIcon(PhosphorIconsFill.info),
                child: const Text('Blue item'),
                onPressed: () {},
              ),
              MantineMenuItem(
                color: 'teal',
                leftSection: const PhosphorIcon(PhosphorIconsFill.checkCircle),
                child: const Text('Teal item'),
                onPressed: () {},
              ),
              MantineMenuItem(
                color: 'pink',
                leftSection: const PhosphorIcon(PhosphorIconsFill.heart),
                child: const Text('Pink item'),
                onPressed: () {},
              ),
              MantineMenuItem(
                color: 'orange',
                leftSection: const PhosphorIcon(PhosphorIconsFill.warning),
                child: const Text('Orange item'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
