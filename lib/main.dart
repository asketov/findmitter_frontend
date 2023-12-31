import 'package:findmitter_frontend/internal/init_app.dart';
import 'package:findmitter_frontend/ui/navigation/app_navigator.dart';
import 'package:findmitter_frontend/ui/widgets/roots/loader.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      navigatorKey: AppNavigator.key,
      onGenerateRoute: (settings) =>
          AppNavigator.onGeneratedRoutes(settings, context),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoaderWidget.create(),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
