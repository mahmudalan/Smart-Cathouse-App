import 'package:cathouse/pages/profilepage.dart';
import 'package:flutter/material.dart';
import 'helppage.dart';
import 'homepage.dart';
import 'kittenpage.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xffEEEDEB),
      width: 280,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xff3C3633),
              image: DecorationImage(
                  image: AssetImage('lib/assets/wallpaper.jpeg'),fit: BoxFit.cover)
            ),
            accountName: const Text('Mahmud Alan',style: TextStyle(fontWeight: FontWeight.bold),),
            accountEmail: const Text('mahmudalan77@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset('lib/assets/user.jpg',),
              ),
            ),
          ),
          ListTile(
            leading: Image.asset('lib/assets/activity.png',height: 25, color: const Color(0xff747264),),
            title: const Text('Dashboard',
              style: TextStyle(
                fontFamily: 'UnigeoMedium',
                color: Color(0xff747264),
                fontSize: 15
            ),),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const HomePage()));
            },
          ),
          ListTile(
            leading: Image.asset('lib/assets/pawprint.png',height: 25,color: const Color(0xff747264)),
            title: const Text('Kitten Mode',
              style: TextStyle(
                fontFamily: 'UnigeoMedium',
                color: Color(0xff747264),
                fontSize: 15
            ),),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const KittenPage()));
            },
          ),
          ListTile(
            leading: Image.asset('lib/assets/profile.png',height: 25,color: const Color(0xff747264)),
            title: const Text('Profile',
              style: TextStyle(
                fontFamily: 'UnigeoMedium',
                color: Color(0xff747264),
                fontSize: 15
            ),),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const ProfileCat()));
            },
          ),
          const Divider(
            color: Color(0xff747264),
            height: 10,
            endIndent: 20,
            indent: 10,
          ),
          ListTile(
            leading: Image.asset('lib/assets/setting.png',height: 25,color: const Color(0xff747264)),
            title: const Text('Settings',
              style: TextStyle(
                fontFamily: 'UnigeoMedium',
                color: Color(0xff747264),
                fontSize: 15
            ),),
            onTap: (){},
          ),
          ListTile(
            leading: Image.asset('lib/assets/contact.png',height: 25,color: const Color(0xff747264)),
            title: const Text('Contact Us',
              style: TextStyle(
                fontFamily: 'UnigeoMedium',
                color: Color(0xff747264),
                fontSize: 15
            ),),
            onTap: (){},
          ),
          ListTile(
            leading: Image.asset('lib/assets/question.png',height: 25,color: const Color(0xff747264)),
            title: const Text('Help',
              style: TextStyle(
                fontFamily: 'UnigeoMedium',
                color: Color(0xff747264),
                fontSize: 15
            ),),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const HelpPage()));
            },
          ),
          ListTile(
            leading: Image.asset('lib/assets/exit.png',height: 25,color: const Color(0xff747264)),
            title: const Text('Sign Out',
              style: TextStyle(
                fontFamily: 'UnigeoMedium',
                color: Color(0xff747264),
                fontSize: 15
            ),),
            onTap: (){},
          ),
          const Divider(
            color: Color(0xff747264),
            height: 10,
            endIndent: 20,
            indent: 10,
          ),
          const Center(
            child: Text('Mahmud Alan | 2024 | v1.0.0', style: TextStyle(color: Color(0xff747264), fontFamily: 'AgencyFB', fontWeight: FontWeight.bold),),
          )
        ],
      ),
    );
  }
}

