import 'package:flutter/material.dart';
import 'dart:ui';

import '../screens/Home/home.dart';
import '../screens/Search/search.dart';
import '../screens/Shelf/shelf.dart';
import '../screens/Profile/profile.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  Widget _navItem(IconData icon, int index, String title) {
    final selected = currentindex == index;

    return Expanded(
      child: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () {
          setState(() {
            currentindex = index;
          });
        },
        icon: AnimatedScale(
          duration: const Duration(milliseconds: 350),
          scale: selected ? 1.1 : 1,
          child: Column(
            children: [
              Icon(
                icon,
                size: 30,
                color: selected
                    ? Color.fromARGB(255, 255, 251, 236)
                    : Colors.black87,
                shadows: [
                  Shadow(
                    color: selected
                        ? Colors.black26
                        : const Color.fromARGB(10, 0, 0, 0),
                    blurRadius: 6,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                title,
                style: TextStyle(
                  fontWeight: selected ? FontWeight.w900 : FontWeight.normal,
                  fontSize: 12,
                  color: selected
                      ? Color.fromARGB(255, 255, 251, 236)
                      : Colors.black87,
                  shadows: [
                    Shadow(
                      color: selected
                          ? Colors.black26
                          : const Color.fromARGB(10, 0, 0, 0),
                      blurRadius: 4,
                      offset: Offset(0, 0.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(),
      SearchScreen(),
      ShelfScreen(),
      ProfileScreen(),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SafeArea(
        top: false,
        bottom: false,

        child: Stack(
          children: [
            IndexedStack(index: currentindex, children: pages),

            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  right: 12,
                  left: 12,
                  top: 0,
                  bottom: MediaQuery.of(context).padding.bottom,
                ),
                child: RepaintBoundary(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(48),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: double.infinity,
                        height: 74,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.09),
                            width: 0.9,
                          ),
                          borderRadius: BorderRadius.circular(48),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              spreadRadius: 0.3,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final itemWidth = constraints.maxWidth / 4;

                            ///THE PILL OF NAV BAR OF SELECTED SECTION
                            return Stack(
                              children: [
                                AnimatedPositioned(
                                  duration: const Duration(milliseconds: 350),
                                  curve: Curves.easeInOut,
                                  left: currentindex * itemWidth,
                                  top: 4,
                                  bottom: 4,
                                  child: Container(
                                    width: itemWidth,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        //sigmaX: 10,
                                        //sigmaY: 10,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color(
                                            0xFFFFAB40,
                                          ).withOpacity(0.95),
                                          borderRadius: BorderRadius.circular(
                                            48,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 6,
                                    right: 6,
                                    top: 6,
                                    //bottom: 6,
                                  ),
                                  child: Row(
                                    children: [
                                      _navItem(Icons.home_outlined, 0, "Home"),
                                      _navItem(
                                        Icons.search_rounded,
                                        1,
                                        "Search",
                                      ),
                                      _navItem(
                                        Icons.menu_book_outlined,
                                        2,
                                        "Shelf",
                                      ),
                                      _navItem(
                                        Icons.person_2_outlined,
                                        3,
                                        "Profile",
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
