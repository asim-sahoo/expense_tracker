import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(
    this.isDarkMode, {
    super.key,
    required this.onAddExpense,
  });

  final void Function(ExpenseModel expense) onAddExpense;
  final bool isDarkMode;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  DateTime? _selectedDate = DateTime.now();
  Category _selectedCategory = Category.food;
  CategoryPay _selectedCategoryPay = CategoryPay.cash;
  int _categorySelectedIndex = -1;
  int _paySelectedIndex = -1;

  final FocusNode _amountFocusNode = FocusNode();

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null ||
        _categorySelectedIndex == -1 ||
        _paySelectedIndex == -1) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please enter valid title, amount, date, category and payment mode'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('Okay'))
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(
      ExpenseModel(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategory,
          categoryPay: _selectedCategoryPay),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 25, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 6.5,
              ),
              Text(
                'Expenses',
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w900,
                  fontSize: 25,
                  color: widget.isDarkMode
                      ? const Color.fromARGB(255, 215, 215, 215)
                      : Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 19),
          Card(
            color: widget.isDarkMode
                ? const Color.fromARGB(255, 49, 49, 49)
                : Colors.white,
            elevation: 0.3,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              child: EasyDateTimeLine(
                initialDate: DateTime.now(),
                onDateChange: (DateTime selectedDate) {
                  setState(() {
                    _selectedDate = selectedDate;
                  });
                },
                disabledDates: getDisabledDates(),
                headerProps: EasyHeaderProps(
                  padding: const EdgeInsets.only(),
                  monthPickerType: MonthPickerType.switcher,
                  dateFormatter: const DateFormatter.custom('dd MMM, yyyy'),
                  selectedDateStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: GoogleFonts.lato().fontFamily,
                    color: widget.isDarkMode
                        ? const Color.fromARGB(255, 210, 210, 210)
                        : const Color.fromARGB(255, 0, 0, 0),
                  ),
                  monthStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: widget.isDarkMode
                          ? const Color.fromARGB(255, 210, 210, 210)
                          : const Color.fromARGB(255, 0, 0, 0),
                      fontFamily: GoogleFonts.lato().fontFamily),

                ),
                dayProps: EasyDayProps(
                  disabledDayStyle: DayStyle(
                    dayStrStyle: TextStyle(
                      fontSize: 12,
                      color: widget.isDarkMode
                          ?  const Color.fromARGB(255, 90, 90, 90)
                          : const Color.fromARGB(255, 216, 216, 216),
                      fontFamily: GoogleFonts.lato().fontFamily,
                    ),
                    dayNumStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      color: widget.isDarkMode
                          ? const Color.fromARGB(255, 90, 90, 90)
                          : const Color.fromARGB(255, 216, 216, 216),
                      fontFamily: GoogleFonts.lato().fontFamily,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: widget.isDarkMode ? const Color.fromARGB(255, 90, 90, 90) : const Color.fromARGB(255, 216, 216, 216),
                        width: 0.5,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      color: widget.isDarkMode ? const Color.fromARGB(255, 49, 49, 49) : const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  todayStyle: DayStyle(
                    dayStrStyle: TextStyle(
                      fontSize: 12,
                      color: widget.isDarkMode
                          ? const Color.fromARGB(255, 210, 210, 210)
                          : const Color.fromARGB(255, 0, 0, 0),
                      fontFamily: GoogleFonts.lato().fontFamily,
                    ),
                    dayNumStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: widget.isDarkMode
                          ? const Color.fromARGB(255, 210, 210, 210)
                          : const Color.fromARGB(255, 0, 0, 0),
                      fontFamily: GoogleFonts.lato().fontFamily,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 130, 153, 255),
                        width: 0.5,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      color: widget.isDarkMode
                          ? const Color.fromARGB(255, 49, 49, 49)
                          : const Color.fromARGB(255, 248, 248, 248),
                    ),
                  ),
                  height: 60,
                  width: 50,
                  dayStructure: DayStructure.dayStrDayNum,
                  inactiveDayStyle: DayStyle(
                    dayStrStyle: TextStyle(
                      fontSize: 12,
                      color: widget.isDarkMode
                          ? const Color.fromARGB(255, 210, 210, 210)
                          : const Color.fromARGB(255, 0, 0, 0),
                      fontFamily: GoogleFonts.lato().fontFamily,
                    ),
                    dayNumStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      color: widget.isDarkMode
                          ? const Color.fromARGB(255, 210, 210, 210)
                          : const Color.fromARGB(255, 0, 0, 0),
                      fontFamily: GoogleFonts.lato().fontFamily,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 142, 142, 142),
                        width: 0.5,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      color: widget.isDarkMode
                          ? const Color.fromARGB(255, 49, 49, 49)
                          : const Color.fromARGB(255, 248, 248, 248),
                    ),
                  ),
                  activeDayStyle: DayStyle(
                    dayStrStyle: TextStyle(
                      color: const Color.fromARGB(255, 50, 86, 239),
                      fontSize: 12,
                      fontFamily: GoogleFonts.lato().fontFamily,
                    ),
                    dayNumStyle: TextStyle(
                      color: const Color.fromARGB(255, 50, 86, 239),
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      fontFamily: GoogleFonts.lato().fontFamily,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 50, 86, 239),
                          width: 0.5,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        color: const Color.fromARGB(255, 210, 210, 210)),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 26,
          ),
          Row(
            children: [
              const SizedBox(width: 8),
              Text(
                'Expense Name',
                style: GoogleFonts.lato(
                  color: widget.isDarkMode
                      ? const Color.fromARGB(255, 210, 210, 210)
                      : const Color.fromARGB(255, 126, 126, 126),
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          TextField(
            decoration: InputDecoration(
              hintText: 'Title',
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 15,
                fontFamily: GoogleFonts.lato().fontFamily,
              ),
              filled: true,
              fillColor: widget.isDarkMode
                  ? const Color.fromARGB(255, 60, 60, 60)
                  : const Color.fromARGB(255, 248, 248, 248),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(
                    width: 0.2,
                    color: widget.isDarkMode
                        ? const Color.fromARGB(255, 184, 184, 184)
                        : const Color.fromARGB(255, 134, 156, 255)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(17)),
                borderSide: BorderSide(
                    width: 0.35,
                    color: widget.isDarkMode
                        ? const Color.fromARGB(255, 225, 225, 225)
                        : const Color.fromARGB(255, 50, 86, 239)),
              ),
            ),
            style: GoogleFonts.lato(
              color: widget.isDarkMode
                  ? const Color.fromARGB(255, 225, 225, 225)
                  : const Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.w400,
            ),
            cursorColor: widget.isDarkMode
                ? const Color.fromARGB(255, 191, 191, 191)
                : const Color.fromARGB(255, 0, 0, 0),
            cursorRadius: const Radius.circular(12),
            cursorWidth: 1,
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
                  color: widget.isDarkMode
                      ? const Color.fromARGB(255, 210, 210, 210)
                      : const Color.fromARGB(255, 126, 126, 126),
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          TextField(
            keyboardType: TextInputType.number,
            focusNode: _amountFocusNode,
            decoration: InputDecoration(
              prefixText: '\u{20B9} ',
              prefixStyle: TextStyle(
                color: Colors.grey,
                fontSize: 15,
                fontFamily: GoogleFonts.lato().fontFamily,
              ),
              hintText: _amountFocusNode.hasFocus ? '' : '\u{20B9} ',
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 15,
                fontFamily: GoogleFonts.lato().fontFamily,
              ),
              filled: true,
              fillColor: widget.isDarkMode
                  ? const Color.fromARGB(255, 60, 60, 60)
                  : const Color.fromARGB(255, 248, 248, 248),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(
                    width: 0.2,
                    color: widget.isDarkMode
                        ? const Color.fromARGB(255, 184, 184, 184)
                        : const Color.fromARGB(255, 134, 156, 255)),
              ),
              border: const OutlineInputBorder(
                gapPadding: 2,
                borderRadius: BorderRadius.all(Radius.circular(17)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(
                    width: 0.35,
                    color: widget.isDarkMode
                        ? const Color.fromARGB(255, 225, 225, 225)
                        : const Color.fromARGB(255, 50, 86, 239)),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            style: GoogleFonts.lato(
              color: widget.isDarkMode
                  ? const Color.fromARGB(255, 225, 225, 225)
                  : const Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.w400,
            ),
            cursorColor: widget.isDarkMode
                ? const Color.fromARGB(255, 191, 191, 191)
                : const Color.fromARGB(255, 0, 0, 0),
            cursorRadius: const Radius.circular(12),
            cursorWidth: 1,
            controller: _amountController,
            onChanged: (value) {
              if (value.isNotEmpty && value[0] == '\u{20B9}') {
                _amountController.value = _amountController.value.copyWith(
                  text: value.substring(1),
                  selection: TextSelection.collapsed(offset: value.length - 1),
                );
              }
            },
            onTap: () {
              setState(() {
                _amountFocusNode
                    .requestFocus(); // Set focus to the TextField when tapped
              });
            },
          ),
          const SizedBox(height: 26),
          Row(
            children: [
              const SizedBox(width: 8),
              Text(
                'Select a Category',
                style: GoogleFonts.lato(
                  color: widget.isDarkMode
                      ? const Color.fromARGB(255, 210, 210, 210)
                      : const Color.fromARGB(255, 126, 126, 126),
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
              _categoryIconList.length,
              (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_categorySelectedIndex == index) {
                        _categorySelectedIndex = -1;
                      } else {
                        _categorySelectedIndex = index;
                        _selectedCategory = getCategory(_iconNames[index]);
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: _categorySelectedIndex == index
                            ? _iconContainerColor[index]
                            : _iconContainerColor[index].withOpacity(0.2),
                        border: _categorySelectedIndex == index
                            ? Border.all(
                                color: const Color.fromARGB(255, 71, 172, 255),
                                width: 0.5)
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _categoryIconList[index],
                            size: 22,
                            color: _categoryIconColor[index],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 26),
          Row(
            children: [
              const SizedBox(width: 8),
              Text(
                'Select Payment Mode',
                style: GoogleFonts.lato(
                  color: widget.isDarkMode
                      ? const Color.fromARGB(255, 210, 210, 210)
                      : const Color.fromARGB(255, 126, 126, 126),
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
              _payIconList.length,
              (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_paySelectedIndex == index) {
                        _paySelectedIndex = -1; // Deselect if already selected
                      } else {
                        _paySelectedIndex = index;
                        _selectedCategoryPay = getCategoryPay(
                            _iconPayNames[index]); // Select the new icon
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: _paySelectedIndex == index
                            ? _payIconContainerColor[index]
                            : _payIconContainerColor[index].withOpacity(0.2),
                        border: _paySelectedIndex == index
                            ? Border.all(
                                color: const Color.fromARGB(255, 71, 172, 255),
                                width: 0.5)
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _payIconList[index],
                            size: 22,
                            color: _payIconColor[index],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: _submitExpenseData,
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: const Color.fromARGB(255, 50, 86, 239),
                foregroundColor: Colors.white),
            child: const Text('Add Expense'),
          )
        ],
      ),
    );
  }

  CategoryPay getCategoryPay(String name) {
    switch (name) {
      case 'Cash':
        return CategoryPay.cash;
      case 'Card':
        return CategoryPay.card;
      default:
        return CategoryPay.cash;
    }
  }

  Category getCategory(String name) {
    switch (name) {
      case 'Food':
        return Category.food;
      case 'Travel':
        return Category.travel;
      case 'Work':
        return Category.work;
      case 'Shopping':
        return Category.shopping;
      case 'Medical':
        return Category.medical;
      case 'Miscellaneous':
        return Category.miscellaneous;
      default:
        return Category.food;
    }
  }

  final List<IconData> _categoryIconList = [
    Icons.fastfood,
    Icons.flight,
    Icons.work,
    Icons.shopping_cart,
    Icons.local_hospital,
    Icons.category,
  ];

  final List<IconData> _payIconList = [
    Icons.money,
    Icons.credit_card,
  ];

  final List<String> _iconNames = [
    'Food',
    'Travel',
    'Work',
    'Shopping',
    'Medical',
    'Miscellaneous',
  ];

  final List<String> _iconPayNames = [
    'Cash',
    'Card',
  ];

  final List<Color> _categoryIconColor = [
    const Color.fromARGB(255, 250, 153, 153),
    const Color.fromARGB(255, 97, 230, 125),
    const Color.fromARGB(255, 158, 158, 255),
    const Color.fromARGB(255, 255, 136, 255),
    const Color.fromARGB(255, 253, 197, 13),
    const Color.fromARGB(255, 47, 155, 255),
  ];

  final List<Color> _payIconColor = [
    const Color.fromARGB(255, 97, 230, 125),
    const Color.fromARGB(255, 47, 155, 255),
  ];

  final List<Color> _payIconContainerColor = [
    const Color.fromARGB(255, 221, 255, 221),
    const Color.fromARGB(255, 218, 255, 255),
  ];

  final List<Color> _iconContainerColor = [
    const Color.fromARGB(255, 255, 216, 216),
    const Color.fromARGB(255, 221, 255, 221),
    const Color.fromARGB(255, 230, 230, 255),
    const Color.fromARGB(255, 255, 227, 255),
    const Color.fromARGB(255, 255, 241, 194),
    const Color.fromARGB(255, 218, 255, 255),
  ];

  List<DateTime> getDisabledDates() {
    List<DateTime> disabledDates = [];

    // Get the current date
    DateTime currentDate = DateTime.now();

    // Get the last date of the current month
    DateTime lastDayOfMonth =
        DateTime(currentDate.year, currentDate.month + 1, 0);

    // Loop through each day in the current month
    for (int j = 1; j <= lastDayOfMonth.day; j++) {
      DateTime date = DateTime(currentDate.year, currentDate.month, j);
      // Check if the date is in the future
      if (date.isAfter(currentDate)) {
        disabledDates.add(date);
      }
    }

    return disabledDates;
  }
}
