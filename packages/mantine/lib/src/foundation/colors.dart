import 'dart:ui';

import 'package:flutter/foundation.dart';

@immutable
class MantineColorScale {
  const MantineColorScale(this._shades);

  final List<Color> _shades;

  Color operator [](int index) {
    assert(index >= 0 && index <= 9);
    return _shades[index];
  }

  Color get shade0 => _shades[0];
  Color get shade1 => _shades[1];
  Color get shade2 => _shades[2];
  Color get shade3 => _shades[3];
  Color get shade4 => _shades[4];
  Color get shade5 => _shades[5];
  Color get shade6 => _shades[6];
  Color get shade7 => _shades[7];
  Color get shade8 => _shades[8];
  Color get shade9 => _shades[9];
}

abstract class MantineColors {
  MantineColors._();

  static const MantineColorScale dark = MantineColorScale([
    Color(0xFFC1C2C5), Color(0xFFA6A7AB), Color(0xFF909296),
    Color(0xFF5C5F66), Color(0xFF373A40), Color(0xFF2C2E33),
    Color(0xFF25262B), Color(0xFF1A1B1E), Color(0xFF141517),
    Color(0xFF101113),
  ]);

  static const MantineColorScale gray = MantineColorScale([
    Color(0xFFF8F9FA), Color(0xFFF1F3F5), Color(0xFFE9ECEF),
    Color(0xFFDEE2E6), Color(0xFFCED4DA), Color(0xFFADB5BD),
    Color(0xFF868E96), Color(0xFF495057), Color(0xFF343A40),
    Color(0xFF212529),
  ]);

  static const MantineColorScale red = MantineColorScale([
    Color(0xFFFFF5F5), Color(0xFFFFE3E3), Color(0xFFFFCCCC),
    Color(0xFFFF8787), Color(0xFFFF6B6B), Color(0xFFFA5252),
    Color(0xFFF03E3E), Color(0xFFE03131), Color(0xFFC92A2A),
    Color(0xFFB52929),
  ]);

  static const MantineColorScale pink = MantineColorScale([
    Color(0xFFFFF0F6), Color(0xFFFFDEEB), Color(0xFFFCC2D7),
    Color(0xFFFFA8C9), Color(0xFFFF8DC4), Color(0xFFF06595),
    Color(0xFFE64980), Color(0xFFD6336C), Color(0xFFC2255C),
    Color(0xFFA61E4D),
  ]);

  static const MantineColorScale grape = MantineColorScale([
    Color(0xFFF8F0FC), Color(0xFFF3D9FA), Color(0xFFEEBEFA),
    Color(0xFFE599F7), Color(0xFFDA77F2), Color(0xFFCC5DE8),
    Color(0xFFBE4BDB), Color(0xFFAE3EC9), Color(0xFF9C36B5),
    Color(0xFF862E9C),
  ]);

  static const MantineColorScale violet = MantineColorScale([
    Color(0xFFF3F0FF), Color(0xFFE5DBFF), Color(0xFFD0BFFF),
    Color(0xFFB197FC), Color(0xFF9775FA), Color(0xFF845EF7),
    Color(0xFF7950F2), Color(0xFF7048E8), Color(0xFF6741D9),
    Color(0xFF5F3DC4),
  ]);

  static const MantineColorScale indigo = MantineColorScale([
    Color(0xFFEDF2FF), Color(0xFFE0EAFF), Color(0xFFC5D8FF),
    Color(0xFFA5C0FF), Color(0xFF74A0FF), Color(0xFF4C6EF5),
    Color(0xFF4263EB), Color(0xFF3B5BDB), Color(0xFF364FC7),
    Color(0xFF2F44AD),
  ]);

  static const MantineColorScale blue = MantineColorScale([
    Color(0xFFE7F5FF), Color(0xFFD0EBFF), Color(0xFFA5D8FF),
    Color(0xFF74C0FC), Color(0xFF4DABF7), Color(0xFF339AF0),
    Color(0xFF228BE6), Color(0xFF1C7ED6), Color(0xFF1971C2),
    Color(0xFF1864AB),
  ]);

  static const MantineColorScale cyan = MantineColorScale([
    Color(0xFFE3FAFC), Color(0xFFC5F6FA), Color(0xFF99E9F2),
    Color(0xFF66D9E8), Color(0xFF3BC9DB), Color(0xFF22B8CF),
    Color(0xFF15AABF), Color(0xFF1098AD), Color(0xFF0C8599),
    Color(0xFF0B7285),
  ]);

  static const MantineColorScale teal = MantineColorScale([
    Color(0xFFE6FCF5), Color(0xFFC3FAE8), Color(0xFF96F2D7),
    Color(0xFF63E6BE), Color(0xFF38D9A9), Color(0xFF20C997),
    Color(0xFF12B886), Color(0xFF0CA678), Color(0xFF099268),
    Color(0xFF087F5B),
  ]);

  static const MantineColorScale green = MantineColorScale([
    Color(0xFFEBFBEE), Color(0xFFD3F9D8), Color(0xFFB2F2BB),
    Color(0xFF8CE99A), Color(0xFF69DB7C), Color(0xFF51CF66),
    Color(0xFF40C057), Color(0xFF37B24D), Color(0xFF2F9E44),
    Color(0xFF2B8A3E),
  ]);

  static const MantineColorScale lime = MantineColorScale([
    Color(0xFFF4FCE3), Color(0xFFE9FAC8), Color(0xFFD8F5A2),
    Color(0xFFC0EB75), Color(0xFFA9E34B), Color(0xFF94D82D),
    Color(0xFF82C91E), Color(0xFF74B816), Color(0xFF66A80F),
    Color(0xFF5C940D),
  ]);

  static const MantineColorScale yellow = MantineColorScale([
    Color(0xFFFFF9DB), Color(0xFFFFF3BF), Color(0xFFFFEC99),
    Color(0xFFFFE066), Color(0xFFFFD43B), Color(0xFFFCC419),
    Color(0xFFFAB005), Color(0xFFF59F00), Color(0xFFF08C00),
    Color(0xFFE67700),
  ]);

  static const MantineColorScale orange = MantineColorScale([
    Color(0xFFFFF4E6), Color(0xFFFFE8CC), Color(0xFFFFD8A8),
    Color(0xFFFFC078), Color(0xFFFF922B), Color(0xFFFD7E14),
    Color(0xFFF76707), Color(0xFFE8590C), Color(0xFFD9480F),
    Color(0xFFCC3D0A),
  ]);

  static MantineColorScale resolve(String name) => switch (name) {
    'dark'   => dark,
    'gray'   => gray,
    'red'    => red,
    'pink'   => pink,
    'grape'  => grape,
    'violet' => violet,
    'indigo' => indigo,
    'blue'   => blue,
    'cyan'   => cyan,
    'teal'   => teal,
    'green'  => green,
    'lime'   => lime,
    'yellow' => yellow,
    'orange' => orange,
    _        => blue,
  };
}
