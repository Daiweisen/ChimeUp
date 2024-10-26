import 'package:chimeup/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TransferScreen extends StatefulWidget {
  final String amount;

  const TransferScreen({super.key, required this.amount});

  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final TextEditingController accountController = TextEditingController();
  final TextEditingController accountOwnerController = TextEditingController(); // Controller for account owner's name
  String selectedBank = '';
  String bankName = ''; // Mocked bank name

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer Money', style:TextStyle(color: Colors.white, fontSize: 16),),
        backgroundColor: buttonColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Amount:', style: TextStyle(fontSize: 12, color: Colors.white),),
            Text(
              '₦${widget.amount}',
              style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text('Enter Account Number', style: TextStyle(color: Colors.white, fontSize: 12),),
            SizedBox(height: 10,),
            TextField(
              style: const TextStyle(color: Colors.white, fontSize: 12),
              controller: accountController,
              keyboardType: TextInputType.number,
              
              decoration:  InputDecoration(
                border: OutlineInputBorder( borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Colors.white, width: 2),),focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(12)),
                
                hintText: 'Account Number',
                hintStyle: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Account Owner Name', style: TextStyle(fontSize: 12),),
            TextField(
              style: const TextStyle(color: Colors.white, fontSize: 12),
              controller: accountOwnerController,
              decoration:  InputDecoration(
                border: OutlineInputBorder( borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(color: Colors.white, width: 2),),
                      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(12)),
                hintText: 'Account Owner Name',
                 hintStyle: const TextStyle(color: Colors.white,fontSize: 12),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Select Bank',style: TextStyle(color: Colors.white, fontSize: 12),),
            
            DropdownButton<String>(
              value: selectedBank.isEmpty ? null : selectedBank,
              dropdownColor: buttonColor,
              hint: const Text('Choose a bank',style: TextStyle(color:Colors.white , fontSize: 12),),
              borderRadius: BorderRadius.circular(20),
              items: ['Access Bank', 'Fidelity Bank','First Bank','GT Bank', 'Kuda Mfb', 'Moniepoint'].map((String bank) {
                return DropdownMenuItem<String>(
                  
                  value: bank,
                  child: Text(bank, style: TextStyle(fontSize: 12, color: Colors.white),),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedBank = value ?? '';
                  bankName = value ?? ''; // Mock bank name
                });
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Bank Name: $bankName',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color:Colors.white ,),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor, // Dark card color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
              onPressed: () {
                // Show success dialog with account owner's name
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: buttonColor,
                      title: const Text('Transfer Successful', style: TextStyle(color:Colors.white , fontSize: 12),),
                      content: Text(
                          'You have sent ₦${widget.amount} to ${accountOwnerController.text} at $bankName.',style: const TextStyle(color:Colors.white, fontSize: 12),),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child:  Text('OK',style: TextStyle(color:buttonColor, fontSize: 12 ),),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Transfer', style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
