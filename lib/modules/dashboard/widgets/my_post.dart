import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/core/global_text.dart';
import 'package:login_signup/core/utils/color_utils.dart';
import 'package:login_signup/core/utils/screen_size.dart';
import 'package:login_signup/core/utils/space.dart';
import 'package:login_signup/modules/dashboard/controller/dash_controller.dart';
import 'package:provider/provider.dart';

class MyPosts extends StatelessWidget {
  const MyPosts({super.key});

  @override
  Widget build(BuildContext context) {
    final dProvider = Provider.of<DashProvider>(context);
    return StreamBuilder(
      stream: dProvider.db
          .collection('allposts')
          .where('id', isEqualTo: dProvider.auth.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(
            height: 120,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
          );
        } else if (snapshot.data!.docs.isEmpty) {
          return SizedBox(
              height: 120,
              child: Center(
                child: customTextWidget(
                    text: 'No post Yet', fontColor: Colors.black),
              ));
        } else {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot data = snapshot.data!.docs[index];
              return SizedBox(
                height: ScreenSize.screenHeight(context) * 0.39,
                width: ScreenSize.screenWidth(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 30,
                        width: ScreenSize.screenWidth(context),
                        child: customTextWidget(
                            text: data['time'],
                            fontSize: 12,
                            fontColor: ColorConstraint.blackColor),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 26.0,
                            backgroundColor: Colors.black12,
                            child: Icon(
                              Icons.person,
                              color: Colors.black45,
                              size: 29,
                            ),
                          ),
                          Spaces.midw,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              customTextWidget(
                                  text: data['name'],
                                  fontSize: 20,
                                  fontColor: ColorConstraint.blackColor,
                                  fontWeight: FontWeight.bold),
                              customTextWidget(
                                  text: '@${data['username']}',
                                  fontSize: 14,
                                  fontColor: ColorConstraint.blackColor,
                                  fontWeight: FontWeight.bold)
                            ],
                          ),
                          const Spacer(),
                          SizedBox(
                              height: 40,
                              width: 40,
                              child: GestureDetector(
                                onTap: () {
                                  dProvider.db
                                      .collection('allposts')
                                      .doc(data.id)
                                      .delete();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: customTextWidget(
                                        text: 'Post Deleted Successfully'),
                                    backgroundColor: Colors.red,
                                  ));
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.blue[900],
                                ),
                              ))
                        ],
                      ),
                      Spaces.mid,
                      Container(
                        height: ScreenSize.screenHeight(context) * 0.23,
                        width: ScreenSize.screenWidth(context),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: customTextWidget(
                              text: data['post'],
                              fontColor: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
