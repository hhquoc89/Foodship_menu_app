// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:foodship_menu_app/mainScreens/menus_screen.dart';
// import 'package:foodship_menu_app/widgets/progress_bar.dart';

// import '../model/seller.dart';

// class SellersDesignWidget extends StatefulWidget {
//   Sellers? model;
//   BuildContext? context;
//   SellersDesignWidget({this.model, this.context});
//   @override
//   State<SellersDesignWidget> createState() => _SellersDesignWidgetState();
// }

// class _SellersDesignWidgetState extends State<SellersDesignWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20), color: Colors.blue),
//       child: InkWell(
//           onTap: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => MenusScreen(model: widget.model),
//                 ));
//           },
//           splashColor: Colors.amber,
//           child: Center(
//               child: Text(
//             'Choose Food',
//             style: TextStyle(fontSize: 30),
//           ))),
//     );
//   }
// }
