import 'package:TeraFlex/pages/classes/styles.dart';
import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget {
  final IconData? icon;
  final String? username;
  final String tittle;
  final String subTittle;
  final VoidCallback? onPressed;

  const AppBarCustom({
    super.key,
    this.username,
    this.icon,
    required this.tittle,
    required this.subTittle,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColorHeader,
      toolbarHeight: 100,
      automaticallyImplyLeading: false,
      flexibleSpace: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: onPressed,
                  child: Row(
                    children: [
                      if (icon != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(icon, color: Colors.white),
                        ),
                      Text(subTittle,
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                              color: Colors.white)),
                    ],
                  ),
                ),
                Row(
                  children: [
                    if (username != null)
                      Text('$tittle ${username!}', style: textStyleTitleHeader),
                    if (username == null)
                      Text(tittle, style: textStyleTitleHeader),
                  ],
                )
              ],
            ),
          ),
          Column(
            children: [
              Flexible(
                child: Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsetsDirectional.only(end: 5),
                  padding: EdgeInsetsDirectional.only(top: 20, bottom: 10),
                  child: Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.fitWidth,
                  ),
                ),
              )
            ],
          )
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
      ),
    );
  }
}
