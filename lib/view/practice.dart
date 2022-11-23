import 'package:beta_tasker/core/app_colors.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../core/common_widgets/custom_text.dart';

class Practice extends StatefulWidget {
  const Practice({Key? key}) : super(key: key);

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100.h,
        flexibleSpace: SafeArea(
            child: Container(
          margin: EdgeInsets.only(top: 70.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('percentage'), Text('remaining days')],
          ),
        )),
        title: SizedBox(
          height: 80.h,
          child: CustomText(
            text: "Add Task",
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: Column(),
    );
  }
}



// ValueListenableBuilder<bool>(
//             valueListenable: showImage,
//             builder: (_, value, child) {
//               return value
//                   ? CircleAvatar(
//                       backgroundColor: AppColors.avatarColor,
//                       backgroundImage: FileImage(File(image!.path).absolute))
//                   : const CircleAvatar(
//                       backgroundColor: AppColors.avatarColor,
//                     );
//             },
//           )
// smartDialogDemo(){
//   void _attchLocation(context) {
//     btn({required Color color, required Function(BuildContext) onTap}) {
//       return Row(
//         children: [
//           CircleAvatar(
//             radius: 10,
//             backgroundColor: color,
//           )
//         ],
//       );
//     }

//     SmartDialog.showAttach(
//         clickMaskDismiss: false,
//         alignment: Alignment.topCenter,
//         targetContext: context,

//         // usePenetrate: true,
//         // clickMaskDismiss: false,
//         builder: (_) {
//           return Container(
//             decoration: BoxDecoration(
//                 color: AppColors.avatarColor,
//                 borderRadius: BorderRadius.circular(10.r)),
//             height: 140.h,
//             width: 180.w,
//             child: ListView.builder(
//                 itemCount: 4,
//                 itemBuilder: (_, index) {
//                   return Padding(
//                     padding: EdgeInsets.only(bottom: 10.h),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         CircleAvatar(
//                           radius: 10.r,
//                           backgroundColor: AppColors.blackColor,
//                         ),
//                         Text("priority ${index + 1}")
//                       ],
//                     ),
//                   );
//                 }),
//           );
//         });
//   }
//   SmartDialog.show(builder: (context) {
//             return Container(
//               padding: EdgeInsets.only(left: 10.w, right: 10.w),
//               height: 200.h,
//               width: MediaQuery.of(context).size.width * 1,
//               decoration: const BoxDecoration(
//                   color: AppColors.avatarColor,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(8),
//                       topRight: Radius.circular(8))),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TextFormField(
//                     autofocus: true,
//                     // focusNode: titleNode,
//                     decoration: const InputDecoration(
//                         hintText: "e.g. Go to hospital at 5 pm",
//                         border: InputBorder.none),
//                   ),
//                   TextFormField(
//                     decoration: const InputDecoration(
//                         hintText: "Description", border: InputBorder.none),
//                   ),
//                   DateTimePicker(
//                     type: DateTimePickerType.dateTimeSeparate,
//                     firstDate: DateTime(2022),
//                     lastDate: DateTime(2030),
//                     //icon: Icon(Icons.event),
//                     decoration: InputDecoration(
//                       hintText: 'Time and Date',
//                       border: InputBorder.none,
//                       labelText: 'Time and date',
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       TextButton.icon(
//                         onPressed: () {
//                           // setState(() {
//                           //   isVisible = !isVisible;
//                           // });
//                           _attchLocation(context);
//                         },
//                         icon: Image.asset(
//                           "assets/icons/priority.png",
//                           height: 25.h,
//                         ),
//                         label: Text(priorityText),
//                       ),
//                       IconButton(
//                           onPressed: () {},
//                           icon: Image.asset(
//                             "assets/icons/send.png",
//                             height: 20.h,
//                           ))
//                     ],
//                   )
//                 ],
//               ),
//             );
//           });
// }