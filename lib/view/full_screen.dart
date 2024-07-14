import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper/models/favorite/favorite_provider.dart';
import 'package:wallpaper/view/favorite_screen.dart';
import 'package:wallpaper/view/registration/login_screen.dart';

class FullScreen extends StatefulWidget {
  final String imageUrl;

  FullScreen({super.key, required this.imageUrl});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final user = FirebaseAuth.instance.currentUser;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Wallpapers',
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * .03,
                color: Colors.blue.shade200),
          ),
          centerTitle: true,
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        key: _scaffoldKey,
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .03,
              vertical: MediaQuery.of(context).size.width * .13),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .06,
                width: MediaQuery.of(context).size.width * .13,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 4,
                      offset: Offset(2, 4), // Shadow position
                    ),
                  ],
                ),
                child: Center(
                  child: IconButton(
                    hoverColor: Colors.blue.shade200,
                    color: Colors.blue.shade200,
                    icon: Icon(Icons.amp_stories_rounded),
                    onPressed: () async {
                      _showDialog(widget.imageUrl, context);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
              ),
              Container(
                height: MediaQuery.of(context).size.height * .06,
                width: MediaQuery.of(context).size.width * .13,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 4,
                      offset: Offset(2, 4), // Shadow position
                    ),
                  ],
                ),
                child: Center(
                  child: IconButton(
                    hoverColor: Colors.blue.shade200,
                    color: Colors.blue.shade200,
                    icon: Icon(Icons.download_rounded),
                    onPressed: () async {
                      await setWallpaperFromFile(widget.imageUrl, context);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
              ),
              Container(
                height: MediaQuery.of(context).size.height * .06,
                width: MediaQuery.of(context).size.width * .13,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 4,
                      offset: Offset(2, 4), // Shadow position
                    ),
                  ],
                ),
                child: Center(
                  child: IconButton(
                      hoverColor: Colors.blue.shade200,
                      color: Colors.blue.shade200,
                      icon: (favoriteProvider
                              .isFavorite(widget.imageUrl.toString())
                          ? const Icon(
                              Icons.favorite,
                              color: Color.fromRGBO(211, 47, 47, 1),
                            )
                          : const Icon(
                              Icons.favorite_border,
                              color: Color.fromRGBO(211, 47, 47, 1),
                            )),
                      onPressed: () async {
                        if (user != null) {
                          favoriteProvider.toggleFavorite(widget.imageUrl.toString());
                          if (favoriteProvider.isFavorite(widget.imageUrl.toString())) {
                            Get.showSnackbar(GetSnackBar(
                              // title: 'Oops!',
                              message: 'Added Wallpaper ',
                              duration: Duration(seconds: 3),
                              borderRadius: 25,
                              margin: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * .06),
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              mainButton: TextButton(
                                child: Text("Show All"),
                                onPressed: () {
                                  Get.to(FavoriteScreen());
                                },
                              ),
                            ));
                          } else {
                            Get.showSnackbar(GetSnackBar(
                              // title: 'Oops!',
                              message: 'Wallpaper Removed',
                              duration: Duration(seconds: 3),
                              borderRadius: 25,
                              margin: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * .06),
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                            ));
                          }
                        } else {
                          Get.showSnackbar(GetSnackBar(
                            // title: 'Oops!',
                            message: 'Please Login to add Favorite',
                            duration: Duration(seconds: 3),
                            borderRadius: 25,
                            margin: EdgeInsets.all(
                                MediaQuery.of(context).size.width * .06),
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            maxWidth: Get.width,
                            mainButton: TextButton(
                                child: Text('Login'),
                                onPressed: () {
                                  Get.to(Login());
                                }),
                          ));
                        }
                      }),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
              ),
              Container(
                height: MediaQuery.of(context).size.height * .06,
                width: MediaQuery.of(context).size.width * .13,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 4,
                      offset: Offset(2, 4), // Shadow position
                    ),
                  ],
                ),
                child: Center(
                  child: IconButton(
                    hoverColor: Colors.blue.shade200,
                    color: Colors.blue.shade200,
                    icon: Icon(Icons.share_rounded),
                    onPressed: () async {
                      // final urlPreview = imageUrl;
                      await Share.share(
                          'Cheack This Photo \n \n ${widget.imageUrl}');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: getImage()
        // isLoading
        //     ? CircularProgressIndicator(color: Theme.of(context).colorScheme.primary,)
        //     : Container(
        //         height: MediaQuery.of(context).size.height,
        //         width: MediaQuery.of(context).size.width,
        //         decoration: BoxDecoration(
        //             image: DecorationImage(
        //           image: NetworkImage(widget.imageUrl),
        //           fit: BoxFit.cover,                )),
        //       )
        );
    // );
  }

  Future<void> setWallpaperFromFile(
      String wallpaperUrl, BuildContext context) async {
    Get.showSnackbar(GetSnackBar(
      // title: 'Oops!',
      message: 'Downloading Start ... ',
      duration: Duration(seconds: 5),
      borderRadius: 25,
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * .06),
      backgroundColor: Theme.of(context).colorScheme.secondary,
    ));
    try {
      // Saved with this method.
      final tempDir = await getTemporaryDirectory();
      final path = '${tempDir.path}/myfile.jpg';
      var response = await Dio().download(wallpaperUrl, path);

      if (response == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Error Occured !!",
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
            backgroundColor: Theme.of(context).colorScheme.background));
        return;
      }

      final result =
          await ImageGallerySaver.saveFile(path, isReturnPathOfIOS: true);
      Get.showSnackbar(GetSnackBar(
        // title: 'Oops!',
        message: 'Download Successfully  ',
        duration: Duration(seconds: 10),
        borderRadius: 25,
        margin: EdgeInsets.all(MediaQuery.of(context).size.width * .06),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        mainButton: TextButton(
          child: Text("Open"),
          onPressed: () {
            OpenFile.open(path);
          },
        ),
      ));
    } on PlatformException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error Occured !! $error "),
        backgroundColor: Theme.of(context).colorScheme.background,
      ));
      print(error);
    }
  }

  Future<void> setWallpaper(String wallpaperUrl, int screenNum) async {
    Get.showSnackbar(GetSnackBar(
      // title: 'Oops!',
      message: 'Appling Start ... ',
      duration: Duration(seconds: 10),
      borderRadius: 25,
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * .06),
      backgroundColor: Theme.of(context).colorScheme.secondary,
    ));
    switch (screenNum) {
      case 1:
        {
          int location = WallpaperManager.HOME_SCREEN;
          var file = await DefaultCacheManager().getSingleFile(wallpaperUrl);
          bool result =
              await WallpaperManager.setWallpaperFromFile(file.path, location);
          Get.showSnackbar(GetSnackBar(
            // title: 'Oops!',
            message: 'Appling Sucessfully ',
            duration: Duration(seconds: 5),
            borderRadius: 25,
            margin: EdgeInsets.all(MediaQuery.of(context).size.width * .06),
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ));
          break;
        }
      case 2:
        {
          int location = WallpaperManager.LOCK_SCREEN;
          var file = await DefaultCacheManager().getSingleFile(wallpaperUrl);
          bool result =
              await WallpaperManager.setWallpaperFromFile(file.path, location);
          Get.showSnackbar(GetSnackBar(
            // title: 'Oops!',
            message: 'Appling Sucessfully ',
            duration: Duration(seconds: 5),
            borderRadius: 25,
            margin: EdgeInsets.all(MediaQuery.of(context).size.width * .06),
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ));
          break;
        }
      case 3:
        {
          int location = WallpaperManager.BOTH_SCREEN;
          var file = await DefaultCacheManager().getSingleFile(wallpaperUrl);
          bool result =
              await WallpaperManager.setWallpaperFromFile(file.path, location);
          Get.showSnackbar(GetSnackBar(
            // title: 'Oops!',
            message: 'Appling Sucessfully ',
            duration: Duration(seconds: 5),
            borderRadius: 25,
            margin: EdgeInsets.all(MediaQuery.of(context).size.width * .06),
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ));
          break;
        }
    }
  }

  Future<void> _showDialog(wallpaperUrl, context) async {
    int result = 0;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          // StatefulBuilder
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.background,
              actions: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width * 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "APPLY",
                          style: TextStyle(
                              fontSize: 20, color: Colors.blue.shade200),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RadioListTile(
                          activeColor: Colors.blue.shade200,
                          value: 1,
                          title: Text("HOME SCREEN"),
                          onChanged: (value) {
                            setState(() {
                              result = value!;
                            });
                          },
                          groupValue: result,
                        ),
                        const Divider(
                          height: 5,
                        ),
                        RadioListTile(
                          activeColor: Colors.blue.shade200,
                          value: 2,
                          title: Text("LOCK SCREEN"),
                          onChanged: (value) {
                            setState(() {
                              result = value!;
                            });
                          },
                          groupValue: result,
                        ),
                        const Divider(
                          height: 5,
                        ),
                        RadioListTile(
                          activeColor: Colors.blue.shade200,
                          value: 3,
                          title: Text("BOTH"),
                          onChanged: (value) {
                            setState(() {
                              result = value!;
                            });
                          },
                          groupValue: result,
                        ),
                        const Divider(
                          height: 5,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            MaterialButton(
                              padding: EdgeInsets.fromLTRB(10.0, 5.0, 0, 0),
                              onPressed: () {
                                setState(() {
                                  Get.back();
                                  // Navigator.of(context).pop();
                                });
                              },
                              child: const Text("Cancel",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromRGBO(144, 202, 249, 1),
                                    fontSize: 15,
                                  )),
                            ),
                            MaterialButton(
                              padding: EdgeInsets.fromLTRB(10.0, 5.0, 0, 0),
                              onPressed: () {
                                Get.back();
                                // Navigator.of(context).pop();
                                setWallpaper(wallpaperUrl, result);
                              },
                              child: const Text("OK",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromRGBO(144, 202, 249, 1),
                                    fontSize: 15,
                                  )),
                            ),
                          ],
                        )
                      ],
                    ))
              ],
            );
          },
        );
      },
    );
  }

  Widget getImage() {
    try {
      return isLoading
          ? CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            )
          : InteractiveViewer(
              constrained: true,
            scaleEnabled: true,
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
          );
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      return Container();
    }
  }
}
