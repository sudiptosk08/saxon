import 'package:flutter/material.dart';
import 'package:saxonmarket/constants/asset_path.dart';
import 'package:saxonmarket/views/styles/b_style.dart';

class ShimmerProductCard extends StatefulWidget {
  final bool? isGridView;
  const ShimmerProductCard({Key? key, this.isGridView = false})
      : super(key: key);

  @override
  State<ShimmerProductCard> createState() => _ShimmerProductCardState();
}

class _ShimmerProductCardState extends State<ShimmerProductCard> {
  @override
  Widget build(BuildContext context) {
    return widget.isGridView!
        ? gridViewShimmer()
        : SizedBox(
            width: KSize.getWidth(context, 150),
            height: KSize.getHeight(context, 287),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: KSize.getHeight(context, 190),
                  width:  KSize.getWidth(context, 150),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: FadeInImage(
                        image: AssetImage(AssetPath.placeholder),
                        placeholder: AssetImage(AssetPath.placeholder),
                        fit: BoxFit.cover,
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  child: Container(color: KColor.appBackground),
                  height: KSize.getHeight(context, 40),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: Container(
                    color: KColor.appBackground,
                  ),
                  height: KSize.getHeight(context, 20),
                ),
              ],
            ),
          );
  }

  Widget gridViewShimmer() {
    return Container(
            width: MediaQuery.of(context).size.width * 0.44,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(10),
           ),
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.44,
                        height: KSize.getHeight(context, 170),
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(7.0),
                            topRight:  Radius.circular(7.0)),
                      child: FadeInImage(
                        image: AssetImage(AssetPath.placeholder),
                        placeholder: AssetImage(AssetPath.placeholder),
                        fit: BoxFit.cover,
                      )),
                ),
                SizedBox(height: KSize.getHeight(context, 13)),
                SizedBox(
                  child: Container(color: KColor.appBackground),
                  height: 25.0,
                ),
                SizedBox(height: KSize.getHeight(context, 13)),
                SizedBox(
                  child: Container(
                    color: KColor.appBackground,
                  ),
                  height: 18.0,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
  }
}
