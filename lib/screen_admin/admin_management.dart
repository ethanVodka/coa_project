import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import '../app_theme.dart';

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
            appBar(),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: getSnapshot(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text(
                          'no booking',
                          style: TextStyle(
                            fontSize: 30,
                            color: isLightMode ? AppTheme.nearlyBlack : AppTheme.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      );
                    }
                    return GridView.builder(
                      padding: const EdgeInsets.only(top: 0, left: 12, right: 12),
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 12.0,
                        childAspectRatio: 5.0,
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

  Stream<QuerySnapshot<Map<String, dynamic>>> getSnapshot() => FirebaseFirestore.instance.collection('booking_list').orderBy('date').snapshots();

  Widget appBar() {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: SizedBox(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'Management',
                  style: TextStyle(
                    fontSize: 22,
                    color: isLightMode ? AppTheme.darkText : AppTheme.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              color: isLightMode ? Colors.white : AppTheme.nearlyBlack,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(AppBar().preferredSize.height),
                  child: Icon(
                    Icons.settings,
                    color: isLightMode ? AppTheme.darkGrey : AppTheme.white,
                  ),
                  onTap: () {
                    setState(() {
                      //multiple = !multiple;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildManagementListItem(BuildContext context, QueryDocumentSnapshot<Object?> document) {
    GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;

    String name = document['name'];
    String tel = document['tel'];
    String numberOfPeople = document['num'].toString();
    String reserveDate = document['date'].toDate().toString().substring(0, 10);
    String reserveTime = document['time'];

    return FlipCard(
      key: cardKey,
      fill: Fill.fillBack,
      direction: FlipDirection.VERTICAL,
      side: CardSide.FRONT,
      front: Container(
        decoration: BoxDecoration(
          color: isLightMode ? AppTheme.nearlyBlack : AppTheme.white,
          border: Border.all(width: 3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Image.asset('assets/images/small_logo.png'),
          title: Text(
            name,
            style: TextStyle(
              fontSize: 20,
              color: isLightMode ? AppTheme.white : AppTheme.nearlyBlack,
              fontWeight: FontWeight.w700,
            ),
          ),
          trailing: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  reserveDate,
                  style: TextStyle(
                    fontSize: 16,
                    color: isLightMode ? AppTheme.white : AppTheme.nearlyBlack,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  reserveTime,
                  style: TextStyle(
                    fontSize: 16,
                    color: isLightMode ? AppTheme.white : AppTheme.nearlyBlack,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      back: Container(
        decoration: BoxDecoration(
          color: isLightMode ? AppTheme.white : AppTheme.nearlyBlack,
          border: Border.all(width: 3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Image.asset('assets/images/small_logo.png'),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '予約人数 : $numberOfPeople',
                  style: TextStyle(
                    fontSize: 16,
                    color: isLightMode ? AppTheme.nearlyBlack : AppTheme.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '電話番号 : $tel',
                  style: TextStyle(
                    fontSize: 16,
                    color: isLightMode ? AppTheme.nearlyBlack : AppTheme.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.more_vert,
              color: isLightMode ? AppTheme.nearlyBlack : AppTheme.white,
            ),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: isLightMode == true ? AppTheme.nearlyWhite : AppTheme.white,
                    title: const Text("予約内容編集", textAlign: TextAlign.center),
                    content: const Text('予約を削除し、枠を開けます\nよろしですか？'),
                    actions: [
                      TextButton(
                        child: const Text("No"),
                        onPressed: () => Navigator.pop(context),
                      ),
                      TextButton(
                        child: const Text("Yes"),
                        onPressed: () async {
                          var mainReference = FirebaseFirestore.instance.collection('booking_list').doc(document.id);
                          mainReference.delete();
                          Navigator.pop(context);
                          cardKey.currentState?.toggleCard();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
