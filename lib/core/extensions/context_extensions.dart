import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../app/styles/color_extensions.dart';
import '../app/styles/text_extensions.dart';

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  AppLocalizations get tr => AppLocalizations.of(this);

  AppColorScheme get color => Theme.of(this).extension<AppColorScheme>()!;

  AppTextTheme get text => Theme.of(this).extension<AppTextTheme>()!;
}
