import 'package:flutter/material.dart';

/// This is the header component
/// it will be used in the listcomponent
///
/// It can have multiple headers and each header will be displayed in a row

class HeaderComponent extends StatelessWidget {
  const HeaderComponent({
    Key? key,
    required this.headers,
  }) : super(key: key);

  final List<Widget> headers;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: headers,
    );
  }
}
