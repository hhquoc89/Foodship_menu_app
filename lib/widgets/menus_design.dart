// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:foodship_menu_app/mainScreens/items_screen.dart';
// import 'package:foodship_menu_app/model/menu.dart';
// import 'package:foodship_menu_app/widgets/progress_bar.dart';

// import '../model/seller.dart';

// class MenusDesignWidget extends StatefulWidget {
//   Menus? model;
//   BuildContext? context;

//   MenusDesignWidget({this.model, this.context});
//   @override
//   State<MenusDesignWidget> createState() => _MenusDesignWidgetState();
// }

// class _MenusDesignWidgetState extends State<MenusDesignWidget> {
//   @override
//   Widget build(BuildContext context) {
//     Menus menus = widget.model!;
//     return Container(
//       decoration: const BoxDecoration(
//           gradient: LinearGradient(
//         colors: [
//           Colors.amber,
//           Colors.cyan,
//         ],
//         begin: FractionalOffset(0.0, 0.0),
//         end: FractionalOffset(1.0, 0.0),
//         stops: [0.0, 1.0],
//         tileMode: TileMode.clamp,
//       )),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//                 borderRadius: const BorderRadius.all(Radius.circular(
//                         5.0) //                 <--- border radius here
//                     ),
//                 border: Border.all(color: Colors.grey, width: 4)),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   decoration: const BoxDecoration(),
//                   width: MediaQuery.of(context).size.width * .2,
//                   height: MediaQuery.of(context).size.height,
//                   child: Center(
//                     child: InkWell(
//                       onTap: () {
//                         // setState(() {
//                         //   menus = widget.model!;
//                         // });
//                       },
//                       splashColor: Colors.amber,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             SizedBox(
//                                 height:
//                                     MediaQuery.of(context).size.height * .4),
//                             Stack(alignment: Alignment.center, children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(20.0),
//                                 child: Image.network(
//                                   widget.model!.thumbnailUrl!,
//                                   height:
//                                       MediaQuery.of(context).size.height * .2,
//                                   width: MediaQuery.of(context).size.width * .2,
//                                   fit: BoxFit.cover,
//                                   loadingBuilder: (BuildContext context,
//                                       Widget child,
//                                       ImageChunkEvent? loadingProgress) {
//                                     if (loadingProgress == null) return child;
//                                     return Container(
//                                         width: 100,
//                                         height: 100,
//                                         child: circularProgress());
//                                   },
//                                 ),
//                               ),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     widget.model!.menuTitle!,
//                                     style: const TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 30,
//                                     ),
//                                   ),
//                                   Text(
//                                     widget.model!.menuInfo!,
//                                     style: const TextStyle(
//                                       color: Colors.grey,
//                                       fontSize: 26,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ]),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width * .001,
//                   height: MediaQuery.of(context).size.height,
//                   color: Color.fromARGB(255, 255, 234, 241),
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width * .78,
//                   height: MediaQuery.of(context).size.height,
//                   child: ItemsScreen(model: menus),
//                 )
//               ],
//             )),
//       ),
//     );
//   }
// }
