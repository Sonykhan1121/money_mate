import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget{
  final String title;
  final List<Widget>? actions;
  final bool? centerTitle;
  const CustomAppBar({super.key,required this.title,this.actions,this.centerTitle});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      centerTitle: widget.centerTitle,
      actions: widget.actions,
    );
  }
}
