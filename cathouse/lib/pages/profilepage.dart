import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'navbar.dart';

class ProfileCat extends StatelessWidget {
  const ProfileCat({super.key});

  @override
  Widget build(BuildContext context) {
    Color cream = const Color(0xffE0CCBE);
    Color darkcream = const Color(0xff747264);
    Color coklat = const Color(0xff3C3633);
    return Scaffold(
      backgroundColor: const Color(0xffEEEDEB),
      drawer: const NavBar(),
      appBar: AppBar(
        backgroundColor: const Color(0xffE0CCBE),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
        ],
        title: const Center(
          child: Text(
            'SMART CATHOUSE',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Paratha',
                color:  Color(0xff3C3633)),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: coklat,
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, Buddy!',
                      style: TextStyle(
                        color: cream,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'UnigeoMedium',
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Welcome to',
                      style: TextStyle(
                        color: cream,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'UnigeoMedium',
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Cathouse',
                      style: TextStyle(
                        color: darkcream,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'UnigeoMedium',
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
                Lottie.asset('lib/assets/cat1.json', height: 110),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Cat Profile',
                  style: TextStyle(
                    color: coklat,
                    fontFamily: 'UnigeoMedium',
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  DateFormat('dd MMMM yyyy').format(DateTime.now()),
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'AgencyFB',
                    color: coklat,
                  ),
                ),
                const SizedBox(width: 10),
                StreamBuilder<DateTime>(
                  stream: Stream.periodic(
                      const Duration(seconds: 1), (i) => DateTime.now()),
                  builder: (context, snapshot) {
                    return Text(
                      DateFormat('HH:mm').format(snapshot.data ?? DateTime.now()),
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'AgencyFB',
                        color: coklat,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


