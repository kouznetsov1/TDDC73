import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  List data;
  int numOfItems;
  String title;
  Carousel(
      {Key? key,
      required this.data,
      required this.title,
      required this.numOfItems})
      : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int positionInRow = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Text(widget.title),
              ),
              // BUTTONS
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Left button
                    ElevatedButton(
                        onPressed: () => setState(
                              () {
                                print(widget.data.length);
                                if (positionInRow != 0) {
                                  positionInRow--;
                                }
                              },
                            ),
                        child: const Icon(Icons.arrow_left)),
                    // Right button
                    ElevatedButton(
                        onPressed: () => setState(
                              () {
                                if (positionInRow <
                                    widget.data.length - widget.numOfItems) {
                                  positionInRow++;
                                }
                              },
                            ),
                        child: Icon(Icons.arrow_right))
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            // Builds the view
            child: ListView.builder(
              itemCount: widget.data.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return positionInRow + index < widget.data.length ? Container(
                      padding: EdgeInsets.all(10),
                      child: Image.asset(widget.data[positionInRow + index], fit: BoxFit.fill,),
                      height: 300,
                      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                      width: (MediaQuery.of(context).size.width /
                          widget.numOfItems)-4,
                    ) : const Text("Error!");
              },
            ),
          ),
        ],
      ),
    );
  }
}
