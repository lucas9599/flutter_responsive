import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Exemplo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.indigo,
        iconTheme: const IconThemeData(color: Colors.white),
        dataTableTheme: DataTableThemeData(
          dividerThickness: 1,
          headingTextStyle: const TextStyle(color: Colors.white),
          headingRowHeight: 30,
          headingRowColor: MaterialStatePropertyAll(
            Colors.indigo.withOpacity(0.8),
          ),
        ),
        checkboxTheme: const CheckboxThemeData(
          checkColor: MaterialStatePropertyAll(Colors.blue),
        ),
        colorScheme: const ColorScheme.light(
          primary: Colors.purple,
          secondary: Colors.indigo,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
        ),
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: [const Locale('pt', 'BR')],
    );
  }
}
