import 'package:beta_tasker/core/app_colors.dart';
import 'package:beta_tasker/data/network/network_auth_service.dart';
import 'package:beta_tasker/utils/routes/routes.dart';
import 'package:beta_tasker/view/create_account_view/signup_option_view.dart';
import 'package:beta_tasker/view/landing_view.dart';
import 'package:beta_tasker/view/practice.dart';
import 'package:beta_tasker/view/signin_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  bool show = true;
  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3))
          ..repeat();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //to change the color of status bar

    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //     statusBarColor:
    //         AppColors.whiteColor, //or set color with: Color(0xFF0000FF)
    //     statusBarIconBrightness: Brightness.dark));
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(360, 679),
      child: //Practice(),
       StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: SpinKitFadingCircle(
                  color: AppColors.roundButtonDarkColor,
                  controller: _controller,
                ),
              ),
            );
          } else if (snapshot.hasData) {
            return const LandingView();
          } else {
            return const SignupOptionView();
          }
        },
      ),
      builder: (context, child) {
        return MaterialApp(
          // navigatorObservers: [FlutterSmartDialog.observer],
          // builder: FlutterSmartDialog.init(

          // ),
          debugShowCheckedModeBanner: false,
          title: 'Beta Tasker',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          // initialRoute: RoutesName.signupOptionView,
          onGenerateRoute: Routes.generateRoute,
          home: child,
        );
      },
    );
  }
}

// class HomeView extends StatefulWidget {
//   const HomeView({Key? key}) : super(key: key);

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: [
//           Expanded(
//             child: StepProgressIndicator(
//               totalSteps: 100,
//               currentStep: 82,
//               selectedColor: AppColors.whiteColor,
//               unselectedColor: AppColors.blueColor,
//               size: 8.sp,
//               padding: 0.sp,
//               roundedEdges: Radius.circular(5.r),
//             ),
//           ),
//           Expanded(child: MemeberCircleImage())
//         ],
//       ),
//     );
//   }
// }
