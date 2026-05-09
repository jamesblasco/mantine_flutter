# mantine

A Flutter port of the [Mantine](https://mantine.dev) React UI component library.

**Constraints:** `flutter/widgets.dart` only — no Material, no Cupertino, no third-party runtime dependencies. Theme propagation via `InheritedWidget`. Dart 3 throughout.

---

## What's built (Phase 1)

### Foundation
| Module | Description |
| --- | --- |
| `MantineSize` | `xs / sm / md / lg / xl` enum used by all components |
| `MantineColors` | 14 color palettes × 10 shades; `MantineColorScale` |
| `MantineSpacing` | Token-based spacing (4 → 32 px) |
| `MantineRadius` | Token-based border radius (2 → 32 px) |
| `MantineTypography` | Body (xs–xl) and heading (h1–h6) `TextStyle` presets |
| `MantineBreakpoints` | Responsive breakpoint values |
| `MantineShadows` | `List<BoxShadow>` per size |
| `color_utils` | `darken / lighten / mix` helpers |

### Theme
| Symbol | Description |
| --- | --- |
| `MantineThemeData` | Immutable token bag; `copyWith`; `primaryColorScale` / `primaryColorValue` |
| `MantineProvider` | `InheritedWidget`-based theme scope; pass `brightness` for dark mode |
| `context.mantineTheme` | Theme access extension on `BuildContext` |
| `context.isDarkMode` | Brightness extension; plus semantic color getters (`mantineBackground`, `mantineSurface`, `mantineBodyText`, `mantineBorder`, `mantineDimmedText`) |

### Components (15)
| Component | File |
| --- | --- |
| `MantineButton` | `components/button/button.dart` |
| `MantineText` | `components/text/text.dart` |
| `MantineTitle` | `components/text/title.dart` |
| `MantineBox` | `components/layout/box.dart` |
| `MantineStack` | `components/layout/stack.dart` |
| `MantineGroup` | `components/layout/group.dart` |
| `MantineContainer` | `components/layout/container.dart` |
| `MantineBadge` | `components/data_display/badge.dart` |
| `MantineCard` | `components/data_display/card.dart` |
| `MantineDivider` | `components/data_display/divider.dart` |
| `MantineLoader` | `components/feedback/loader.dart` |
| `MantineTextInput` | `components/inputs/text_input.dart` |
| `MantineCheckbox` | `components/inputs/checkbox.dart` |
| `MantineSwitch` | `components/inputs/switch.dart` |
| `showMantineModal` | `components/overlay/modal.dart` |

---

## Roadmap

### Phase 2 — Core interactive components

These cover the highest-frequency use cases across typical apps.

| Component | Mantine equivalent | Notes |
| --- | --- | --- |
| `MantineActionIcon` | `ActionIcon` | Icon-only button; same variant/size system as `MantineButton` |
| `MantineCloseButton` | `CloseButton` | Convenience wrapper over `MantineActionIcon` with an X icon |
| `MantineAvatar` | `Avatar` | Image, initials fallback, color-based placeholder |
| `MantineAlert` | `Alert` | Coloured alert box; `title`, `icon`, `variant` (filled/light/outline) |
| `MantineTooltip` | `Tooltip` | Overlay widget; `Overlay` entry on the `Navigator`; position enum |
| `MantinePopover` | `Popover` | Anchor-relative floating panel; base for `Menu`, `HoverCard`, `Select` |
| `MantineMenu` | `Menu` | Dropdown menu built on `MantinePopover`; `Menu.Item`, `Menu.Divider`, `Menu.Label` |
| `MantineTabs` | `Tabs` | `Tabs`, `Tabs.Tab`, `Tabs.Panel`; `TabsVariant` (default/pills/outline) |
| `MantineSelect` | `NativeSelect` | Single-value picker; start with Flutter `DropdownButton`-free custom `Popover` list |
| `MantineRadio` | `Radio` | `CustomPainter` radio ring; `MantineRadioGroup` wrapper |
| `MantineSegmentedControl` | `SegmentedControl` | Animated sliding indicator via `AnimationController` |
| `MantineProgress` | `Progress` | Animated fill bar; `striped`, `animated`, multiple sections |
| `MantineSkeleton` | `Skeleton` | Shimmer animation via `CustomPainter` or `ColorTween` |
| `MantineTextarea` | `Textarea` | Multi-line `EditableText`; min/max rows; auto-grow |
| `MantineNumberInput` | `NumberInput` | `MantineTextInput` + increment/decrement controls |
| `MantinePaper` | `Paper` | `DecoratedBox` with theme surface color, radius, shadow |

### Phase 3 — Navigation & layout

| Component | Mantine equivalent | Notes |
| --- | --- | --- |
| `MantineAppShell` | `AppShell` | Header + navbar + aside + footer scaffold with `InheritedWidget` collapse state |
| `MantineNavLink` | `NavLink` | Sidebar navigation link; active state; nested children |
| `MantineBreadcrumbs` | `Breadcrumbs` | Separator-joined list of links |
| `MantineGrid` | `Grid` / `SimpleGrid` | 12-column grid with responsive breakpoint spans |
| `MantineFlex` | `Flex` | Thin wrapper over `Flex` widget with theme-token gap/align/justify |
| `MantineCenter` | `Center` | Thin wrapper; useful for consistent API surface |
| `MantineScrollArea` | `ScrollArea` | `SingleChildScrollView` + custom scrollbar painted with `CustomPainter` |
| `MantineStepper` | `Stepper` | Step indicator + content panels; `MantineStepperStep` |
| `MantinePagination` | `Pagination` | Page number row; `MantineSize` sizing; ellipsis for large ranges |
| `MantineTabs` (vertical) | `Tabs` | Extend phase 2 `MantineTabs` with `orientation: vertical` |

### Phase 4 — Rich data display

| Component | Mantine equivalent | Notes |
| --- | --- | --- |
| `MantineTable` | `Table` | Striped, highlight-on-hover, sticky header; `MantineTableRow`, `MantineTableTh/Td` |
| `MantineList` | `List` | Ordered/unordered list; `MantineListItem`; icon support |
| `MantineTimeline` | `Timeline` | Vertical timeline with `MantineTimelineItem`; `active` item |
| `MantineAccordion` | `Accordion` | Animated collapse; `MantineAccordionItem`; `multiple` mode |
| `MantineCollapse` | `Collapse` | `SizeTransition`-based animated height |
| `MantineIndicator` | `Indicator` | Badge dot overlay on any child widget |
| `MantineImage` | `Image` | Image with fallback; `fit` options |
| `MantineAvatar.Group` | `Avatar.Group` | Stacked avatars with overflow count |
| `MantineCode` | `Code` | Inline and block code with monospace styling |
| `MantineKbd` | `Kbd` | Keyboard key display |
| `MantineMark` | `Mark` | Highlighted inline text span |
| `MantineHighlight` | `Highlight` | Highlight substrings within a string |
| `MantineSpoiler` | `Spoiler` | "Show more / show less" text truncation |
| `MantineRingProgress` | `RingProgress` | Circular progress/donut indicator via `CustomPainter` |
| `MantineSlider` | `Slider` / `RangeSlider` | Draggable track; `GestureDetector` + `CustomPainter` |

### Phase 5 — Advanced form inputs

| Component | Mantine equivalent | Notes |
| --- | --- | --- |
| `MantinePasswordInput` | `PasswordInput` | `MantineTextInput` + show/hide toggle |
| `MantinePinInput` | `PinInput` | OTP / PIN code; `n` individual `EditableText` cells |
| `MantineMultiSelect` | `MultiSelect` | Searchable multi-value picker with `Pill` tags |
| `MantineTagsInput` | `TagsInput` | Free-text tag entry |
| `MantineColorPicker` | `ColorPicker` | HSV picker; hue + alpha sliders; hex/rgb inputs |
| `MantineColorInput` | `ColorInput` | `MantineTextInput` + `MantineColorPicker` popover |
| `MantineFileButton` | `FileButton` | Wraps `html.InputElement` on web; shares API on mobile |
| `MantineRating` | `Rating` | Star/custom-icon rating input |
| `MantineChip` | `Chip` | Toggleable inline pill; single and multi-select groups |
| `MantineSegmentedControl` | `SegmentedControl` | Already listed in phase 2; full multi-item polish here |

### Phase 6 — Overlay & notification system

| Component | Mantine equivalent | Notes |
| --- | --- | --- |
| `MantineDrawer` | `Drawer` | Side-panel overlay; same `PopupRoute` approach as `Modal` |
| `MantineNotification` | `Notification` | Single notification widget |
| `showMantineNotification` | Notifications system | Global overlay list; `OverlayEntry` on root `Navigator`; auto-dismiss timer |
| `MantineDialog` | `Dialog` | Fixed-position overlay (not centered); `MantineDialogPosition` enum |
| `MantineOverlay` | `Overlay` | Semi-transparent full-screen cover |
| `MantineTransition` | `Transition` | Named animation presets (fade, slide, zoom, etc.) wrapping Flutter `AnimatedWidget` |
| `MantineLoadingOverlay` | `LoadingOverlay` | Full-area loader overlay |
| `MantineHoverCard` | `HoverCard` | `MantinePopover` triggered by `MouseRegion` hover delay |
| `MantineSpotlight` | `Spotlight` | Command-palette modal; fuzzy search over registered actions |

---

## `@mantine/hooks` — Flutter utilities

React hooks are function-scoped state/effect helpers. The Flutter equivalents are `ValueNotifier`-based utility classes (hold state, expose named methods, work with `ValueListenableBuilder` or `ListenableBuilder`). All live in `lib/src/utils/`.

### State utilities

| Flutter class | Mantine hook | Description |
| --- | --- | --- |
| `MantineDisclosure` | `use-disclosure` | `ValueNotifier<bool>` with `open()`, `close()`, `toggle()` |
| `MantineCounter` | `use-counter` | `ValueNotifier<int>` with `increment()`, `decrement()`, `reset()`; `min`/`max` clamping |
| `MantineToggle<T>` | `use-toggle` | `ValueNotifier<T>` that cycles between two provided values |
| `MantineListState<T>` | `use-list-state` | `ValueNotifier<List<T>>` with `append`, `prepend`, `insert`, `remove`, `reorder`, `filter`, `applyWhere` |
| `MantineMapState<K,V>` | `use-map` | `ValueNotifier<Map<K,V>>` with `set`, `remove`, `merge` |
| `MantineSetState<T>` | `use-set` | `ValueNotifier<Set<T>>` with `add`, `remove`, `toggle` |
| `MantineQueue<T>` | `use-queue` | FIFO `ValueNotifier<List<T>>` with `add`, `shift` |
| `MantineStateHistory<T>` | `use-state-history` | `ValueNotifier<T>` with `undo()`, `redo()`, `history` / `future` lists |
| `MantinePaginationState` | `use-pagination` | `page`, `total`, `pageSize`; `next()`, `previous()`, `setPage()`; computed `range` |
| `MantineValidatedState<T>` | `use-validated-state` | `ValueNotifier<T>` with a validator; exposes `error` alongside `value` |
| `MantineUncontrolled<T>` | `use-uncontrolled` | Returns a `(value, onChange)` pair that supports both controlled and uncontrolled usage |

### Async / timing utilities

| Flutter class | Mantine hook | Description |
| --- | --- | --- |
| `MantineInterval` | `use-interval` | Manages a `Timer.periodic`; `start()`, `stop()`, `toggle()` |
| `MantineTimeout` | `use-timeout` | Manages a one-shot `Timer`; `start(delay)`, `clear()` |
| `MantineDebounced<T>` | `use-debounce` | `ValueNotifier<T>` that delays emitting until `duration` elapses with no new writes |
| `MantineThrottled<T>` | `use-throttle` | `ValueNotifier<T>` that emits at most once per `duration` |

### Platform notes

Several hooks have direct Flutter API equivalents and don't need porting:

| Mantine hook | Flutter equivalent |
| --- | --- |
| `use-viewport-size` | `MediaQuery.sizeOf(context)` |
| `use-color-scheme` | `MediaQuery.platformBrightnessOf(context)` |
| `use-media-query` | `MediaQuery.of(context)` |
| `use-hover` | `MouseRegion(onEnter/onExit)` |
| `use-focus-within` | `FocusScope` + `Focus.onFocusChange` |
| `use-focus-trap` | `FocusTrap` widget (`flutter/widgets.dart`) |
| `use-clipboard` | `Clipboard.setData` / `getData` from `services.dart` |
| `use-scroll-into-view` | `ScrollController.animateTo` / `Scrollable.ensureVisible` |
| `use-element-size` | `LayoutBuilder` or `SizeChangedLayoutNotifier` |
| `use-reduced-motion` | `MediaQuery.disableAnimationsOf(context)` |
| `use-previous` | Local `_previous` field updated in `didUpdateWidget` |
| `use-is-first-render` | `_didMount` bool set in `initState` / `didChangeDependencies` |

### Worth porting (no direct Flutter equivalent)

| Flutter class | Mantine hook | Description |
| --- | --- | --- |
| `MantineIdle` | `use-idle` | Fires callback after `duration` of no pointer/key events; resets on activity |
| `MantineClickOutside` | `use-click-outside` | Calls `handler` when a tap is detected outside a given `GlobalKey`'s bounds |
| `MantineHotkeys` | `use-hotkeys` | Registers `HardwareKeyboard` shortcuts with modifier-key support; auto-removes on dispose |
| `MantineLocalStorage<T>` | `use-local-storage` | Syncs a `ValueNotifier<T>` with platform storage (web `localStorage`; mobile `SharedPreferences`) — requires `shared_preferences` in the *consumer* package, not the library |

---

## Additional packages

### `mantine_notifications` (= `@mantine/notifications`)

Already outlined in Phase 6. Separate package so apps that don't need toasts don't pay for the overlay machinery.

| Symbol | Description |
| --- | --- |
| `showMantineNotification` | Push a notification onto the global queue |
| `hideMantineNotification` | Remove by id |
| `MantineNotificationsProvider` | Must wrap the app; manages `OverlayEntry` stack |
| `MantineNotification` | Single notification widget (icon, title, message, progress bar) |
| `MantineNotificationData` | Pure data class: `id`, `title`, `message`, `color`, `icon`, `autoClose`, `onClose` |

### `mantine_spotlight` (= `@mantine/spotlight`)

Also in Phase 6. Separate package.

| Symbol | Description |
| --- | --- |
| `MantineSpotlightProvider` | Registers `HardwareKeyboard` shortcut (default `⌘K` / `Ctrl+K`); wraps app |
| `showMantineSpotlight` | Opens the spotlight modal programmatically |
| `MantineSpotlightAction` | Data class: `id`, `label`, `description`, `icon`, `onTrigger` |
| `MantineSpotlightFilter` | Pluggable fuzzy/exact filter function |

### `mantine_dates` (= `@mantine/dates`)

| Component | Notes |
| --- | --- |
| `MantineCalendar` | Month grid; single / range / multiple day selection; `CustomPainter` for day cells |
| `MantineMiniCalendar` | Compact calendar; fewer controls |
| `MantineDatePicker` | Inline picker wrapping `MantineCalendar` |
| `MantineMonthPicker` | Month grid selection |
| `MantineYearPicker` | Year grid selection |
| `MantineDatePickerInput` | `MantineTextInput` + `MantinePopover` with `MantineDatePicker` |
| `MantineMonthPickerInput` | Same pattern for month |
| `MantineYearPickerInput` | Same pattern for year |
| `MantineTimeInput` | HH:MM text field; up/down arrow key increment |
| `MantineTimePicker` | Scroll-wheel hour/minute/second columns |
| `MantineDateTimePicker` | Combined date + `MantineTimePicker` |
| `MantineTimeGrid` | Predefined time slot grid (e.g. appointment booking) |
| `MantineTimeValue` | Read-only formatted time display |

### `mantine_charts` (= `@mantine/charts`)

`CustomPainter`-based; no dependency on `fl_chart` unless the implementation team decides otherwise.

| Component | Notes |
| --- | --- |
| `MantineSparkline` | Lightweight area line; simplest to implement first |
| `MantineLineChart` | Multi-series line chart; `ChartTooltip`, `ChartLegend` |
| `MantineAreaChart` | Filled area; stacked and percent variants |
| `MantineBarChart` | Vertical/horizontal bars; stacked and percent variants |
| `MantineBarsList` | Non-chart bar list (progress-bar style table) |
| `MantinePieChart` | Pie slices via `canvas.drawArc` |
| `MantineDonutChart` | `MantinePieChart` with inner radius cutout |
| `MantineCompositeChart` | Mix Area + Bar + Line on one canvas |
| `MantineRadarChart` | N-axis polygon chart |
| `MantineScatterChart` | X/Y scatter plot |
| `MantineRadialBarChart` | Arc-based bar chart |
| `MantineFunnelChart` | Trapezoid funnel |
| `MantineHeatmap` | Day/value grid (GitHub contribution graph style) |
| `MantineTreemap` | Weighted rectangle packing |
| `MantineBubbleChart` | Scatter with variable dot radius |

### `mantine_carousel` (= `@mantine/carousel`)

| Symbol | Notes |
| --- | --- |
| `MantineCarousel` | `PageView`-based; snap, loop, auto-play |
| `MantineCarousel.Slide` | Individual slide wrapper with padding |
| `MantineCarouselOrientation` | horizontal / vertical |
| `MantineCarouselIndicators` | Dot indicators synced to `PageController` |

### `mantine_code_highlight` (= `@mantine/code-highlight`)

Depends on a syntax-highlighting engine. Use `highlight` (pub.dev) for language grammars.

| Symbol | Notes |
| --- | --- |
| `MantineCodeHighlight` | Single code block; language detection; copy button |
| `MantineCodeHighlightTabs` | Tabbed multi-file code viewer |
| `MantineInlineCodeHighlight` | Inline span with syntax coloring |
| `MantineCodeHighlightTheme` | Light/dark token color map |

### `mantine_dropzone` (= `@mantine/dropzone`)

Desktop/web only for drag-and-drop; mobile falls back to file picker.

| Symbol | Notes |
| --- | --- |
| `MantineDropzone` | Drop target area; `onDrop`, `onReject`, `accept` mime types |
| `MantineDropzoneStatus` | `idle / active / accept / reject` |
| `MantineFullScreenDropzone` | Listens to window-level drag events |

### `mantine_schedule` (= `@mantine/schedule`)

Calendar/scheduling views — the most complex separate package.

| Component | Notes |
| --- | --- |
| `MantineSchedule` | Container with day/week/month/year view switcher |
| `MantineDayView` | Hourly time slots for a single day |
| `MantineWeekView` | 7-column hourly grid |
| `MantineMonthView` | Month calendar grid with event chips |
| `MantineYearView` | 12-month overview |
| `MantineMobileMonthView` | Compact mobile-optimised month grid |

---

## Phase 7 — Dates package (`@mantine/dates`)

See `mantine_dates` above. Implement in this order: `MantineCalendar` → `MantineDatePicker` → input wrappers → time components → combined `MantineDateTimePicker`.

### Phase 8 — Charts package (`@mantine/charts`)

See `mantine_charts` above. Implement in this order: `MantineSparkline` (simplest) → `MantineLineChart` → `MantineBarChart` → `MantinePieChart` / `MantineDonutChart` → composite and specialty charts.

---

## Development guidelines

### Constraints (non-negotiable)
- Import only `package:flutter/widgets.dart`, `package:flutter/painting.dart`, `package:flutter/services.dart`, `package:flutter/scheduler.dart`, `package:flutter/gestures.dart` — never `material.dart` or `cupertino.dart`
- No runtime third-party dependencies in the library package
- All theme data types `@immutable` with `copyWith`
- All size/spacing/radius values resolve through theme tokens

### Patterns to follow
- **Stateful interaction** — `MouseRegion` + `GestureDetector` with `_hovered` / `_pressed` state
- **Animations** — `AnimationController` with `SingleTickerProviderStateMixin`; always `dispose()`
- **Custom visuals** — `CustomPainter` for anything that can't be composed from boxes (checkmarks, arcs, sliders, sparklines)
- **Overlays** — `PopupRoute` (gives Navigator integration, barrier, back/escape for free)
- **No Material `TextField`** — use `EditableText` with a `Stack` overlay for placeholder text
- **Dark mode** — semantic color getters on `BuildContext` (`mantineBackground`, `mantineSurface`, `mantineBodyText`, `mantineBorder`, `mantineDimmedText`) adapt automatically; no component should hardcode a color
- **Exhaustive switch** — use Dart 3 exhaustive `switch` expressions on `MantineSize`; the compiler enforces all cases

### Adding a new component checklist
1. Create `lib/src/components/<category>/<name>.dart`
2. Export it from `lib/mantine.dart`
3. Add a `GallerySection` for it in the appropriate example screen
4. Run `flutter analyze` — zero issues before committing

---

## Quick start

```yaml
# pubspec.yaml
dependencies:
  mantine:
    path: ../mantine   # or pub.dev once published
```

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

---

## Running the example gallery

```bash
cd packages/example
flutter pub get
flutter run -d macos   # or chrome, ios, android
```

The gallery shows all Phase 1 components in both light and dark mode, with a primary color picker in the sidebar.
