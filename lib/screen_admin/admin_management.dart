import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import '../app_theme.dart';
import '../home_admin.dart';
import '../models/homelist.dart';
import '../utils.dart';

class AminManagementScreen extends StatefulWidget {
  const AminManagementScreen({super.key});

  @override
  State<AminManagementScreen> createState() => _AminManagementScreenState();
}

class _AminManagementScreenState extends State<AminManagementScreen> {
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Scaffold(
      backgroundColor: isLightMode == true ? AppTheme.white : AppTheme.nearlyBlack,
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            appBar(context, 'Manaegement'),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('booking_list').orderBy('date').snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return GridView.builder(
                      padding: const EdgeInsets.only(top: 0, left: 12, right: 12),
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 12.0,
                        crossAxisSpacing: 12.0,
                        childAspectRatio: 1.5,
                      ),
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) => buildManagementListItem(context, snapshot.data!.docs[index]),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildManagementListItem(BuildContext context, QueryDocumentSnapshot<Object?> document) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;

    String name = document['name'];
    String tel = document['tel'];
    String numberOfPeople = document['num'].toString();
    String reserveDate = document['date'].toDate().toString().substring(0, 10);
    String reserveTime = document['time'];

    return FlipCard(
      fill: Fill.fillBack, // Fill the back side of the card to make in the same size as the front.
      direction: FlipDirection.HORIZONTAL, // default
      side: CardSide.FRONT,
      front: Container(
        decoration: BoxDecoration(
          color: isLightMode ? AppTheme.nearlyBlack : AppTheme.white,
          border: Border.all(width: 4),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: SizedBox(
            child: Image.asset('assets/images/small_logo.png'),
          ),
          title: Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: isLightMode ? AppTheme.white : AppTheme.nearlyBlack,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Column(
            children: [
              const SizedBox(height: 50),
              Text(numberOfPeople),
              Text(reserveTime),
            ],
          ),
          trailing: Text(
            reserveDate,
            style: TextStyle(
              fontSize: 10,
              color: isLightMode ? AppTheme.white : AppTheme.nearlyBlack,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      back: Container(
        decoration: BoxDecoration(
          color: isLightMode ? AppTheme.nearlyBlack : AppTheme.white,
          border: Border.all(width: 4),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
