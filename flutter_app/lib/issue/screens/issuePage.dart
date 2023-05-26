import 'package:flutter/material.dart';
// import 'packa';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

class IssueRequest extends StatefulWidget {
  const IssueRequest({super.key});

  @override
  State<IssueRequest> createState() => _IssueRequestState();
}

class _IssueRequestState extends State<IssueRequest> {
  TextEditingController textarea = TextEditingController();
  String? selectedValue = "Car A";

  @override
  Widget build(BuildContext context) {
    //   List<DropdownMenuItem<String>> managers = <String>[
    //   "Manager A","Manager B","Manager C","Manger D"
    // ].map<DropdownMenuItem<String>>((String value) {
    //   return DropdownMenuItem<String>(
    //           value: value,
    //           child: Text(value,style:TextStyle(color:Colors.black),),
    //   );
    // }).toList();

    List<DropdownMenuItem<String>> cars = <String>[
      "Car A",
      "Car B",
      "Car C",
      "Car D"
    ].map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(
          value,
          style: TextStyle(color: Colors.black),
        ),
      );
    }).toList();

    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(children: [
            const Text("Choose a car: "),
            const SizedBox(
              width: 16,
            ),
            Container(
                child: Container(
              height: 32,
              padding: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade300,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  icon: Icon(Icons.keyboard_arrow_down_outlined),
                  iconSize: 32,
                  // style: const TextStyle(color: Colors.white),
                  // iconEnabledColor:Colors.black,
                  hint: const Text("Please choose car"),
                  items: cars,
                  value: selectedValue,
                  onChanged: (x) {
                    setState(() => {selectedValue = x});
                  },
                ),
              ),
            ))
          ]),
          const SizedBox(
            height: 16,
          ),
          TextField(
            controller: textarea,
            keyboardType: TextInputType.multiline,
            maxLines: 6,
            autocorrect: true,
            decoration: const InputDecoration(
              hintText: 'Enter the issue/request here...',
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.white70,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                borderSide: BorderSide(color: Colors.grey, width: 2),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 162, 213, 243)),
                  onPressed: () {},
                  child: const Text(
                    "Clear",
                    style: TextStyle(color: Colors.black),
                  )),
              const SizedBox(
                width: 16,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {},
                  child: const Text(
                    "Submit",
                  ))
            ],
          )
        ],
      ),
    ));
  }
}
