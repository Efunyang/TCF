import 'package:flutter/material.dart';

class StoreList extends StatelessWidget {
  const StoreList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            color: Colors.indigo,
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.25,
            child: Center(
              child: Text('合作商家 item ${index + 1}'),
            ),
          ),
        );
      },
      itemCount: 10,
    );
  }
}
