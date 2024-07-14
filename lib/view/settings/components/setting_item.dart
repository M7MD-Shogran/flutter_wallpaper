import 'package:flutter/material.dart';
import 'package:wallpaper/view/settings/components/forward_btn.dart';

class SettingItem extends StatelessWidget {
  final String title;
  final Color bgColor;
  final Color iconColor;
  final IconData icon;
  final Function() onTap;
  final String? value;
  const SettingItem(
      {super.key,
      required this.title,
      required this.bgColor,
      required this.iconColor,
      required this.icon,
      required this.onTap, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(shape: BoxShape.circle,color: bgColor),
            child: Icon(
             icon,
              color: iconColor,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
        value != null?
        Text(
            value!,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ) : const SizedBox(),
          const SizedBox(
            width: 20,
          ),
          ForwardButton(onTap: onTap,),
        ],
      ),
    );
  }
}
