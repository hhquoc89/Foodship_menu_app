import 'package:flutter/material.dart';
import 'package:foodship_menu_app/mainScreens/item_detail_screen.dart';
import 'package:foodship_menu_app/model/items.dart';
import 'package:foodship_menu_app/widgets/progress_bar.dart';

class ItemsDesignWidget extends StatefulWidget {
  Items? model;
  BuildContext? context;

  ItemsDesignWidget({this.model, this.context});
  @override
  State<ItemsDesignWidget> createState() => _ItemsDesignWidgetState();
}

class _ItemsDesignWidgetState extends State<ItemsDesignWidget> {
  @override
  Widget build(BuildContext context) {
    String? message;
    String? status = widget.model!.status;

    status == 'available' ? message = "Còn món" : message = "Hết món";

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemDetailsScreen(model: widget.model),
            ));
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
              // color: Colors.blue,
              borderRadius: const BorderRadius.all(
                Radius.circular(20.0),
              ),
              border: Border.all(
                  color: Color.fromARGB(255, 253, 123, 177), width: 1)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
                child: Image.network(
                  widget.model!.thumbnailUrl!,
                  height: MediaQuery.of(context).size.height * .3,
                  width: MediaQuery.of(context).size.width * .35,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(child: circularProgress());
                  },
                ),
              ),
              const SizedBox(
                height: 1.0,
              ),
              Text(
                widget.model!.title!,
                style: const TextStyle(
                    color: Colors.pink,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                widget.model!.shortInfo!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Divider(
                height: 10,
                thickness: 2,
                endIndent: 10,
                indent: 10,
              ),
              Text(
                '${widget.model!.price} VND',
                style: TextStyle(
                    color: status == 'available' ? Colors.amber : Colors.red,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                status == "available" ? message : message,
                style: TextStyle(
                  fontSize: 24,
                  color: status == 'available' ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
