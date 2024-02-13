import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  _NewExpenseState createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final TextEditingController _titleController = TextEditingController();

  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 45, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Expenses',
            style: GoogleFonts.lato(
              fontWeight: FontWeight.bold,
              fontSize: 21,
            ),
          ),
          const SizedBox(height: 26),
          Row(
            children: [
              const SizedBox(width: 8),
              Text(
                'Expense Name',
                style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 131, 131, 131),
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Title',
              hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
              filled: true,
              fillColor: Color.fromARGB(255, 235, 235, 235),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(width: 1, color: Colors.transparent),
              ),
              border: OutlineInputBorder(
                gapPadding: 2,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(
                    width: 1, color: Color.fromARGB(255, 22, 131, 255)),
              ),
            ),
            style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.w400,
            ),
            cursorColor: const Color.fromARGB(255, 43, 96, 255),
            cursorRadius: const Radius.circular(12),
            cursorWidth: 1.5,
            controller: _titleController,
          ),
          const SizedBox(
            height: 26,
          ),
          Row(
            children: [
              const SizedBox(width: 8),
              Text(
                'Amount',
                style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 131, 131, 131),
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          TextField(
            decoration: const InputDecoration(
              hintText: '\u{20B9}',
              hintStyle: TextStyle(color: Colors.grey,fontSize: 15),
              filled: true,
              fillColor: Color.fromARGB(255, 235, 235, 235),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(width: 1, color: Colors.transparent),
              ),
              border: OutlineInputBorder(
                gapPadding: 2,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(
                    width: 1, color: Color.fromARGB(255, 22, 131, 255)),
              ),
            ),
            style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.w400,
            ),
            cursorColor: const Color.fromARGB(255, 43, 96, 255),
            cursorRadius: const Radius.circular(12),
            cursorWidth: 1.5,
            controller: _titleController,
          ),
          const SizedBox(height: 26),
          Row(
            children: [
              const SizedBox(width: 8),
              Text(
                'Select a Category',
                style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 131, 131, 131),
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          GridView.count(
            crossAxisCount: 6,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(
              _iconList.length,
              (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_selectedIndex == index) {
                        _selectedIndex = -1; // Deselect if already selected
                      } else {
                        _selectedIndex = index; // Select the new icon
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: _selectedIndex == index
                            ? _iconContainerColor[index]
                            : _iconContainerColor[index].withOpacity(0.2),
                        border: _selectedIndex == index
                            ? Border.all(
                                color: const Color.fromARGB(255, 71, 172, 255),
                                width: 1.2)
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _iconList[index],
                            size: 22,
                            color: _iconColor[index],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  final List<IconData> _iconList = [
    Icons.fastfood,
    Icons.flight,
    Icons.work,
    Icons.shopping_cart,
    Icons.local_hospital,
    Icons.category,
  ];

  final List<String> _iconNames = [
    'Food',
    'Travel',
    'Work',
    'Shopping',
    'Medical',
    'Miscellaneous',
  ];

  final List<Color> _iconColor = [
    const Color.fromARGB(255, 250, 153, 153),
    const Color.fromARGB(255, 139, 255, 139),
    const Color.fromARGB(255, 158, 158, 255),
    const Color.fromARGB(255, 255, 136, 255),
    const Color.fromARGB(255, 253, 197, 13),
    const Color.fromARGB(255, 37, 255, 255),
  ];

  final List<Color> _iconContainerColor = [
    const Color.fromARGB(255, 255, 216, 216),
    const Color.fromARGB(255, 221, 255, 221),
    const Color.fromARGB(255, 230, 230, 255),
    const Color.fromARGB(255, 255, 227, 255),
    const Color.fromARGB(255, 255, 241, 194),
    const Color.fromARGB(255, 218, 255, 255),
  ];
}
