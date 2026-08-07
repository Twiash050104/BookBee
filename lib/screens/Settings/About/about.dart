import 'package:flutter/material.dart';
import 'package:flutter_bookbee/Widgets/glassback_button.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  GlassBackButton(),
                  Expanded(
                    child: Center(
                      child: Text(
                        'About',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 50),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 12),
                    Image.asset('assets/images/logo.png', width: 220),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: 'Book',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: 'Bee',
                            style: TextStyle(color: Color(0xFFFE9A34)),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Version 1.0.0',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.black54,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 16,
                        left: 12,
                        right: 12,
                        bottom: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "BookBee is a personal reading companion designed to help readers organize their literary journey. Whether you're exploring your next favorite novel, keeping track of books you've read, or building your own digital bookshelf, BookBee makes it simple and enjoyable.",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 22),
                          Row(
                            children: [
                              Icon(Icons.rocket_launch_outlined),
                              const SizedBox(width: 8),
                              Text(
                                'Our Mission',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "At BookBee, we believe every book has the power to inspire, educate, and connect people. Our mission is to create a beautiful, distraction-free space where readers can discover stories, stay organized, and celebrate their love for books.",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 22),
                          Row(
                            children: [
                              Icon(Icons.workspace_premium_outlined),
                              const SizedBox(width: 8),
                              Text(
                                'Acknowledgements',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "BookBee was inspired by conversations with my close friend, Ritika, whose ideas helped shape the initial concept of the App.\nSpecial thanks to my friends for their valuable feedback, research, and suggestions throughout the development journey.",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 22),
                          Row(
                            children: [
                              Icon(Icons.code_rounded),
                              const SizedBox(width: 8),
                              Text(
                                'Developed by',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Ashutosh Tiwari",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Divider(height: 32),
                          ListTile(
                            leading: const Icon(Icons.article_outlined),
                            title: const Text('Open Source Licenses'),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              showLicensePage(
                                context: context,
                                applicationName: 'BookBee',
                                applicationVersion: '1.0.0',
                              );
                            },
                          ),
                          const SizedBox(height: 12),
                          Center(
                            child: Text(
                              "© 2026 BookBee",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
