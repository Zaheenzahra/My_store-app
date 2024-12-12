import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(child: Text('Mitt Konto')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Container(
              height: height * 0.1,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey.shade300,
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Name',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          'myname@gmail.com',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '07xxxxxxxx',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * 0.09,
            ),
            Row(
              children: [
                SizedBox(
                  width: width * 0.05,
                ),
                const Icon(Icons.settings_outlined),
                SizedBox(
                  width: width * 0.03,
                ),
                const Text('Kontoinstallningar'),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              children: [
                SizedBox(
                  width: width * 0.05,
                ),
                const Icon(Icons.payments_outlined),
                SizedBox(
                  width: width * 0.03,
                ),
                const Text('Mina betalmetoder'),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              children: [
                SizedBox(
                  width: width * 0.05,
                ),
                const Icon(Icons.support_outlined),
                SizedBox(
                  width: width * 0.03,
                ),
                const Text('Support'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
