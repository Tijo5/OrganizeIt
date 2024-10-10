import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider, PhoneAuthProvider;
import 'package:provider/provider.dart';
import 'src/authentication.dart';
import 'src/widgets.dart';
import 'app_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'locale_provider.dart'; // Importer le LocaleProvider

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _changeLanguage(BuildContext context) {
    final localeProvider = LocaleProvider.of(context);
    if (localeProvider != null) {
      final locale = localeProvider.locale;
      final newLocale = locale.languageCode == 'en' ? const Locale('fr') : const Locale('en');
      localeProvider.changeLocale(newLocale);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: Image.asset("assets/images/todo.jpg"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 40),
              child: Text(
                AppLocalizations.of(context)!.helloWorld,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Consumer<ApplicationState>(
              builder: (context, appState, _) => AuthFunc(
                loggedIn: appState.loggedIn,
                signOut: () {
                  FirebaseAuth.instance.signOut();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                AppLocalizations.of(context)!.language,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () => _changeLanguage(context),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.green, // Couleur du texte noir
              ),
              child: Text(AppLocalizations.of(context)!.language),
            ),
          ],
        ),
      ),
    );
  }
}
