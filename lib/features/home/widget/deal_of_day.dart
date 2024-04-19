import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10),
            alignment: Alignment.topLeft,
            child: const Text(
              'Deal Of Day',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Image.network(
            'https://images.unsplash.com/photo-1713364303905-4bf3136feefe?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw3fHx8ZW58MHx8fHx8',
            height: 235,
            fit: BoxFit.fitHeight,
          ),
          Container(
            padding: const EdgeInsets.only(left: 15),
            alignment: Alignment.topLeft,
            child: const Text(
              '\$92.50',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5, left: 15, right: 40),
            alignment: Alignment.topLeft,
            child: const Text(
              'Product Name',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          //? other images for the same product
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  'https://images.unsplash.com/photo-1708435031742-2d07f66c316f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMHx8fGVufDB8fHx8fA%3D%3D',
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100,
                ),
                Image.network(
                  'https://images.unsplash.com/photo-1708435031742-2d07f66c316f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMHx8fGVufDB8fHx8fA%3D%3D',
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100,
                ),
                Image.network(
                  'https://images.unsplash.com/photo-1708435031742-2d07f66c316f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMHx8fGVufDB8fHx8fA%3D%3D',
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100,
                ),
                Image.network(
                  'https://images.unsplash.com/photo-1708435031742-2d07f66c316f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMHx8fGVufDB8fHx8fA%3D%3D',
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100,
                ),
                Image.network(
                  'https://images.unsplash.com/photo-1708435031742-2d07f66c316f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMHx8fGVufDB8fHx8fA%3D%3D',
                  fit: BoxFit.fitWidth,
                  width: 100,
                  height: 100,
                ),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 15).copyWith(left: 15),
            alignment: Alignment.topLeft,
            child: Text(
              'See All Deals',
              style: TextStyle(
                color: Colors.cyan[800],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
