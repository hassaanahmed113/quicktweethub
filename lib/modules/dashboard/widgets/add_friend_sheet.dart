import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/core/global_text.dart';
import 'package:login_signup/core/utils/color_utils.dart';
import 'package:login_signup/core/utils/screen_size.dart';
import 'package:login_signup/core/utils/space.dart';
import 'package:login_signup/modules/dashboard/controller/dash_controller.dart';
import 'package:provider/provider.dart';

Future showSheet(BuildContext context) {
  final dProvider = Provider.of<DashProvider>(context, listen: false);
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 10),
              child: customTextWidget(
                  text: 'Add People:',
                  fontSize: 29,
                  fontWeight: FontWeight.bold,
                  fontColor: ColorConstraint.blackColor),
            ),
          ),
          Spaces.mid,
          StreamBuilder(
            stream: dProvider.db
                .collection('users')
                .doc(dProvider.auth.currentUser!.uid)
                .snapshots(),
            builder: (context, snap) {
              if (!snap.hasData) {
                return const SizedBox(
                  height: 300,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ),
                );
              } else {
                List<String> friendIds =
                    List<String>.from(snap.data!['friend'] ?? []);
                if (friendIds.isEmpty) {
                  return StreamBuilder(
                    stream: dProvider.db.collection('users').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container(
                          height: 120,
                          color: Colors.white,
                        );
                      } else if (snapshot.data!.docs.isEmpty) {
                        return Container(
                          color: Colors.white,
                          height: 120,
                          child: Center(
                            child: customTextWidget(
                              text: 'No users available',
                              fontColor: Colors.black,
                            ),
                          ),
                        );
                      } else {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot data =
                                  snapshot.data!.docs[index];

                              return data['id'] !=
                                      FirebaseAuth.instance.currentUser!.uid
                                  ? SizedBox(
                                      height: ScreenSize.screenHeight(context) *
                                          0.1,
                                      width: ScreenSize.screenWidth(context),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0, vertical: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                customTextWidget(
                                                  text: data['name'],
                                                  fontSize: 20,
                                                  fontColor: ColorConstraint
                                                      .blackColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                customTextWidget(
                                                  text: '@${data['username']}',
                                                  fontSize: 14,
                                                  fontColor: ColorConstraint
                                                      .blackColor,
                                                  fontWeight: FontWeight.bold,
                                                )
                                              ],
                                            ),
                                            const Spacer(),
                                            GestureDetector(
                                              onTap: () async {
                                                DocumentReference userDocRef =
                                                    dProvider.db
                                                        .collection('users')
                                                        .doc(
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid,
                                                        );

                                                DocumentSnapshot userSnapshot =
                                                    await userDocRef.get();
                                                List<dynamic> currentFriends =
                                                    List<String>.from(
                                                  userSnapshot['friend'] ?? [],
                                                );

                                                if (!currentFriends
                                                    .contains(data['id'])) {
                                                  currentFriends
                                                      .add(data['id']);
                                                  await userDocRef.update({
                                                    'friend': currentFriends,
                                                  });
                                                }
                                                // Navigator.of(context).pop();
                                              },
                                              child: Consumer<DashProvider>(
                                                  builder: (context, provider,
                                                      child) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue[900],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                  ),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Icon(
                                                      Icons.add,
                                                      color: ColorConstraint
                                                          .whiteColor,
                                                      size: 23,
                                                    ),
                                                  ),
                                                );
                                              }),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : snapshot.data!.docs.length == 1
                                      ? SizedBox(
                                          height: 120,
                                          child: Center(
                                            child: customTextWidget(
                                              text: 'No people suggested',
                                              fontColor: Colors.black,
                                            ),
                                          ),
                                        )
                                      : Container();
                            },
                          ),
                        );
                      }
                    },
                  );
                } else {
                  return StreamBuilder(
                    stream: dProvider.db
                        .collection('users')
                        .where('id', whereNotIn: friendIds)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container(
                          height: 120,
                          color: Colors.white,
                        );
                      } else if (snapshot.data!.docs.isEmpty) {
                        return SizedBox(
                          height: 120,
                          child: Center(
                            child: customTextWidget(
                              text: 'No people suggested',
                              fontColor: Colors.black,
                            ),
                          ),
                        );
                      } else {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot data =
                                  snapshot.data!.docs[index];

                              return data['id'] !=
                                      FirebaseAuth.instance.currentUser!.uid
                                  ? SizedBox(
                                      height: ScreenSize.screenHeight(context) *
                                          0.1,
                                      width: ScreenSize.screenWidth(context),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0, vertical: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                customTextWidget(
                                                  text: data['name'],
                                                  fontSize: 20,
                                                  fontColor: ColorConstraint
                                                      .blackColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                customTextWidget(
                                                  text: '@${data['username']}',
                                                  fontSize: 14,
                                                  fontColor: ColorConstraint
                                                      .blackColor,
                                                  fontWeight: FontWeight.bold,
                                                )
                                              ],
                                            ),
                                            const Spacer(),
                                            GestureDetector(
                                              onTap: () async {
                                                DocumentReference userDocRef =
                                                    dProvider.db
                                                        .collection('users')
                                                        .doc(
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid,
                                                        );

                                                DocumentSnapshot userSnapshot =
                                                    await userDocRef.get();
                                                List<dynamic> currentFriends =
                                                    List<String>.from(
                                                  userSnapshot['friend'] ?? [],
                                                );

                                                if (!currentFriends
                                                    .contains(data['id'])) {
                                                  currentFriends
                                                      .add(data['id']);
                                                  await userDocRef.update({
                                                    'friend': currentFriends,
                                                  });
                                                }
                                                // Navigator.of(context).pop();
                                              },
                                              child: Consumer<DashProvider>(
                                                  builder: (context, provider,
                                                      child) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue[900],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                  ),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Icon(
                                                      Icons.add,
                                                      color: ColorConstraint
                                                          .whiteColor,
                                                      size: 23,
                                                    ),
                                                  ),
                                                );
                                              }),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : snapshot.data!.docs.length == 1
                                      ? SizedBox(
                                          height: 220,
                                          child: Center(
                                            child: customTextWidget(
                                              text: 'No people suggested',
                                              fontColor: Colors.black,
                                            ),
                                          ),
                                        )
                                      : Container();
                            },
                          ),
                        );
                      }
                    },
                  );
                }
              }
            },
          ),
        ],
      );
    },
  );
}
