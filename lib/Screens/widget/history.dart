import 'package:flutter/material.dart';

class CreditHistory extends StatelessWidget {
  final String title;
  final String amount;
  final String date;
  final String subtitle;
  final Icon icon;
  const CreditHistory({super.key, required this.title, required this.amount, required this.date, required this.subtitle, required this.icon});

  @override
  Widget build(BuildContext context) {
    return  Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                 height: 73,
                  width: 400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                     CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white.withOpacity(0.1),
                      child: Icon(icon.icon, color: Colors.blueAccent, size: 20),),
                      Column(
                        children: [
                          const SizedBox(height: 20,),
                          Text(title, style: const TextStyle(color: Colors.white, fontSize: 16),),
                          Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 14),),
                      ]),
                      Column(
                        children: [
                          const SizedBox(height: 20,),
                          Text('+\$$amount', style: const TextStyle(color: Colors.greenAccent, fontSize: 14),),
                          Text(date, style: const TextStyle(color: Colors.white70, fontSize: 14),),
                      ]),
                    ],
                  ),
                );

  }
}



class DebitHistory extends StatelessWidget {
  final String title;
  final String amount;
  final String date;
  final String subtitle;
  final Icon icon;
  const DebitHistory({super.key, required this.title, required this.amount, required this.date, required this.subtitle, required this.icon});

  @override
  Widget build(BuildContext context) {
    return  Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                 height: 73,
                  width: 400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                     CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white.withOpacity(0.1),
                      child: Icon(icon.icon, color: Colors.blueAccent, size: 20),),
                      Column(
                        children: [
                          const SizedBox(height: 20,),
                          Text(title, style: const TextStyle(color: Colors.white, fontSize: 16),),
                          Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 14),),
                      ]),
                      Column(
                        children: [
                          const SizedBox(height: 20,),
                          Text('-\$$amount', style: TextStyle(color: Colors.red[500], fontSize: 14),),
                          Text(date, style: const TextStyle(color: Colors.white70, fontSize: 14),),
                      ]),
                    ],
                  ),
                );

  }
}