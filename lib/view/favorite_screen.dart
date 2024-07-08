import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/models/favorite/favorite_provider.dart';
import 'package:wallpaper/view/full_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wallpaper/view/registration/forgot_screen.dart';
import 'package:wallpaper/view/wallpaper.dart';

class FavoriteScreen extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
   FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final image = favoriteProvider.favoriteImage;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Favorites',
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * .03,
                color: Colors.blue.shade200),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  _showDialog(context);
                },
                icon: Icon(Icons.logout_rounded))
          ],
        ),
        body: image.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.heart_broken,
                      size: 100,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    Text(
                      'Empty',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    Text(
                      'Please add some Picuters',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.secondary,
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
                        itemCount: image.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 3,
                          childAspectRatio: 2 / 3,
                          mainAxisSpacing: 3,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullScreen(
                                    imageUrl: image[index],
                                  ),
                                ),
                              );
                            },
                            child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height * 1,
                                    width: 500,
                                    child: Hero(
                                      tag: image[index],
                                      child: Container(
                                        color: Colors.white,
                                        child: Image.network(
                                          image[index],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.white,
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.favorite,
                                          color: Color.fromRGBO(211, 47, 47, 1),
                                        ),
                                      )),
                                ]),
                          );
                        }),
                  ),
                ),
              ]));
  }

  signout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> _showDialog(context) async {
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
                          "Are You Sure About That!!",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            MaterialButton(
                              padding: EdgeInsets.fromLTRB(10.0, 5.0, 0, 0),
                              onPressed: () {
                                setState(() {
                                  Navigator.of(context).pop();
                                });
                              },
                              child: Text("Cancel",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.secondary,
                                    fontSize: 15,
                                  )),
                            ),
                            MaterialButton(
                              padding: EdgeInsets.fromLTRB(10.0, 5.0, 0, 0),
                              child:  Text("OK",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.secondary,
                                    fontSize: 15,
                                  )),
                              onPressed: () {
                                signout();
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Wallpaper()));
                              },
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
}
