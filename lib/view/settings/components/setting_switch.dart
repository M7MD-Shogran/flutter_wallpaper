import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/theme/theme_provider.dart';

class SettingSwitch extends StatelessWidget {
  final String title;
  final Color bgColor;
  final Color iconColor;
  final IconData icon;
  final Function() onTap;
  final bool value;
  const SettingSwitch({super.key, required this.title, required this.bgColor, required this.iconColor, required this.icon, required this.onTap, required this.value});

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

          Text(
            value ? 'On' : 'Off',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(
            width: 20,
          ),
          // CupertinoSwitch(value: value, onChanged: Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          // )
        ],
      ),
    );
  }
}
