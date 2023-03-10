import 'package:flutter/material.dart';
import 'package:foodship_menu_app/authentication/auth_screen.dart';
import 'package:foodship_menu_app/global/global.dart';
import 'package:foodship_menu_app/model/items.dart';
import 'package:foodship_menu_app/model/menu.dart';
import 'package:foodship_menu_app/widgets/progress_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .4,
      child: Drawer(
        child: ListView(
          children: [
            // header drawer
            Container(
              padding: const EdgeInsets.only(top: 25, bottom: 10),
              child: Column(children: [
                Material(
                  borderRadius: const BorderRadius.all(Radius.circular(90)),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: 160,
                      height: 160,
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              sharedPreferences!.getString('photoUrl')!)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(sharedPreferences!.getString('name')!,
                    style: const TextStyle(
                        color: Colors.black, fontSize: 25, fontFamily: 'Acme')),
              ]),
            ),
            // body drawer
            Container(
              padding: const EdgeInsets.only(top: 1.0),
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('sellers')
                      .doc('6E1ZnU332vgoqBTTy2KDoBZzWKT2')
                      .collection('menus')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }
                    return !snapshot.hasData
                        ? Center(
                            child: circularProgress(),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              Menus model = Menus.fromJson(
                                  snapshot.data!.docs[index].data()!
                                      as Map<String, dynamic>);
                              return ExpansionTile(
                                leading: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .2,
                                    child: Image.network(
                                      model.thumbnailUrl!,
                                      fit: BoxFit.cover,
                                    )),
                                title: Text(
                                  model.menuTitle!,
                                  style: TextStyle(
                                      fontSize: 24, fontFamily: 'Acme'),
                                ),
                                children: [
                                  StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('sellers')
                                          .doc('6E1ZnU332vgoqBTTy2KDoBZzWKT2')
                                          .collection('menus')
                                          .doc(model.menuID!)
                                          .collection('items')
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasError) {
                                          return Text('Something went wrong');
                                        }

                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                            child: circularProgress(),
                                          );
                                        }
                                        return !snapshot.hasData
                                            ? Center(
                                                child: circularProgress(),
                                              )
                                            : ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  Items model = Items.fromJson(
                                                      snapshot.data!.docs[index]
                                                              .data()!
                                                          as Map<String,
                                                              dynamic>);
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          child: Image.network(
                                                            model.thumbnailUrl!,
                                                            fit: BoxFit.cover,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .15,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                .1,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            model.title!,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 24,
                                                                fontFamily:
                                                                    'Acme'),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                itemCount: snapshot.data!.size,
                                              );
                                      }),
                                ],
                              );
                            },
                            itemCount: snapshot.data!.size,
                          );
                  }),
            ),
            ElevatedButton.icon(
                onPressed: () {
                  firebaseAuth.signOut().then((value) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: ((c) => const AuthScreen())));
                  });
                },
                icon: Icon(Icons.logout),
                label: Text('Đăng xuất'))
          ],
        ),
      ),
    );
  }
}
