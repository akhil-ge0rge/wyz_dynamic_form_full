import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wyz/core/service/di.dart';
import 'package:wyz/features/form/presentation/provider/form_provider.dart';
import 'package:wyz/features/form/presentation/view/form_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Initializes Dependency Injection
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //Register FormProvider by retriving instance from GetIt
        ChangeNotifierProvider(create: (context) => di<FormProvider>())
      ],
      child: MaterialApp(
        title: 'Dynamic Form',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const FormScreen(),
      ),
    );
  }
}
