import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/constants/colors.dart';

class TransactionDetails extends StatefulWidget {
  const TransactionDetails({super.key});

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  List<String> tags = ["food", "lunch", "restaurant"];
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context,tProvider,child){
      
      
      return Scaffold(
        appBar: AppBar(title: Text("Transaction Details"),),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: DColors.fWhite,
                    boxShadow: [
                      BoxShadow(
                        color: DColors.grey.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(4, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width:double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: DColors.primary.withOpacity(0.3)
                        ),
                        child: Icon(Icons.image,size: 50,),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        width:double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: DColors.grey.withOpacity(0.1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.remove_red_eye_rounded,size: 20,),
                            SizedBox(width: 5,),
                            Text('View Full Image',style: TextStyle(color: DColors.primary),),
                          ],
                        ),
                      ),



                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: DColors.grey.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(4, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transaction Information',
                        style: TextStyle(
                          color: DColors.fBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Divider(color: DColors.fBlack.withOpacity(0.1),),
                      ListTile(
                        contentPadding: EdgeInsets.zero,

                        leading: Text('Title',style: TextStyle(fontSize: 12,color: DColors.grey),),
                        trailing: Text("Lunch At star Kabab",style: TextStyle(fontSize: 14),),
                      ),
                      Divider(color: DColors.fBlack.withOpacity(0.1),),

                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Text('Amount',style: TextStyle(fontSize: 12,color: DColors.grey),),
                        trailing: Text("-৳ 450",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: DColors.error),),
                      ),
                      Divider(color: DColors.fBlack.withOpacity(0.1),),

                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Text('Category',
                          style: TextStyle(fontSize: 12, color: DColors.grey),),
                        trailing: Container(
                            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: DColors.primary.withOpacity(0.1),
                            ),
                            child: Text("Food & Dining", style: TextStyle(
                                fontSize: 12, color: DColors.primary),)),
                      ),
                      Divider(color: DColors.fBlack.withOpacity(0.1),),
                      ListTile(
                        contentPadding: EdgeInsets.zero,

                        leading: Text('Date',style: TextStyle(fontSize: 12,color: DColors.grey),),
                        trailing: Text("Oct 22, 2025 - 12:30 PM",style: TextStyle(fontSize: 14),),
                      ),
                      Divider(color: DColors.fBlack.withOpacity(0.1),),
                      ListTile(
                        contentPadding: EdgeInsets.zero,

                        leading: Text('Payment Method',style: TextStyle(fontSize: 12,color: DColors.grey),),
                        trailing: Text("Cash",style: TextStyle(fontSize: 14),),
                      ),
                      Divider(color: DColors.fBlack.withOpacity(0.1),),
                      ListTile(
                        contentPadding: EdgeInsets.zero,

                        leading: Text('Location',style: TextStyle(fontSize: 12,color: DColors.grey),),
                        trailing: Text("Dhanmondi, Dhaka",style: TextStyle(fontSize: 14),),
                      ),
                     SizedBox(height: 10,),


                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: DColors.grey.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(4, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(
                          color: DColors.fBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Divider(color: DColors.fBlack.withOpacity(0.1),),
                      SizedBox(height: 20,),

                      Text('Delicious Biriyani with friends . Great Food and atmosphere . Will visit again soon!',style: TextStyle(fontSize: 14,color: DColors.fBlack,fontWeight: FontWeight.w600),),
                      SizedBox(height: 10,),


                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: DColors.grey.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(4, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tags',
                        style: TextStyle(
                          color: DColors.fBlack,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Divider(color: DColors.fBlack.withOpacity(0.1),),
                      SizedBox(height: 20,),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: tags.map((tag) {
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: DColors.primary.withOpacity(0.1),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.local_offer_rounded, size: 12, color: DColors.fYellow),
                                SizedBox(width: 5),
                                Text(
                                  tag,
                                  style: TextStyle(fontSize: 12, color: DColors.primary),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),


                      SizedBox(height: 10,),


                    ],
                  ),
                ),

                SizedBox(height: 20,),

                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                        backgroundColor: DColors.fWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: DColors.primary,
                            width: 1.5,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min, // keeps the button compact
                        children: [
                          Icon(Icons.edit, color:DColors.primary, size: 16),
                          SizedBox(width: 8),
                          Text(
                            'Edit',
                            style: TextStyle(color: DColors.primary, fontSize: 14),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 10,),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          backgroundColor: DColors.fWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: DColors.error,
                              width: 1.5,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.delete_outline, color: DColors.error, size: 16),
                            SizedBox(width: 8),
                            Text(
                              'Delete',
                              style: TextStyle(color: DColors.error, fontSize: 14),

                            ),
                          ],
                        ),
                      ),
                    )
                    ,
                    SizedBox(width: 10,),

                    Expanded(child: ElevatedButton(
                        onPressed: () {}, style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                           vertical: 20),
                      backgroundColor: DColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),),  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.share, color: DColors.fWhite, size: 16),
                        SizedBox(width: 8),
                        Text(
                          'Share',
                          style: TextStyle(color: DColors.fWhite, fontSize: 14),

                        ),
                      ],
                    ),)),
                  ],
                ),
                SizedBox(height: 20,),

              ],
            ),
          ),
        ),
      );
    });
  }
  
}
