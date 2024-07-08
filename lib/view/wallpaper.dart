import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:wallpaper/components/colors.dart';
import 'package:wallpaper/view/full_screen.dart';
import 'package:wallpaper/models/theme/theme_provider.dart';
import 'package:wallpaper/view/wrapper.dart';

class Wallpaper extends StatefulWidget {
  const Wallpaper({super.key});

  @override
  State<Wallpaper> createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {
  List images = [];
  int page = 1;

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    loadMore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Wallpapers',
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * .03,
              color: PrimaryColor),
        ),
        leading: IconButton(
          icon: Icon(Icons.favorite),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Wrapper()));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.sunny),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          )
        ],
      ),
      body: images.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.heart_broken,
                    size: 100,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  Text(
                    'No data Found',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.background,
                    ),
                  ),
                  Text(
                    'Check your Connection',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.background,
                    ),
                  ),
                ],
              ),
            )
          : Column(children: [
              Expanded(
                child: Container(
                  child: GridView.builder(
                      // reverse: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: images.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 3,
                        childAspectRatio: 2 / 3,
                        mainAxisSpacing: 2,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              isLoading = true;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullScreen(
                                        imageUrl: images[index]['src']
                                            ['original'],
                                      ),
                              ),
                            );
                          },
                          child: Hero(
                            tag: images[index]['src']['original'],
                            child: Container(
                              color: Colors.white,
                              child: Image.network(
                                images[index]['src']['large'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
              InkWell(
                onTap: () {
                  loadMore();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * .06,
                  width: double.infinity,
                  color: Theme.of(context).colorScheme.primary,
                  child: const Center(
                    child: Text(
                      'Load More',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              )
            ]),
    );
  }

  loadMore() async {
    setState(() {
      page = page + 1;
    });
    String url = 'https://api.pexels.com/v1/curated?per_page=80&page=$page';
    await http.get(Uri.parse(url), headers: {
      'Authorization':
          'jO3R3A9ItDrwpBdB7MFT0FagBfwAL190VJVu2FpdZycpaMpfX53S5fNw'
    }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
    });
  }

  // fetchApi() async {
  //   await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=30'),
  //       headers: {
  //         'Authorization':
  //             'jO3R3A9ItDrwpBdB7MFT0FagBfwAL190VJVu2FpdZycpaMpfX53S5fNw'
  //       }).then((value) {
  //     Map result = jsonDecode(value.body);
  //     setState(() {
  //       images = result['photos'];
  //     });
  //   });
  // }
}
