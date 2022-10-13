import 'package:beta_tasker/core/app_colors.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Practice extends StatefulWidget {
  const Practice({Key? key}) : super(key: key);

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  var title = TextEditingController();
  var description = TextEditingController();
  String priorityText = '';
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
      ),
      body: Center(
        child: Container(
          height: 500,
          child: Stack(children: [
            Positioned(
              bottom: 135.h,
              left: 40,
              child: Container(
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                height: 200.h,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: const BoxDecoration(
                    color: AppColors.avatarColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          // constraints: BoxConstraints(maxWidth: 600),
                          hintText: "e.g. Go to hospital at 5 pm",
                          border: InputBorder.none),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          // constraints: BoxConstraints(maxWidth: 600),
                          hintText: "Description",
                          border: InputBorder.none),
                    ),
                    // CalendarDatePicker(
                    //     initialDate: DateTime.now(),
                    //     firstDate: DateTime.now(),
                    //     lastDate: DateTime(2039),
                    //     onDateChanged: (date) {}),
                    DateTimePicker(
                      type: DateTimePickerType.dateTimeSeparate,
                      // initialValue: DateTime.now().toString(),

                      firstDate: DateTime(2022),
                      lastDate: DateTime(2030),
                      icon: Icon(Icons.event),
                      decoration: InputDecoration(
                        hintText: 'Time and Date',
                        border: InputBorder.none,
                        labelText: 'Time and date',
                        // enabledBorder: OutlineInputBorder(
                        //     borderSide: BorderSide(color: AppColors.avatarColor))
                      ),
                    ),
                    // ElevatedButton.icon(
                    //   onPressed: () {
                    //   },
                    //   icon: Icon(Icons.calendar_month, size: 20.r),
                    //   label: const Text('Today'),
                    //   style: ElevatedButton.styleFrom(
                    //       primary: AppColors.roundButtonDarkColor),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: Image.asset(
                            "assets/icons/priority.png",
                            height: 25.h,
                            // color: AppColors.whiteColor,
                            // colorBlendMode: BlendMode.color,
                          ),
                          label: Text(priorityText),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                              "assets/icons/send.png",
                              height: 20.h,
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
            isVisible
                ? Positioned(
                    top: 0,
                    left: 100,
                    right: 100,
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                          color: AppColors.avatarColor,
                          borderRadius: BorderRadius.circular(10.r)),
                      child: ListView.builder(
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(top: 16.h),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  priorityText = (index + 1).toString();
                                  isVisible = !isVisible;
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CircleAvatar(
                                    radius: 8.r,
                                    backgroundColor: index == 0
                                        ? Colors.red
                                        : index == 1
                                            ? Colors.yellow
                                            : index == 2
                                                ? Colors.blue
                                                : Colors.grey,
                                  ),
                                  Text('Priority ${index + 1}')
                                ],
                              ),
                            ),
                          );
                          // ListTile(
                          //   minVerticalPadding: 0,
                          //   contentPadding: EdgeInsets.all(0),
                          //   leading: CircleAvatar(
                          //     radius: 10.r,
                          //     backgroundColor: index == 0
                          //         ? Colors.red
                          //         : index == 1
                          //             ? Colors.yellow
                          //             : index == 2
                          //                 ? Colors.blue
                          //                 : Colors.grey,
                          //   ),
                          //   title: Text('Priority ${index + 1}'),
                          //   onTap: () {},
                          // );
                        },
                      ),
                    ))
                : Container()
          ]),
        ),
      ),
    );
  }

  getPriorityDialog() {
    var dialog = Container(
        padding: EdgeInsets.all(20.h),
        height: 150.h,
        // width: 300.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: AppColors.dotColor),
        child: Expanded(
          child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  radius: 10.r,
                  backgroundColor: index == 0
                      ? Colors.red
                      : index == 1
                          ? Colors.yellow
                          : index == 2
                              ? Colors.blue
                              : Colors.grey,
                ),
                title: Text('Priority $index'),
                onTap: () {},
              );
            },
          ),
        ));
    showDialog(context: context, builder: (_) => dialog);
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
