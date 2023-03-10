import 'package:flutter/material.dart';
import 'package:foodship_menu_app/model/items.dart';
import 'package:foodship_menu_app/widgets/simple_appbar.dart';

class ItemDetailsScreen extends StatefulWidget {
  final Items? model;
  ItemDetailsScreen({this.model});

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: 'Thông tin món ăn',
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      widget.model!.thumbnailUrl.toString(),
                      height: MediaQuery.of(context).size.height * .6,
                      width: MediaQuery.of(context).size.width * .6,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.model!.title.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.model!.price!.toString() + " VND",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.green),
                    ),
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // Center(
                  //   child: InkWell(
                  //     onTap: () {
                  //       Navigator.pop(context);
                  //     },
                  //     child: Container(
                  //       decoration: const BoxDecoration(
                  //           gradient: LinearGradient(
                  //         colors: [
                  //           Colors.cyan,
                  //           Colors.amber,
                  //         ],
                  //         begin: FractionalOffset(0.0, 0.0),
                  //         end: FractionalOffset(1.0, 0.0),
                  //         stops: [0.0, 1.0],
                  //         tileMode: TileMode.clamp,
                  //       )),
                  //       width: MediaQuery.of(context).size.width,
                  //       height: 50,
                  //       child: Center(
                  //           child: Text(
                  //         'Go back ',
                  //         style: const TextStyle(color: Colors.white, fontSize: 15),
                  //       )),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .1,
                  ),
                  const Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Mô tả',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(widget.model!.longDescription!.toString(),
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.pink,
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
