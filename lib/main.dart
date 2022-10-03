import 'package:beta_tasker/core/app_colors.dart';
import 'package:beta_tasker/core/common_widgets/recent_projects.dart';
import 'package:beta_tasker/utils/routes/routes.dart';
import 'package:beta_tasker/utils/routes/routes_name.dart';
import 'package:beta_tasker/view/home_view.dart';
import 'package:beta_tasker/view/introduction_view.dart';
import 'package:beta_tasker/view/landing_view.dart';
import 'package:beta_tasker/view/my_project_view.dart';
import 'package:beta_tasker/view/notification_view.dart';
import 'package:beta_tasker/view/practice.dart';
import 'package:beta_tasker/view/recent_projects_view.dart';
import 'package:beta_tasker/view/today_task_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //to change the color of status bar

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor:
            AppColors.whiteColor, //or set color with: Color(0xFF0000FF)
        statusBarIconBrightness: Brightness.dark));
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(360, 679),
      child: const IntroductionView(),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Beta Tasker',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          // initialRoute: RoutesName.introView,
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
