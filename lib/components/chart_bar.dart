import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  const ChartBar({
    Key key,
    this.label,
    this.value,
    this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, contraints) {
        return Column(
          children: [
            Container(
              height: contraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  '${value.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: value > 0 ? Theme.of(context).accentColor : null,
                    fontWeight: value > 0 ? FontWeight.bold : null,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: contraints.maxHeight * 0.05,
            ),
            Container(
              height: contraints.maxHeight * 0.6,
              width: contraints.maxWidth * 0.25,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      color: Color.fromRGBO(220, 200, 220, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: contraints.maxHeight * 0.05,
            ),
            Container(
              height: contraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: value > 0 ? FontWeight.bold : null,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
