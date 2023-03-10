import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodship_menu_app/model/items.dart';
import 'package:foodship_menu_app/widgets/items_design.dart';
import 'package:foodship_menu_app/widgets/progress_bar.dart';

class InitItem extends StatelessWidget {
  const InitItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('items')
          .orderBy('menuID')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Something went wrong"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return circularProgress();
        }

        return GridView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            Items model = Items.fromJson(
                snapshot.data!.docs[index].data()! as Map<String, dynamic>);

            return ItemsDesignWidget(
              model: model,
              context: context,
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 5.0,
          ),
        );
      },
    );
  }
}
