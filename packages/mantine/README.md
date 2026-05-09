# mantine

A Flutter port of the [Mantine](https://mantine.dev) React UI component library.

Built on `flutter/widgets.dart` only — no Material, no Cupertino, no third-party runtime dependencies. Theme propagation via `InheritedWidget`. Dart 3 throughout.

## Installation

```yaml
dependencies:
  mantine: ^0.1.0
```

## Quick start

```dart
import 'package:mantine/mantine.dart';

void main() {
  runApp(
    MantineProvider(
      brightness: Brightness.light,
      child: WidgetsApp(
        color: MantineColors.blue[6],
        home: MyApp(),
      ),
    ),
  );
}
```

## Dark mode & custom theme

```dart
// Toggle dark mode
MantineProvider(
  brightness: _isDark ? Brightness.dark : Brightness.light,
  child: ...,
)

// Custom theme
MantineProvider(
  theme: MantineThemeData(
    primaryColor: 'violet',
    primaryShade: 5,
    defaultRadius: MantineSize.md,
  ),
  child: ...,
)
```

## Components (Phase 1)

### Foundation tokens

| Symbol | Description |
| --- | --- |
| `MantineSize` | `xs / sm / md / lg / xl` enum used by all components |
| `MantineColors` | 14 color palettes × 10 shades |
| `MantineSpacing` | Token-based spacing (4 → 32 px) |
| `MantineRadius` | Token-based border radius (2 → 32 px) |
| `MantineTypography` | Body and heading `TextStyle` presets |
| `MantineShadows` | `List<BoxShadow>` per size |

### Theme

| Symbol | Description |
| --- | --- |
| `MantineThemeData` | Immutable token bag with `copyWith` |
| `MantineProvider` | `InheritedWidget`-based theme scope |
| `context.mantineTheme` | Theme access extension on `BuildContext` |
| `context.isDarkMode` | Brightness + semantic color getters |

### Components

| Component | Description |
| --- | --- |
| `MantineButton` | Pressable button; `filled / light / outline / subtle / transparent / white` variants |
| `MantineText` | Body text with size/weight/color props |
| `MantineTitle` | Heading levels h1–h6 |
| `MantineBox` | Generic layout box with padding/margin/background |
| `MantineStack` | Vertical stack with theme-token gap |
| `MantineGroup` | Horizontal group with theme-token gap |
| `MantineContainer` | Max-width responsive container |
| `MantineBadge` | Small labelling badge |
| `MantineCard` | Surface card with padding and radius |
| `MantineDivider` | Horizontal or vertical rule |
| `MantineLoader` | `oval / bars / dots` animated loaders |
| `MantineTextInput` | Single-line text field via `EditableText` |
| `MantineCheckbox` | `CustomPainter` checkbox |
| `MantineSwitch` | Animated toggle switch |
| `showMantineModal` | Centered modal via `PopupRoute` |

## Design constraints

- Imports only `flutter/widgets.dart` family — never `material.dart` or `cupertino.dart`
- No runtime third-party dependencies
- All theme data types are `@immutable` with `copyWith`
- All size/spacing/radius values resolve through theme tokens

## License

MIT — see [LICENSE](../../LICENSE).
