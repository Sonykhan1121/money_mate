import 'package:flutter/material.dart';
import '../widgets/mini_bar_chart.dart';
import '../../../../core/utils/constants/icons.dart';
import '../../../../core/utils/constants/colors.dart';
import 'package:money_mate/core/utils/extensions/provider_extension.dart';
import 'package:money_mate/features/home/presentation/views/recent_transactions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  // Gradient background with curve
                  Container(
                    height: MediaQuery.of(context).size.height*0.135,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          DColors.primary,
                          DColors.primarySecondary,
                        ],
                      ),
                    ),
                  ),
                  // Content on top of gradient
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Greeting
                         Row(
                           children: [
                             Text(
                              'Good Morning',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                                                     ),
                             Spacer(),
                             InkWell(
                               onTap: (){

                               },
                               child: CircleAvatar(
                                 radius: 15,
                                 child: Image.asset(DIcons.app_logo1),
                               ),
                             )
                           ],
                         ),
                        const SizedBox(height: 4),
                        // Name with wave emoji
                        Row(
                          children:  [
                            Text(
                              'Sony',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '👋',
                              style: TextStyle(fontSize: 20),
                            ),

                          ],
                        ),
                        const SizedBox(height: 10),
                        // Balance Card
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 20,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Balance',
                                style: TextStyle(
                                  color: DColors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                   Text(
                                    'Tk',
                                    style: TextStyle(
                                      color: DColors.fBlack,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  const Text(
                                    '45,280',
                                    style: TextStyle(
                                      color: DColors.fBlack,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            // Income Card
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(right: 5), // spacing between cards
                                decoration: BoxDecoration(
                                  color: DColors.success, // background color
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.only(left: 8), // space for inner card
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.08),
                                        blurRadius: 20,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Income',
                                        style: TextStyle(
                                          color: DColors.grey,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Text(
                                            'Tk',
                                            style: TextStyle(
                                              color: DColors.success,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          const Text(
                                            '62,500',
                                            style: TextStyle(
                                              color: DColors.success,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
          
                            // Expenses Card
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 5), // spacing between cards
                                decoration: BoxDecoration(
                                  color: DColors.error,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.only(left: 8),
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.08),
                                        blurRadius: 20,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Expenses',
                                        style: TextStyle(
                                          color: DColors.grey,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Text(
                                            'Tk',
                                            style: TextStyle(
                                              color: DColors.error,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          const Text(
                                            '17,220',
                                            style: TextStyle(
                                              color: DColors.error,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ],
              ),
          
              // Rest of your content goes here
              Padding(
                padding: const EdgeInsets.all(20),
                child: MiniBarChart(data: [5,8,20,5,30,8,20]),
              ),
          
              Padding(
                padding: const EdgeInsets.all(20),
                child: RecentTransactions(),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          context.navigationProvider.setCurrentIndex(1);
        },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}