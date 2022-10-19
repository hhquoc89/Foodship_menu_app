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
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.grey[300],
              ),
              SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  widget.model!.thumbnailUrl!,
                  height: MediaQuery.of(context).size.height * .5,
                  width: MediaQuery.of(context).size.width * .45,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                        width: 100, height: 100, child: circularProgress());
                  },
                ),
              ),
              const SizedBox(
                height: 1.0,
              ),
              Text(
                widget.model!.title!,
                style: const TextStyle(
                  color: Colors.cyan,
                  fontSize: 30,
                ),
              ),
              Text(
                widget.model!.shortInfo!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                '${widget.model!.price} VND',
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
