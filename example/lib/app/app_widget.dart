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
        primaryColor: Colors.deepOrange,
        iconTheme: IconThemeData(color: Colors.white),
        dataTableTheme: DataTableThemeData(
          dividerThickness: 1,
          headingTextStyle: TextStyle(color: Colors.white),
          headingRowHeight: 30,
          headingRowColor: MaterialStatePropertyAll(
            Colors.deepOrange.withOpacity(0.8),
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          checkColor: MaterialStatePropertyAll(Colors.blue),
        ),
        colorScheme: ColorScheme.light(
          primary: Colors.red,
          secondary: Colors.brown.shade900,
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
