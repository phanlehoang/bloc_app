import 'package:bloc_app/logic/cubits/internet/internet_cubit.dart';
import 'package:bloc_app/logic/no_insulin_cubits/no_insulin_cubit.dart';
import 'package:bloc_app/presentation/router/app_router.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_core/firebase_core.dart';

import 'logic/bar_cubits/navigator_bar_cubit.dart';
import 'logic/patient_cubits/no_insulin_cubits/no_insulin_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(
    connectivity: Connectivity(),
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  final Connectivity connectivity;
  const MyApp({
    Key? key,
    required this.connectivity,
    required this.appRouter,
  }) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext myAppContext) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (internetCubitContext) =>
              InternetCubit(connectivity: connectivity),
        ),
        BlocProvider<BottomNavigatorBarCubit>(
          create: (navigatorBarCubitContext) => BottomNavigatorBarCubit(),
        ),
        BlocProvider<NoInsulinCubit>(
            create: (noInsulinContext) => NoInsulinCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: appRouter.onGeneratedRoute,
      ),
    );
  }
}
