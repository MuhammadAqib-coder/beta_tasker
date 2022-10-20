import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../images/icons/icon_image.dart';
import '../app_colors.dart';
import 'custom_text.dart';

class AddTask {
  var titleControler = TextEditingController();
  var descriptionControler = TextEditingController();
  var dateControler = TextEditingController();
  var timeControler = TextEditingController();
  //String priorityText = '';
  var titleNode = FocusNode();
  var isVisible = ValueNotifier<bool>(false);
  var priorityText = ValueNotifier<String>('');
  var docId = '';
  // var date = '';
  // var time = '';
  DocumentSnapshot? snapshot;

  AddTask({this.snapshot});

  showAddTask(context) {
    titleControler.text = snapshot != null ? snapshot!['title'] : '';
    descriptionControler.text =
        snapshot != null ? snapshot!['description'] : '';
    dateControler.text = snapshot != null ? snapshot!['date'] : '';
    timeControler.text = snapshot != null ? snapshot!['time'] : '';
    // date = snapshot != null ? snapshot!['date'] : '';
    // time = snapshot != null ? snapshot!['time'] : '';
    priorityText.value = snapshot != null ? snapshot!['priority'] : '';
    docId = snapshot != null ? snapshot!.id : '';
    showGeneralDialog(
        barrierDismissible: false,
        context: context,
        transitionDuration: const Duration(milliseconds: 700),
        pageBuilder: (context, anim1, anim2) => Align(
              alignment: Alignment.bottomCenter,
              child: WillPopScope(
                onWillPop: () async => true,
                child: AlertDialog(
                  elevation: 0,
                  insetPadding: EdgeInsets.zero,
                  contentPadding: EdgeInsets.zero,
                  scrollable: true,
                  content: Column(children: [
                    ValueListenableBuilder<bool>(
                        valueListenable: isVisible,
                        builder: (context, value, child) {
                          if (value) {
                            return priorityContainer(context);
                          } else {
                            return Container();
                          }
                        }),
                    dataContainer(
                        context, dateControler.text, timeControler.text)
                  ]),
                ),
              ),
            ),
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
                .animate(anim1),
            child: child,
          );
        });
  }

  Container dataContainer(BuildContext context, String date, String time) {
    return Container(
      padding: EdgeInsets.only(left: 10.w, right: 10.w),
      height: 200.h,
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: titleControler,
            autofocus: true,
            // focusNode: titleNode,
            decoration: const InputDecoration(
                hintText: "e.g. Go to hospital at 5 pm",
                border: InputBorder.none),
          ),
          TextFormField(
            controller: descriptionControler,
            decoration: const InputDecoration(
                hintText: "Description", border: InputBorder.none),
          ),
          Row(
            children: [
              Expanded(
                child: DateTimePicker(
                  controller: dateControler,
                  textAlign: TextAlign.center,
                  type: DateTimePickerType.date,
                  firstDate: DateTime(2022),
                  lastDate: DateTime(2030),
                  decoration: const InputDecoration(
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    hintText: 'Date',
                    labelText: 'Date',
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    var format = DateFormat().add_yMMMd();
                    date = format.format(DateTime.parse(value));
                  },
                ),
              ),
              Expanded(
                child: DateTimePicker(
                  controller: timeControler,
                  textAlign: TextAlign.center,
                  type: DateTimePickerType.time,

                  //icon: Icon(Icons.event),
                  onChanged: (value) {
                    time = value;
                  },

                  decoration: const InputDecoration(
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    hintText: 'Time',
                    labelText: 'Time',
                    border: InputBorder.none,
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () {
                  isVisible.value = !isVisible.value;
                },
                icon: Image.asset(
                  IconImage.priorityIcon,
                  height: 25.h,
                ),
                label: Text(
                  priorityText.value,
                ),
              ),
              IconButton(
                  onPressed: () async {
                    if (docId.isNotEmpty) {
                      await FirebaseFirestore.instance
                          .collection('tasks')
                          .doc(docId)
                          .update({
                        'title': titleControler.text.trim(),
                        'description': descriptionControler.text.trim(),
                        'date': date,
                        'time': time,
                        'priority': priorityText.value,
                        'is_completed': false,
                      });
                    } else {
                      await FirebaseFirestore.instance
                          .collection('tasks')
                          .doc()
                          .set({
                        'title': titleControler.text.trim(),
                        'description': descriptionControler.text.trim(),
                        'date': date,
                        'time': time,
                        'priority': priorityText.value,
                        'is_completed': false,
                      });
                    }
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                  icon: Image.asset(
                    IconImage.senIcon,
                    height: 20.h,
                  ))
            ],
          )
        ],
      ),
    );
  }

  AnimatedContainer priorityContainer(BuildContext context) {
    return AnimatedContainer(
      height: 150.h,
      width: MediaQuery.of(context).size.width * 0.4,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInBack,
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10.r)),
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 14.h),
            child: ValueListenableBuilder<String>(
              valueListenable: priorityText,
              builder: (context, value, child) {
                return InkWell(
                  onTap: () {
                    priorityText.value = (index + 1).toString();
                    isVisible.value = !isVisible.value;
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      CustomText(
                          text: "Priority ${index + 1}",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
