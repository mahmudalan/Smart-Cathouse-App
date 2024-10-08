import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../services/realtime_db.dart';

class Dispenser extends StatefulWidget {
  const Dispenser({Key? key}) : super(key: key);

  @override
  State<Dispenser> createState() => _DispenserState();
}

class _DispenserState extends State<Dispenser> {
  dynamic levelFood;
  bool isManualMode = false;
  bool isButtonPressed = false;

  @override
  void initState() {
    dataLevel.onValue.listen((event) {
      final getdataLevel = event.snapshot;
      setState(() {
        levelFood = getdataLevel.value;
      });
    });
    super.initState();
  }

  void toggleModeDispenser(bool newValue) {
    setState(() {
      isManualMode = newValue;
      final modeDis = isManualMode ? 'Man' : 'Auto';
      dataModeDis.set(modeDis);
    });
  }

  @override
  Widget build(BuildContext context) {
    String status;
    if (levelFood != null) {
      if (levelFood <= 15) {
        status = "Full";
      } else {
        status = "Empty";
      }
    } else {
      status = "loading data";
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xff3C3633),
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi, Buddy!',
                    style: TextStyle(
                      color: Color(0xffE0CCBE),
                      fontSize: 13,
                      fontFamily: 'UnigeoMedium',
                    ),
                  ),
                  Text(
                    'Welcome to',
                    style: TextStyle(
                      color: Color(0xffE0CCBE),
                      fontSize: 15,
                      fontFamily: 'UnigeoMedium',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Cathouse',
                    style: TextStyle(
                      color: Color(0xff747264),
                      fontSize: 30,
                      fontFamily: 'UnigeoMedium',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(height: 10),
                  Lottie.asset('lib/assets/cat1.json', height: 110),
                  const SizedBox(height: 10),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Dispenser Dashboard',
            style: TextStyle(
              color: Color(0xff3C3633),
              fontFamily: 'UnigeoMedium',
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                DateFormat('dd/MM/yy').format(DateTime.now()),
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'AgencyFB',
                  color: Color(0xff3C3633),
                ),
              ),
              const SizedBox(width: 10),
              StreamBuilder<DateTime>(
                stream: Stream.periodic(const Duration(seconds: 1), (i) => DateTime.now()),
                builder: (context, snapshot) {
                  return Text(
                    DateFormat('HH:mm').format(snapshot.data ?? DateTime.now()),
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'AgencyFB',
                      color: Color(0xff3C3633),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xffE0CCBE), width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('lib/assets/foodcat.png', height: 70),
              const Column(
                children: [
                  SizedBox(height: 5),
                  Text(
                    'Welcome to',
                    style: TextStyle(
                      fontFamily: 'UnigeoMedium',
                      color: Color(0xff747264),
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'dispenser dashboard',
                    style: TextStyle(
                      fontFamily: 'UnigeoMedium',
                      color: Color(0xff747264),
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'Smart Cathouse.',
                    style: TextStyle(
                      fontFamily: 'UnigeoMedium',
                      color: Color(0xff747264),
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'Enjoy your day, Sir.',
                    style: TextStyle(
                      fontFamily: 'UnigeoMedium',
                      color: Color(0xff747264),
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffE0CCBE), width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              width: 130,
              height: 80,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  const Text(
                    'Dispenser Mode',
                    style: TextStyle(
                      color: Color(0xff3C3633),
                      fontFamily: 'UnigeoMedium',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Switch(
                    activeColor: const Color(0xff3C3633),
                    value: isManualMode,
                    onChanged: toggleModeDispenser,
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffE0CCBE), width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              height: 80,
              width: 185,
              margin: const EdgeInsets.only(right: 15),
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  const Text(
                    'Status Mode :',
                    style: TextStyle(
                      color: Color(0xff3C3633),
                      fontFamily: 'UnigeoMedium',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    isManualMode ? 'Manually' : 'Automatic',
                    style: const TextStyle(
                      color: Color(0xff747264),
                      fontFamily: 'UnigeoMedium',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffE0CCBE), width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  const Text(
                    'Manually',
                    style: TextStyle(
                      color: Color(0xff3C3633),
                      fontFamily: 'UnigeoMedium',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Image.asset('lib/assets/catmanually.png', height: 150),
                  ElevatedButton(
                    onPressed: isManualMode? () {
                      setState(() {
                        isButtonPressed = !isButtonPressed;
                        final manDis = isButtonPressed ? 'On' : 'Off';
                        dataManDis.set(manDis);
                      });
                    } : null,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        isButtonPressed ? Colors.green : Colors.red,
                      ),
                    ),
                    child: Text(
                      isButtonPressed ? 'ON' : 'OFF',
                      style: TextStyle(
                        color: isButtonPressed ? Colors.white : Colors.black,
                        fontFamily: 'UnigeoMedium',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xffE0CCBE), width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              height: 235,
              width: 160,
              margin: const EdgeInsets.only(right: 15),
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  const Text(
                    'Automatic',
                    style: TextStyle(
                      color: Color(0xff3C3633),
                      fontFamily: 'UnigeoMedium',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Current Level :',
                    style: TextStyle(
                      color: Color(0xff3C3633),
                      fontFamily: 'UnigeoMedium',
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '$levelFood cm',
                    style: const TextStyle(
                      color: Color(0xff747264),
                      fontFamily: 'AgencyFB',
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Status :',
                    style: TextStyle(
                      color: Color(0xff3C3633),
                      fontFamily: 'UnigeoMedium',
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    status,
                    style: const TextStyle(
                      color: Color(0xff747264),
                      fontFamily: 'AgencyFB',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
