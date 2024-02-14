import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/widget/expense_list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final List<ExpenseModel> expenses;
  final void Function(ExpenseModel expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) {
      return const Center(
        child: Text(
          'No expenses to show',
          style: TextStyle(fontSize: 16),
        ),
      );
    } else {
      // Calculate total expense
      double totalExpense =
          expenses.fold(0, (prev, expense) => prev + expense.amount);

      // Map expenses by category
      Map<Category?, double> expensesByCategory = {};
      for (var expense in expenses) {
        expensesByCategory[expense.category] =
            (expensesByCategory[expense.category] ?? 0) + expense.amount;
      }

      // Bar chart data
      List<BarChartGroupData> barChartGroups =
          expensesByCategory.entries.map((entry) {
        return BarChartGroupData(
          x: expensesByCategory.keys.toList().indexOf(entry.key),
          barRods: [
            BarChartRodData(
              toY: entry.value,
              color: categoryIconColors[entry.key] ?? Colors.blue,
              width: 25,
            ),
          ],
          // showingTooltipIndicators: [0],
        );
      }).toList();

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(9),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: AspectRatio(
                  aspectRatio: 2,
                  child: BarChart(
                    BarChartData(
                      gridData: const FlGridData(show: false),
                      groupsSpace: 20,
                      alignment: BarChartAlignment.spaceAround,
                      titlesData: FlTitlesData(
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                          ),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                          ),
                        ),
                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              final categoryIndex = value.toInt();
                              if (categoryIndex >= 0 &&
                                  categoryIndex <
                                      expensesByCategory.keys.length) {
                                final category = expensesByCategory.keys
                                    .toList()[categoryIndex];
                                final icon = categoryIcons[category];
                                if (icon != null) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Icon(
                                      icon,
                                      size: 16,
                                      color: categoryIconColors[category] ??
                                          Colors.blue,
                                      
                                    ),
                                  );
                                }
                              }
                              // Return an empty container if there's no icon for the category or out of bounds
                              return const SizedBox();
                            },
                          ),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      barGroups: barChartGroups,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(width: 15),
              Text(
                'Total Expense:',
                style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                '\u{20B9}${totalExpense.toStringAsFixed(2)}',
                style: GoogleFonts.lato(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (ctx, index) => const Divider(
                height: 10,
                thickness: 0.14,
                color: Colors.grey,
                endIndent: 46,
                indent: 46,
              ),
              itemCount: expenses.length,
              itemBuilder: (ctx, index) => Slidable(
                key: UniqueKey(),
                endActionPane: ActionPane(
                  extentRatio: 0.25,
                  motion: const ScrollMotion(),
                  dismissible: DismissiblePane(onDismissed: () {
                    onRemoveExpense(expenses[index]);
                  }),
                  children: [
                    SlidableAction(
                      padding: EdgeInsets.zero,
                      onPressed: (context) => onRemoveExpense(expenses[index]),
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: ExpenseItem(expenses[index]),
              ),
            ),
          ),
        ],
      );
    }
  }
}
