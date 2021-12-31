import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ios_calculator/model/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String result = '123456';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onHorizontalDragEnd: (details) => {_dragToDelete()},
              child: Text(
                result,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: result.length > 5 ? 60 : 100,
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: _buildButtonGrid(),
            )
          ],
        ),
      ),
    );
  }

  void _dragToDelete() {
    print('Delete last digit');
  }

  String previousNumber = "";
  String currentNumber = "";
  String selectedOperation = "";
  void _onButtonPressed(String buttonText) {
    setState(() {
      switch (buttonText) {
        case '÷':
        case 'x':
        case '-':
        case '+':
          if (previousNumber != '') {
            //calculate result
          } else {
            previousNumber = currentNumber;
          }
          currentNumber = '';
          selectedOperation = buttonText;
          break;
        case '+/-':
          currentNumber = "-$currentNumber";
          result = currentNumber;
          break;
        case '%':
          currentNumber = currentNumber / 100;
          break;
        default:
      }
    });
  }

  void _calculateResult() {}
  Widget _buildButtonGrid() {
    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.zero,
      crossAxisCount: 4,
      itemCount: buttons.length,
      itemBuilder: (context, index) {
        final button = buttons[index];
        return MaterialButton(
          padding: button.value == '0'
              ? EdgeInsets.only(right: 100)
              : EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(60),
            ),
          ),
          color: button.bgColor,
          onPressed: () {
            _onButtonPressed(button.value);
          },
          child: Text(
            button.value,
            style: TextStyle(
              color: button.fgColor,
              fontSize: 35,
            ),
          ),
        );
      },
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      staggeredTileBuilder: (index) =>
          StaggeredTile.count(buttons[index].value == '0' ? 2 : 1, 1),
    );
  }
}
