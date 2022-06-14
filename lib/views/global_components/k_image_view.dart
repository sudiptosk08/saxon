import 'package:flutter/material.dart';
import 'package:saxonmarket/constants/asset_path.dart';

class KImageView extends StatelessWidget {
  final String imagepaths;
  const KImageView({Key? key, required this.imagepaths}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      
      child: FadeInImage(
          
          image: NetworkImage(imagepaths),
          placeholder: AssetImage(AssetPath.placeholder),
          fit: BoxFit.cover,
          imageErrorBuilder: (context, error, stackTrace) => Image.asset(AssetPath.placeholder)),
    );
  }
}
