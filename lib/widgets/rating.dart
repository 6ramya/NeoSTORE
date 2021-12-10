import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  int? rating;
  Rating({Key? key, this.rating}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    switch (rating) {
      case 1:
        return Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.star, color: Colors.yellow[700], size: 14),
          Icon(Icons.star, size: 14),
          Icon(Icons.star, size: 14),
          Icon(Icons.star, size: 14),
          Icon(Icons.star, size: 14),
        ]);

        break;
      case 2:
        return Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.star, color: Colors.yellow[700], size: 14),
          Icon(Icons.star, color: Colors.yellow[700], size: 14),
          Icon(Icons.star, size: 14),
          Icon(Icons.star, size: 14),
          Icon(Icons.star, size: 14),
        ]);
        break;
      case 3:
        return Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.star, color: Colors.yellow[700], size: 14),
          Icon(Icons.star, color: Colors.yellow[700], size: 14),
          Icon(Icons.star, color: Colors.yellow[700], size: 14),
          Icon(Icons.star, size: 14),
          Icon(Icons.star, size: 14),
        ]);
        break;
      case 4:
        return Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.star, color: Colors.yellow[700], size: 14),
          Icon(Icons.star, color: Colors.yellow[700], size: 14),
          Icon(Icons.star, color: Colors.yellow[700], size: 14),
          Icon(Icons.star, color: Colors.yellow[700], size: 14),
          Icon(Icons.star, size: 14),
        ]);
        break;
      case 5:
        return Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.star, color: Colors.yellow[700], size: 14),
          Icon(Icons.star, color: Colors.yellow[700], size: 14),
          Icon(Icons.star, color: Colors.yellow[700], size: 14),
          Icon(Icons.star, color: Colors.yellow[700], size: 14),
          Icon(Icons.star, color: Colors.yellow[700], size: 14),
        ]);
        break;
      default:
        return Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.star, color: Colors.yellow[700], size: 14),
          Icon(Icons.star, color: Colors.yellow[700], size: 14),
          Icon(Icons.star, color: Colors.yellow[700], size: 14),
          Icon(Icons.star, color: Colors.yellow[700], size: 14),
          Icon(Icons.star, color: Colors.yellow[700], size: 14),
        ]);
        break;
    }
  }
}
