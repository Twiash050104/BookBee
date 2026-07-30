import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bookbee/screens/Settings/setting.dart';

class Usercard extends StatefulWidget {
  const Usercard({super.key});
  @override
  State<Usercard> createState() => _UsercardState();
}

class _UsercardState extends State<Usercard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.orange, Colors.transparent],
                ),
              ),
            ),
            Positioned(
              bottom: 70,
              right: 0,
              left: 0,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 12, right: 12),
                  child: Text(
                    textAlign: TextAlign.center,
                    "'"
                    'This will be the about section of user where they can tell about themselves and many more things :)'
                    "'",
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              right: 0,
              left: 0,
              bottom: 10,
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      // boxShadow: [
                      //   BoxShadow(
                      //     blurRadius: 2,
                      //     color: Colors.black12,
                      //     offset: Offset(0.2, 0.3),
                      //   ),
                      // ],
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.black12),
                      //boxShadow: [BoxShadow()],
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.message_rounded,
                        // shadows: [
                        //   Shadow(
                        //     blurRadius: 12,
                        //     color: Colors.black,
                        //     offset: Offset(1, 3),
                        //   ),
                        // ],
                        size: 26,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.grey.withOpacity(0.2),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.2),
                            width: 0.9,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                'This is username',
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.black12),
                      //boxShadow: [BoxShadow()],
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.send_rounded,
                        size: 26,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                    //boxShadow: [BoxShadow(color: Colors.transparent)],
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingScreen(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.settings,
                      size: 32,
                      color: Colors.black87,
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          offset: Offset(0.2, 0.8),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
