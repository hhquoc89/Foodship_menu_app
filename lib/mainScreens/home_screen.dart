import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:foodship_menu_app/authentication/auth_screen.dart';
import 'package:foodship_menu_app/global/global.dart';
import 'package:foodship_menu_app/model/items.dart';
import 'package:foodship_menu_app/model/seller.dart';
import 'package:foodship_menu_app/model/user.dart';
import 'package:foodship_menu_app/service/push_notification.dart';
import 'package:foodship_menu_app/widgets/done_dialog.dart';
import 'package:foodship_menu_app/widgets/drawer.dart';
import 'package:foodship_menu_app/widgets/init_list_item.dart';
import 'package:foodship_menu_app/widgets/items_design.dart';
import 'package:foodship_menu_app/widgets/progress_bar.dart';
import 'package:foodship_menu_app/widgets/sellers_design.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final items = [
  //   "slider/0.jpg",
  //   "slider/1.jpg",
  //   "slider/2.jpg",
  //   "slider/3.jpg",
  //   "slider/4.jpg",
  //   "slider/5.jpg",
  //   "slider/6.jpg",
  //   "slider/7.jpg",
  //   "slider/8.jpg",
  //   "slider/9.jpg",
  //   "slider/10.jpg",
  //   "slider/11.jpg",
  //   "slider/12.jpg",
  //   "slider/13.jpg",
  //   "slider/14.jpg",
  //   "slider/15.jpg",
  //   "slider/16.jpg",
  //   "slider/17.jpg",
  //   "slider/18.jpg",
  //   "slider/19.jpg",
  //   "slider/20.jpg",
  //   "slider/21.jpg",
  //   "slider/22.jpg",
  //   "slider/23.jpg",
  //   "slider/24.jpg",
  //   "slider/25.jpg",
  //   "slider/26.jpg",
  //   "slider/27.jpg",
  // ];
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
    if (snap.exists == true) {
      String token = snap['tokenID'];
      _pushNotificationService.sendPushMessage(
          token,
          '${sharedPreferences!.getString('name')} muốn gọi đồ ăn !! Hãy mau tới',
          'Bồi bàn');
    }
  }

  String searchText = "";
  Future<QuerySnapshot>? itemList;
  initSearchingRestaurant(String textEntered) {
    itemList = FirebaseFirestore.instance
        .collection("items")
        .where('title', isGreaterThanOrEqualTo: textEntered)
        .get();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const MyDrawer(),
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
          title: Center(
            child: TextField(
              onChanged: (textEntered) {
                setState(() {
                  searchText = textEntered;
                });
                //init search
                initSearchingRestaurant(textEntered.toUpperCase());
              },
              decoration: InputDecoration(
                hintText: "Tìm kiếm món ăn...",
                hintStyle: const TextStyle(color: Colors.white54, fontSize: 26),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  color: Colors.white,
                  onPressed: () {
                    initSearchingRestaurant(searchText);
                  },
                ),
              ),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
          actions: [
            InkWell(
                onTap: () async {
                  await getDataAndSendNoti();
                  showDialog(
                      context: context,
                      builder: (context) {
                        return DoneDialog(
                            message: 'Đã gọi bồi bàn !! Đợi tí nha!!');
                      });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Gọi bồi bàn',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .005,
                    ),
                    const Icon(
                      Icons.notifications,
                      color: Colors.yellowAccent,
                      size: 50,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .02,
                    ),
                  ],
                )),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(8),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder<QuerySnapshot>(
            future: itemList,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Items model = Items.fromJson(snapshot.data!.docs[index]
                            .data()! as Map<String, dynamic>);

                        return ItemsDesignWidget(
                          model: model,
                          context: context,
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                      ),
                    )
                  : const InitItem();
            },
          ),
        ));
  }
}
