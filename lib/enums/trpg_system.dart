import 'package:flutter/material.dart';
import 'package:rpgtracker_app/theme/r_p_g_t_racker_icons_icons.dart';

enum TRPGSystem {
  callOfCthulhu('CALL_OF_CTHULHU', RPGTRackerIcons.octopus);

  const TRPGSystem(this.raw, this.icon);
  final String raw;
  final IconData icon;

  static TRPGSystem? fromJson(String? key) {
    for (var v in values) {
      if (v.raw == key) {
        return v;
      }
    }
    return null;
  }

  static String? toJson(TRPGSystem? key) {
    return key?.raw;
  }
}
