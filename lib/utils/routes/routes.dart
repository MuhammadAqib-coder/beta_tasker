import 'package:beta_tasker/utils/routes/routes_name.dart';
import 'package:beta_tasker/view/introduction_view.dart';
import 'package:beta_tasker/view/onboarding_view/onboarding1.dart';
import 'package:beta_tasker/view/onboarding_view/onboarding2.dart';
import 'package:beta_tasker/view/onboarding_view/onboarding3.dart';
import 'package:beta_tasker/view/profile_view.dart';
import 'package:flutter/material.dart';

import '../../view/create_account_view/signUp_email_password_view.dart';
import '../../view/create_account_view/signup_option_view.dart';
import '../../view/forget_password_view.dart';
import '../../view/home_view.dart';
import '../../view/landing_view.dart';
import '../../view/my_project_view.dart';
import '../../view/notification_view.dart';
import '../../view/recent_projects_view.dart';
import '../../view/signin_view.dart';
import '../../view/splash_view.dart';
import '../../view/today_task_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.introView:
        return MaterialPageRoute(builder: (_) => const IntroductionView());
      // case RoutesName.onBoardView1:
      //   return MaterialPageRoute(builder: (_) =>  OnBoarding1());
      // case RoutesName.onBoardView2:
      //   return MaterialPageRoute(builder: (_) => const OnBoarding2());
      // case RoutesName.onBoardView3:
      //   return MaterialPageRoute(builder: (_) => const OnBoarding3());
      case RoutesName.editProfileView:
        return MaterialPageRoute(builder: (_) => const ProfileView());
      case RoutesName.forgetPasswordView:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordView());
      case RoutesName.recentProjectView:
        return MaterialPageRoute(builder: (_) => const RecentProjectsView());
      case RoutesName.todayTaskView:
        return MaterialPageRoute(builder: (_) => const TodayTaskView());
      case RoutesName.homeView:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case RoutesName.landingView:
        return MaterialPageRoute(builder: (_) => const LandingView());
      case RoutesName.myProjectView:
        return MaterialPageRoute(builder: (_) => const MyProjectView());
      case RoutesName.splashView:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case RoutesName.signupOptionView:
        return MaterialPageRoute(builder: (_) => const SignupOptionView());
      case RoutesName.signupEmailPasswordView:
        return MaterialPageRoute(
            builder: (_) => const SignupEmailPasswordView());
      case RoutesName.signinView:
        return MaterialPageRoute(
            builder: (_) => const SigninView());
            case RoutesName.notificationView:
        return MaterialPageRoute(
            builder: (_) => const NotificationView());
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(
                    child: Text('No Route Found'),
                  ),
                ));
    }
  }
}
