import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class PostProfile2 extends StatelessWidget {
  const PostProfile2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child:MasonryGridView.builder(
            
            itemCount: 7,
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
    itemBuilder: (context, index) => Padding(padding: EdgeInsets.all(8),
      child:  ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          child: Image.asset('assets/images/jpg/image${index +1}.jpg')),
    ),)
          ),

      ],
    );
  }
}
