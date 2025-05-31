import 'package:flutter/material.dart';
import 'package:flutter_responsive_template/flutter_responsive.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Exemplo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        primaryColor: Colors.green,
        primaryColorDark: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
        appBarTheme: AppBarTheme(backgroundColor: Colors.green),
        dataTableTheme: DataTableThemeData(
          dividerThickness: 1,
          headingTextStyle: const TextStyle(color: Colors.white),
          headingRowHeight: 30,
          headingRowColor: WidgetStatePropertyAll(
            Colors.green.withValues(alpha: 0.8),
          ),
        ),
        checkboxTheme: const CheckboxThemeData(
          checkColor: WidgetStatePropertyAll(Colors.green),
        ),
        colorScheme: const ColorScheme.light(
          primary: Colors.green,
          secondary: Colors.green,
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
