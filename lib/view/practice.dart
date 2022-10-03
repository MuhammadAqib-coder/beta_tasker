// import 'package:beta_tasker/core/common_widgets/recent_projects.dart';
// import 'package:beta_tasker/images/team_members_images/team_members_images.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_stack/image_stack.dart';

// class Practice extends StatefulWidget {
//   const Practice({Key? key}) : super(key: key);

//   @override
//   State<Practice> createState() => _PracticeState();
// }

// class _PracticeState extends State<Practice> {
//   var imageList = [
//     TeamMemebersImages.teamImage1,
//     TeamMemebersImages.teamImage2,
//     TeamMemebersImages.teamImage3,
//     TeamMemebersImages.teamImage4
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           ImageStack(
//             imageCount: 4,
//             imageList: imageList,
//             totalCount: imageList.length,
//             imageRadius: 20,
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:beta_tasker/core/common_widgets/recent_projects.dart';
import 'package:flutter/material.dart';

import '../core/app_colors.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        //backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 100,
          // leading: IconButton(
          //   onPressed: (){
          //     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx){
          //       return   HomeScreen();
          //     }));
          //   },
          //   icon: const Icon(Icons.arrow_back,color: Colors.black,),
          // ),
          title: const Text(
            'Select Category',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: TabBar(
            padding: EdgeInsets.only(bottom: 10),
            indicatorSize: TabBarIndicatorSize.label,
            // labelPadding: const EdgeInsets.symmetric(
            //   horizontal: 10,
            // ),
            labelColor: Colors.white,
            unselectedLabelColor: AppColors.blueColor,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.blueColor,
            ),
            tabs: [
              Tab(
                child: Container(
                  height: 25,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.blueColor),
                    //border: Bord,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Center(child: Text('To-Do')),
                ),
              ),
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.blueColor),
                    //border: Bord,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Center(child: Text('Completed')),
                ),
              ),
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.blueColor),
                    //border: Bord,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Center(child: Text('In Progress')),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [RecentProjects(), RecentProjects(), RecentProjects()],
        ),
      ),
    );
  }
}
