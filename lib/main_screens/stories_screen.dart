import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_mysql/main_screens/visit_store.dart';
import 'package:flutter/material.dart';

class StoriesScreen extends StatefulWidget {
  const StoriesScreen({Key? key}) : super(key: key);

  @override
  _StoriesScreenState createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stories',
          style: TextStyle(
              fontFamily: 'Acme',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('supplier').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data!.docs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 25,
                  mainAxisSpacing: 25,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return VisitStore(supid: snapshot.data!.docs[index]['sid']);
                      },));
                    },
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              height: 120,
                              width: 120,
                              child: Image.asset('images/inapp/store.jpg'),
                            ),
                            Positioned(
                              bottom: 28,
                              left: 10,
                              child: SizedBox(
                                height: 50,
                                width: 100,
                                child: Image.network(
                                  snapshot.data!.docs[index]['storeLogo'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          snapshot.data!.docs[index]['storeName'],
                          style: const TextStyle(
                              fontFamily: 'AkayaTelivigala',
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  );
                },
              );
            }
            return const Center(
              child: Text(
                'No stores',
                style: TextStyle(
                    fontFamily: 'AkayaTelivigala',
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            );
          },
        ),
      ),
    );
  }
}
