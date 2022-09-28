import 'package:beta_tasker/utils/utils.dart';
import 'package:beta_tasker/view/onboarding_view/onboarding1.dart';
import 'package:beta_tasker/view/onboarding_view/onboarding2.dart';
import 'package:beta_tasker/view/onboarding_view/onboarding3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroductionView extends StatefulWidget {
  const IntroductionView({Key? key}) : super(key: key);

  @override
  State<IntroductionView> createState() => _IntroductionViewState();
}

class _IntroductionViewState extends State<IntroductionView> {
  late PageController _pageControler;
  late List list;
  var _pageIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageControler = PageController();
    list = [
      OnBoarding1(
        pageControler: _pageControler,
      ),
      OnBoarding2(pageControler: _pageControler,),
      OnBoarding3(pageController: _pageControler,)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [_pageView(), _dotIndicator()],
    ));
  }

  _pageView() {
    return PageView.builder(
      itemCount: list.length,
      controller: _pageControler,
      itemBuilder: (context, index) {
        return list[index];
      },
      onPageChanged: (value) {
        //check the normal varaible changed or not
        _pageIndex = value;
      },
    );
  }

  _dotIndicator() {
    return Positioned(
      left: 150.w,
      top: 480.h,
      child: Utils.smoothIndicator(list, _pageControler),
    );
  }
}

