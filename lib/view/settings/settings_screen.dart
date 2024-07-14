import 'package:flutter/material.dart';
import 'package:wallpaper/view/settings/components/forward_btn.dart';
import 'package:wallpaper/view/settings/components/setting_item.dart';
import 'package:wallpaper/view/settings/components/setting_switch.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.chevron_left_rounded),
        ),
        // leadingWidth: 100,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Settings',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            'Account',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            child: Row(
              children: [
               Container(
                 height: 50,
                 width: 50,
                 decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.grey.shade200),
                 child: Center(
                   child: Icon(Icons.person,
                      color: Colors.grey,
                      size: 50,
                    ),
                 ),
               ),
                const SizedBox(
                  width: 20,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Personal Info',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                ForwardButton(
                  onTap: () {},
                ),
  ]),
          ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Settings',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
               SettingItem(
                  title: 'Language',
                  bgColor: Colors.orange.shade200,
                  iconColor: Colors.orange,
                  icon: Icons.language,
                  onTap: () {},
                  value: 'English',
                ),
                const SizedBox(
                  height: 20,
                ),
                SettingSwitch(
                  title: 'Dark Mode',
                  bgColor: Colors.purple.shade200,
                  iconColor: Colors.purple,
                  icon: Icons.dark_mode,
                  onTap: () {},
                  value: isDarkMode,
                ),
                const SizedBox(
                  height: 20,
                ),

                SettingItem(
                  title: 'Help',
                  bgColor: Colors.red.shade200,
                  iconColor: Colors.red,
                  icon: Icons.help,
                  onTap: () {},
                  value: '',
                ),

              ],
            ),
    );
    ;
  }
}
