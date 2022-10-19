import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:foodship_menu_app/authentication/auth_screen.dart';
import 'package:foodship_menu_app/global/global.dart';
import 'package:foodship_menu_app/model/menu.dart';
import 'package:foodship_menu_app/model/seller.dart';
import 'package:foodship_menu_app/model/user.dart';
import 'package:foodship_menu_app/service/push_notification.dart';
import 'package:foodship_menu_app/widgets/done_dialog.dart';
import 'package:foodship_menu_app/widgets/menus_design.dart';

import 'package:foodship_menu_app/widgets/text_widget_header.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/progress_bar.dart';

class MenusScreen extends StatefulWidget {
  final Sellers? model;
  MenusScreen({Key? key, this.model}) : super(key: key);

  @override
  State<MenusScreen> createState() => _MenusScreenState();
}

class _MenusScreenState extends State<MenusScreen> {
  final PushNotificationService _pushNotificationService =
      PushNotificationService();
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('users');
  Future<void> getDataAndSendNoti() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await collectionRef.get();

    // Get data from docs and convert map to List
    final List<dynamic> allData =
        querySnapshot.docs.map((doc) => doc.data()).toList();

    final List<User> users = [];
    for (final e in allData) {
      users.add(User.fromJson(e));
    }

    for (final User user in users) {
      sendNoti(user.userUID!);
    }
  }

  sendNoti(String userID) async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('userToken')
        .doc('token')
        .get();
    String token = snap['tokenID'];
    _pushNotificationService.sendPushMessage(token,
        '${sharedPreferences!.getString('name')} want order!! Get go', 'User');
    DoneDialog(
      message:
          'Notice sent to waiter!! Please wait for the waiter to order the food!!!',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Colors.cyan,
                Colors.amber,
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            )),
          ),
          title: const Text(
            'iFood',
            style: TextStyle(fontFamily: 'Signatra', fontSize: 30),
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
          actions: [
            InkWell(
                onTap: () {
                  getDataAndSendNoti();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Notification Bell',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.redAccent,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .005,
                    ),
                    const Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .02,
                    ),
                  ],
                ))
          ],
        ),
        body: CustomScrollView(slivers: [
          SliverPersistentHeader(
            delegate: TextWidgetHeader(title: ' Menus'),
            pinned: true,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('sellers')
                .doc(widget.model!.sellerUID)
                .collection('menus')
                .orderBy("publishedDate", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: circularProgress(),
                      ),
                    )
                  : SliverToBoxAdapter(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          Menus model = Menus.fromJson(
                              snapshot.data!.docs[index].data()!
                                  as Map<String, dynamic>);
                          // design display sellers
                          return MenusDesignWidget(
                            model: model,
                            context: context,
                          );
                        },
                        itemCount: snapshot.data!.docs.length,
                      ),
                    );
            },
          ),
        ]));
  }
}
