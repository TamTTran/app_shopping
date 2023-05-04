import 'package:flutter/material.dart';
import '../minor_screens/search_screen.dart';
class FakeScreen extends StatelessWidget {
  const FakeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
     onTap: () { 
       Navigator.push(context,
       MaterialPageRoute(builder: (context) { return 
       const SearchScreen();
       },));
     },
      child: Container(
       height: 37,
       decoration: BoxDecoration(
         border: Border.all(color: Colors.purpleAccent.shade400),
         borderRadius: BorderRadius.circular(24),
         ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
         children:  [
           Row(
             children: const [
               Padding(
                 padding: EdgeInsets.symmetric(horizontal: 8.0),
                 child: Icon(
                   Icons.search,
                   color: Colors.grey,
                 ),
               ),
               Text(
                 'What are you looking for ?',
                 style: TextStyle(
                   color: Colors.grey,
                   fontSize: 16
                 ),
               ),
             ],
           ),
          //const  SizedBox(width: 10,),
            Container(
             height: 35,
             width: 80,
             decoration: const BoxDecoration(
               color: Colors.yellow,
               borderRadius: BorderRadius.all( Radius.circular(24))),
             child: const Center(
               child: Text('Search', style: TextStyle(color: Colors.grey, fontSize: 16)),
             ),
            ),
         ],
        ), 
                ),
    );
  }
}