import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fundpad/provider/home_provider.dart';
import 'package:fundpad/view/welcome/splash_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: HomeProvider())],
      child: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Fundpad',
            theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: Colors.white,
              appBarTheme: const AppBarTheme(
                color: Colors.white,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(color: Colors.black),
                actionsIconTheme: IconThemeData(color: Colors.black),
              ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              fontFamily: GoogleFonts.nunito().fontFamily,
              // textTheme: GoogleFonts.nunitoTextTheme(
              //   Theme.of(context).textTheme,
              // ),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              fontFamily: GoogleFonts.nunito().fontFamily,
            ),
            themeMode: provider.getThemeMode(),
            home: const SplashPage(),
          );
        },
      ),
    );
  }
}
