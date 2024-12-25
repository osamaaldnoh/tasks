import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardTasksWidget extends StatelessWidget {
  const CardTasksWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            //clipBehavior: Clip.antiAliasWithSaveLayer,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2 / 1.9,
                width: double.infinity,
              ),
              Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(5),
                child: Row(
                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Time',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1 / 1.8,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'data',
                        ),
                        Text('data'),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.delete,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -8,
                right: 0,
                child: Icon(
                  Icons.clear,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
