import 'package:flutter/material.dart';
import 'package:i18next/i18next.dart';

extension Translation on String {
  String translate(BuildContext context, {Map<String, dynamic>? args}) {
    if (args != null) {
      return I18Next.of(context)!.t(this, variables: args);
    }
    return I18Next.of(context)!.t(this);
  }
}
