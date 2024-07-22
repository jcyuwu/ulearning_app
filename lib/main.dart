import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/routes/routes.dart';
import 'package:ulearning_app/common/utils/app_styles.dart';
import 'package:ulearning_app/features/global.dart';

Future<void> main() async {
  await Global.init();

  // var obj1 = HttpUtil();
  // var obj2 = HttpUtil();
  // if (obj1.hashCode == obj2.hashCode) {
  //   print("I am the singleton class");
  // }

  // HttpUtil().post("api/login", queryParameters: {
  //   "name" : "eeee",
  //   "email": "eeee@e.com",
  //   "avatar": "xyz.com",
  //   "open_id": "dawdad awdadas",
  //   "type": 2,
  // });

  runApp(const ProviderScope(child: MyApp()));
}

// var routesMap = {
//   AppRoutesNames.WELCOME: (context) => Welcome(),
//   AppRoutesNames.SIGN_IN: (context) => const SignIn(),
//   AppRoutesNames.REGISTER: (context) => const SignUp(),
//   AppRoutesNames.APPLICATION: (context) => const Application(),
// };

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        //minTextAdapt: true,
        //splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (context, child) {
          return MaterialApp(
            navigatorKey: navKey,
            title: 'Flutter Demo',
            theme: AppTheme.appThemeData,
            onGenerateRoute: AppPages.generateRouteSettings,
            //initialRoute: "/",
            //routes: routesMap,
            //home: Welcome(),
          );
        });
  }
}

final appCount = StateProvider<int>((ref) {
  return 1;
});

class MyHomePage extends ConsumerWidget {
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int count = ref.watch(appCount);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Riverpod app"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$count',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
              heroTag: "one",
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const SecondPage()));
              },
              tooltip: 'Increment',
              child: const Icon(Icons.arrow_right_rounded),
            ),
            FloatingActionButton(
              heroTag: "two",
              onPressed: () {
                ref.read(appCount.notifier).state++;
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            )
          ],
        ));
  }
}

class SecondPage extends ConsumerWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int count = ref.watch(appCount);
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Text("$count", style: const TextStyle(fontSize: 30))));
  }
}
