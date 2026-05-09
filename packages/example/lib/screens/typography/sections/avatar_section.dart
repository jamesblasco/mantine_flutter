import 'package:flutter/widgets.dart';
import 'package:mantine/mantine.dart';

class AvatarSection extends StatelessWidget {
  const AvatarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return MantineStack(
      spacingValue: 20,
      children: [
        const MantineText('Various sizes:'),
        const MantineGroup(
          children: [
            MantineAvatar(
              size: MantineSize.xs,
              initials: 'XS',
            ),
            MantineAvatar(
              size: MantineSize.sm,
              initials: 'SM',
            ),
            MantineAvatar(
              size: MantineSize.md,
              initials: 'MD',
            ),
            MantineAvatar(
              size: MantineSize.lg,
              initials: 'LG',
            ),
            MantineAvatar(
              size: MantineSize.xl,
              initials: 'XL',
            ),
          ],
        ),
        const MantineText('Various radiuses:'),
        const MantineGroup(
          children: [
            MantineAvatar(
              radius: MantineSize.xs,
              initials: 'XS',
            ),
            MantineAvatar(
              radius: MantineSize.sm,
              initials: 'SM',
            ),
            MantineAvatar(
              radius: MantineSize.md,
              initials: 'MD',
            ),
            MantineAvatar(
              radius: MantineSize.lg,
              initials: 'LG',
            ),
            MantineAvatar(
              radius: MantineSize.xl,
              initials: 'XL',
            ),
            MantineAvatar(
              radius: 0.0,
              initials: 'SQ',
            ),
          ],
        ),
        const MantineText('Various colors:'),
        const MantineGroup(
          children: [
            MantineAvatar(color: 'blue', initials: 'BL'),
            MantineAvatar(color: 'red', initials: 'RD'),
            MantineAvatar(color: 'green', initials: 'GR'),
            MantineAvatar(color: 'orange', initials: 'OR'),
            MantineAvatar(color: 'cyan', initials: 'CY'),
            MantineAvatar(color: 'pink', initials: 'PK'),
          ],
        ),
        const MantineText('Image and fallbacks:'),
        MantineGroup(
          children: [
            const MantineAvatar(
              image: Image(image: NetworkImage('https://raw.githubusercontent.com/mantinedev/mantine/master/.demo/avatars/avatar-7.png')),
              initials: 'JD',
            ),
            const MantineAvatar(
              image: Image(image: NetworkImage('https://invalid-url.com/avatar.png')),
              initials: 'JD',
            ),
            const MantineAvatar(
              initials: 'John Doe',
            ),
            const MantineAvatar(),
          ],
        ),
      ],
    );
  }
}
