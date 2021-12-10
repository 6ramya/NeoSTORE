import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/bloc/cart_bloc.dart';
import 'package:neostore/bloc/cart_event.dart';
import 'package:neostore/bloc/cart_state.dart';

import 'package:neostore/model/list_cart_items.dart';
import 'package:neostore/repository/cart_repository.dart';

class QuantityDropdownButton extends StatefulWidget {
  Data1? item;
  String? token;
  QuantityDropdownButton({Key? key, this.item, this.token}) : super(key: key);

  @override
  _QuantityDropdownButtonState createState() => _QuantityDropdownButtonState();
}

class _QuantityDropdownButtonState extends State<QuantityDropdownButton> {
  int? value;
  @override
  void initState() {
    value = widget.item!.quantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc(authRepo: context.read<CartRepository>()),
      child: DropdownButtonHideUnderline(
          child: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
        return DropdownButton(
            value: value,
            isExpanded: false,
            items: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9]
                .map<DropdownMenuItem<int>>((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text('$value'),
              );
            }).toList(),
            onChanged: (int? value1) async {
              setState(() {
                value = value1;
                widget.item!.quantity = value1;
              });
              context.read<CartBloc>().add(EditCart(
                  product_id: widget.item!.product_id,
                  quantity: value1,
                  token: widget.token));
              context.read<CartBloc>().add(LoadItems(token: widget.token));
            });
      })),
    );
  }
}
