import 'package:flutter/material.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/utils/app_assets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title:Text( AppLocalizations.of(context)!.update_data),
     ),
      body: Center(
        // child: Image.asset(AppAssets.empty),
      ),
    );
  }
}
