import 'dart:ui';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';
import 'package:login_signup/core/global_elevatedbtn.dart';
import 'package:login_signup/core/global_text.dart';
import 'package:login_signup/core/model/user_model.dart';
import 'package:login_signup/core/utils/color_utils.dart';
import 'package:login_signup/core/utils/screen_size.dart';
import 'package:login_signup/core/utils/space.dart';
import 'package:login_signup/modules/dashboard/controller/dash_controller.dart';
import 'package:login_signup/modules/dashboard/model/post_model.dart';
import 'package:login_signup/modules/dashboard/widgets/add_friend_sheet.dart';
import 'package:login_signup/modules/dashboard/widgets/all_post.dart';
import 'package:login_signup/modules/dashboard/widgets/my_post.dart';
import 'package:login_signup/modules/login/controller/login_provider.dart';
import 'package:login_signup/modules/login/login_screen.dart';
import 'package:provider/provider.dart';

class DashboardPage extends HookWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dProvider = Provider.of<DashProvider>(context, listen: false);
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        dProvider.getUserData();
      });
      return null;
    });

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: GestureDetector(
                    onTap: () async {
                      await dProvider.auth.signOut();
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ));
                    },
                    child: const Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 27,
                    ),
                  ),
                )
              ],
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: ColorConstraint.primaryColor,
              title: customTextWidget(
                  text: 'QuikTweetHub',
                  fontWeight: FontWeight.bold,
                  fontSize: 23),
            )),
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: ScreenSize.screenHeight(context) * 0.4,
                  floating: false,
                  pinned: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        Container(
                          height: ScreenSize.screenHeight(context) * 0.4,
                          width: ScreenSize.screenWidth(context),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/background.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: SizedBox(
                            height: ScreenSize.screenHeight(context) * 0.4,
                            width: ScreenSize.screenWidth(context),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 20.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const CircleAvatar(
                                    radius: 26.0,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.grey,
                                      size: 29,
                                    ),
                                  ),
                                  Spaces.midw,
                                  StreamBuilder(
                                    stream: dProvider.db
                                        .collection('users')
                                        .doc(dProvider.auth.currentUser!.uid)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData ||
                                          snapshot.data == null) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            customTextWidget(
                                              text: 'Guest',
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            customTextWidget(
                                              text: 'Guest123',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ],
                                        );
                                      } else {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            customTextWidget(
                                              text: snapshot.data!['name'],
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            customTextWidget(
                                              text:
                                                  '@${snapshot.data!['username']}',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ],
                                        );
                                      }
                                    },
                                  ),
                                  const Spacer(),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          showSheet(context);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.blue[900],
                                              borderRadius:
                                                  BorderRadius.circular(12.0)),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.add,
                                              color: ColorConstraint.whiteColor,
                                              size: 23,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Spaces.smallw,
                                      SizedBox(
                                        height: 40,
                                        width: 110,
                                        child: customElevatedBtn(
                                          context: context,
                                          text: 'Post',
                                          onpressed: () async {
                                            if (dProvider
                                                .post.text.isNotEmpty) {
                                              String timeDate =
                                                  DateFormat.yMEd()
                                                      .add_jms()
                                                      .format(DateTime.now());
                                              PostModel postModel = PostModel(
                                                name: dProvider.data.name!,
                                                username:
                                                    dProvider.data.username!,
                                                time: timeDate,
                                                post: dProvider.post.text,
                                                id: dProvider.data.id!,
                                              );
                                              await dProvider.db
                                                  .collection('allposts')
                                                  .add(postModel.toJson());
                                              dProvider.post.clear();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: customTextWidget(
                                                    text:
                                                        'Post Created Successfully'),
                                                backgroundColor: Colors.green,
                                              ));
                                            } else {
                                              showText(
                                                context,
                                                'Write post please',
                                              );
                                            }
                                          },
                                          color: Colors.blue[900],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Spaces.large,
                              Container(
                                height: ScreenSize.screenHeight(context) * 0.23,
                                width: ScreenSize.screenWidth(context),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: TextField(
                                  maxLines: 6,
                                  controller: dProvider.post,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15.0,
                                      vertical: 10.0,
                                    ),
                                    hintText: 'Write your post',
                                    hintStyle: TextStyle(
                                      color: Colors.black26,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: Column(
              children: [
                ButtonsTabBar(
                  unselectedDecoration: BoxDecoration(
                    color: const Color.fromARGB(255, 212, 244, 174),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  height: 55,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 50),
                  backgroundColor: ColorConstraint.primaryColor,
                  unselectedLabelStyle: const TextStyle(
                      color: ColorConstraint.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                  labelStyle: const TextStyle(
                      color: ColorConstraint.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  tabs: const [
                    Tab(
                      text: "My post",
                    ),
                    Tab(
                      text: "All post",
                    ),
                  ],
                ),
                const Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      MyPosts(),
                      AllPosts(),
                    ],
                  ),
                ),
                Spaces.mid,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
