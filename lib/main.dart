import 'package:flutter/material.dart';

void main() => runApp(HomePage());

const red = Colors.red;
const green = Colors.green;
const blue = Colors.blue;
const big = const TextStyle(fontSize: 30);

//////////////////////////////////////////////////

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => FlutterLayoutArticle(<Example>[
        Example1(),
        Example2(),
        Example3(),
        Example4(),
        Example5(),
        Example6(),
        Example7(),
        Example8(),
        Example9(),
        Example10(),
        Example11(),
        Example12(),
        Example13(),
        Example14(),
        Example15(),
        Example16(),
        Example17(),
        Example18(),
        Example19(),
        Example20(),
        Example21(),
        Example22(),
        Example23(),
        Example24(),
        Example25(),
        Example26(),
        Example27(),
        Example28(),
        Example29(),
      ]);
}

//////////////////////////////////////////////////

abstract class Example extends StatelessWidget {
  String get code;

  String get explanation;
}

//////////////////////////////////////////////////

class FlutterLayoutArticle extends StatefulWidget {
  final List<Example> examples;

  FlutterLayoutArticle(this.examples);

  @override
  _FlutterLayoutArticleState createState() => _FlutterLayoutArticleState();
}

//////////////////////////////////////////////////

class _FlutterLayoutArticleState extends State<FlutterLayoutArticle> {
  late int count;
  late Widget example;
  late String code;
  late String explanation;

  @override
  void initState() {
    count = 1;
    code = Example1().code;
    explanation = Example1().explanation;

    super.initState();
  }

  @override
  void didUpdateWidget(FlutterLayoutArticle oldWidget) {
    super.didUpdateWidget(oldWidget);
    var example = widget.examples[count - 1];
    code = example.code;
    explanation = example.explanation;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Layout Article',
      home: SafeArea(
        child: Material(
          color: Colors.black,
          child: FittedBox(
            child: Container(
              width: 400,
              height: 670,
              color: Color(0xFFCCCCCC),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ConstrainedBox(
                        constraints: BoxConstraints.tightFor(
                            width: double.infinity, height: double.infinity),
                        child: widget.examples[count - 1]),
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    color: Colors.black,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (int i = 0; i < widget.examples.length; i++)
                            Container(
                              width: 58,
                              padding:
                                  const EdgeInsets.only(left: 4.0, right: 4.0),
                              child: button(i + 1),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          key: ValueKey(count),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                Center(child: Text(code)),
                                SizedBox(height: 15),
                                Text(
                                  explanation,
                                  style: TextStyle(
                                      color: Colors.blue[900],
                                      fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      height: 273,
                      color: Colors.grey[200]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget button(int exampleNumber) => Button(
        key: ValueKey("button$exampleNumber"),
        isSelected: this.count == exampleNumber,
        exampleNumber: exampleNumber,
        onPressed: () {
          showExample(
            exampleNumber,
            widget.examples[exampleNumber - 1].code,
            widget.examples[exampleNumber - 1].explanation,
          );
        },
      );

  void showExample(int exampleNumber, String code, String explanation) =>
      setState(() {
        this.count = exampleNumber;
        this.code = code;
        this.explanation = explanation;
      });
}

//////////////////////////////////////////////////

class Button extends StatelessWidget {
  final Key key;
  final bool isSelected;
  final int exampleNumber;
  final VoidCallback onPressed;

  Button({
    required this.key,
    required this.isSelected,
    required this.exampleNumber,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        color: isSelected ? Colors.grey : Colors.grey[800],
        child: Text(exampleNumber.toString(),
            style: TextStyle(color: Colors.white)),
        onPressed: () {
          Scrollable.ensureVisible(
            context,
            duration: Duration(milliseconds: 350),
            curve: Curves.easeOut,
            alignment: 0.5,
          );
          onPressed();
        });
  }
}
//////////////////////////////////////////////////

class Example1 extends Example {
  final String code = "Container(color: red)";
  final String explanation = "Экран является родителем контейнера. "
      "\n\n"  
      "Это застаялет контейнер быть точно размера экрана"
      "\n\n";

  @override
  Widget build(BuildContext context) {
    return Container(color: red);
  }
}

//////////////////////////////////////////////////

class Example2 extends Example {
  final String code = "Container(width: 100, height: 100, color: red)";
  final String explanation =
      "Контейнер хочет быть 100 х 100, но не может,"
      "потому что экран заставляет его быть такого размера";

  @override
  Widget build(BuildContext context) {
    return Container(width: 100, height: 100, color: red);
  }
}

//////////////////////////////////////////////////

class Example3 extends Example {
  final String code = "Center(\n"
      "   child: Container(width: 100, height: 100, color: red))";
  final String explanation =
      "Экран говорит Center быть размеров экрана"
      "\n\n"
      "Center заполняет все пространство."
      "\n\n"
      "Center говорит Container: 'Можешь быть каким хочешь, но не более размеров экрана'"
      "\n\n"
      "Now the Container can indeed be 100x100.";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(width: 100, height: 100, color: red),
    );
  }
}

//////////////////////////////////////////////////

class Example4 extends Example {
  final String code = "Align(\n"
      "   alignment: Alignment.bottomRight,\n"
      "   child: Container(width: 100, height: 100, color: red))";
  final String explanation =
      "Это отличается от предыдущего примера, что тут используется Align вместо Center"
      "\n\n"
      "Align также сообщает Container, что он может быть любого размера, который он хочет, но если есть пустое место, он не будет центрировать Container,"
      "но вместо этого выровняет его по нижнему правому краю доступного пространства.";

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(width: 100, height: 100, color: red),
    );
  }
}

//////////////////////////////////////////////////

class Example5 extends Example {
  final String code = "Center(\n"
      "   child: Container(\n"
      "              color: red,\n"
      "              width: double.infinity,\n"
      "              height: double.infinity))";
  final String explanation =
      "Экран говорит Center быть размеров экрана"
      "\n\n"
      "Center заполняет экран"
      "\n\n"
      "Center говорит Container: 'Можешь быть каким хочешь, но не более размеров экрана'"
      "\n\n"
      "Container хочет быть бесконечным, но поскольку пришли конкретные ограничения, то он просто заполняет экран";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: double.infinity, height: double.infinity, color: red),
    );
  }
}

//////////////////////////////////////////////////

class Example6 extends Example {
  final String code = "Center(child: Container(color: red))";
  final String explanation =
      "Экран говорит Center быть размерами как экран"
      "\n\n"
      "Center заполняет весь экран"
      "\n\n"
      "Center говорит Container: 'Будь какой-хочешь, но не больше экрана'"
      "\n\n"
      "Поскольку у Container нет дочерних элементов и нет фиксированного размера, он решает быть как можно больше"
      "\n\n"
      "Это не следует из общего правила (но не противоречит им). Просто у него такая реализация";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(color: red),
    );
  }
}

//////////////////////////////////////////////////

class Example7 extends Example {
  final String code = "Center(\n"
      "   child: Container(color: red\n"
      "      child: Container(color: green, width: 30, height: 30)))";
  final String explanation =
      "Экран говорит Center быть размерами как экран"
      "\n\n"
      "Center заполняет весь экран"
      "\n\n"
      "Center говорит красному Container: 'Будь какой хочешь, но не более экрана' "
      "\n\n"
      " Т.к. красный контейнер не имеет определённого размера, он рещает быть размером с ребёнка"
      "\n\n"
      "Красный говорит зелёному: 'Будь какой хочешь, но не более экрана' "
      "\n\n"
      "Зелёный хочет быть размеров 30х30"
      "\n\n"
      "Красный принимает размеры зеленого (у него такая реализация)";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: red,
        child: Container(color: green, width: 30, height: 30),
      ),
    );
  }
}

//////////////////////////////////////////////////

class Example8 extends Example {
  final String code = "Center(\n"
      "   child: Container(color: red\n"
      "      padding: const EdgeInsets.all(20.0),\n"
      "      child: Container(color: green, width: 30, height: 30)))";
  final String explanation =
      "Красный Container изменит свой размер до размеров своих детей, но будет учитывать свои отступы"
      "30х20 + отступ 20х20";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        color: red,
        child: Container(color: green, width: 30, height: 30),
      ),
    );
  }
}

//////////////////////////////////////////////////

class Example9 extends Example {
  final String code = "ConstrainedBox(\n"
      "   constraints: BoxConstraints(\n"
      "              minWidth: 70, minHeight: 70,\n"
      "              maxWidth: 150, maxHeight: 150),\n"
      "      child: Container(color: red, width: 10, height: 10)))";
  final String explanation =
      "Вы можете предположить, что Container должен быть между 70 и 150, но вы ошибайтесь"
      "ConstrainedBox накладывает только ДОПОЛНИТЕЛЬНЫЕ ограничения, чем те которые он получил от своего родителя";


  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          minWidth: 70, minHeight: 70, maxWidth: 150, maxHeight: 150),
      child: Container(color: red, width: 10, height: 10),
    );
  }
}

//////////////////////////////////////////////////

class Example10 extends Example {
  final String code = "Center(\n"
      "   child: ConstrainedBox(\n"
      "      constraints: BoxConstraints(\n"
      "                 minWidth: 70, minHeight: 70,\n"
      "                 maxWidth: 150, maxHeight: 150),\n"
      "        child: Container(color: red, width: 10, height: 10))))";
  final String explanation =
      "Теперь, Center позволяет ConstrainedBox быть любого размера до размера экрана"
      "\n\n"
      "ConstrainedBox наложит дополнительные ограничения из своих ограничений"
      "\n\n"
      "Container должен быть от 70 до 150. Он хочет быть 10, но будет 70 (minWidth и minHeight).";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: 70, minHeight: 70, maxWidth: 150, maxHeight: 150),
        child: Container(color: red, width: 10, height: 10),
      ),
    );
  }
}

//////////////////////////////////////////////////

class Example11 extends Example {
  final String code = "Center(\n"
      "   child: ConstrainedBox(\n"
      "      constraints: BoxConstraints(\n"
      "                 minWidth: 70, minHeight: 70,\n"
      "                 maxWidth: 150, maxHeight: 150),\n"
      "        child: Container(color: red, width: 1000, height: 1000))))";
  final String explanation =
      "Теперь, Center позволяет ConstrainedBox быть любого размера до размера экрана"
      "\n\n"
      "ConstrainedBox наложит дополнительные ограничения из своих ограничений"
      "\n\n"
      "Container должен быть от 70 до 150. Он хочеть быть 1000, но будет иметь размеры 150 (maxWidth и maxHeight).";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: 70, minHeight: 70, maxWidth: 150, maxHeight: 150),
        child: Container(color: red, width: 1000, height: 1000),
      ),
    );
  }
}

//////////////////////////////////////////////////

class Example12 extends Example {
  final String code = "Center(\n"
      "   child: ConstrainedBox(\n"
      "      constraints: BoxConstraints(\n"
      "                 minWidth: 70, minHeight: 70,\n"
      "                 maxWidth: 150, maxHeight: 150),\n"
      "        child: Container(color: red, width: 100, height: 100))))";
  final String explanation =
      "Теперь, Center позволяет ConstrainedBox быть любого размера до размера экрана"
      "\n\n"
      "ConstrainedBox наложит дополнительные ограничения из своих ограничений"
      "\n\n"
      "Container должен быть от 70 до 150. Он хочет быть 100 на 100 и будет таких размеров";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: 70, minHeight: 70, maxWidth: 150, maxHeight: 150),
        child: Container(color: red, width: 100, height: 100),
      ),
    );
  }
}

//////////////////////////////////////////////////

class Example13 extends Example {
  final String code = "UnconstrainedBox(\n"
      "   child: Container(color: red, width: 20, height: 50));";
  final String explanation =
      "Экран говорит UnconstrainedBox быть точно размеров экрана"
      "\n\n"
      "UnconstrainedBox позволяет Container иметь размер, какой он хочет.";

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(color: red, width: 20, height: 50),
    );
  }
}

//////////////////////////////////////////////////

class Example14 extends Example {
  final String code = "UnconstrainedBox(\n"
      "   child: Container(color: red, width: 4000, height: 50));";
  final String explanation =
      "Экран говорит UnconstrainedBox быть точно размеров экрана, "
      "и UnconstrainedBox позволяет Container иметь размер, какой он хочет."
      "\n\n"
      "Возникает ошибка о переполнени из-за больших размеров Container";

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(color: red, width: 4000, height: 50),
    );
  }
}

//////////////////////////////////////////////////

class Example15 extends Example {
  final String code = "OverflowBox(\n"
      "   child: Container(color: red, width: 4000, height: 50));";
  final String explanation =
      "Экран говорит Overflow быть точно размеров экрана, "
      "и OverflowBox позволяет Container иметь размер, какой он хочет."
      "\n\n"
      "OverflowBox похож на UnconstrainedBox, и разница в том, что он не показывает ошибок"
      "\n\n"
      "OverflowBox просто показывает то что может, без ошибок";

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      minWidth: 0.0,
      minHeight: 0.0,
      maxWidth: double.infinity,
      maxHeight: double.infinity,
      child: Container(color: red, width: 4000, height: 50),
    );
  }
}

//////////////////////////////////////////////////

class Example16 extends Example {
  final String code = "UnconstrainedBox(\n"
      "   child: Container(color: Colors.red, width: double.infinity, height: 100));";
  final String explanation =
      "Это ничего не отобразит и будет ошибка в консоли"
      "\n\n"
      "UnconstrainedBox разрешает ребёнку быть, каким он хочет,"
      "однако Container хочет быть бесконечного размера"
      "\n\n"
      "Flutter не может отобразить бесконечные размеры, поэтому будет ошибка - "
      "'BoxConstraints forces an infinite width.'";

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(color: Colors.red, width: double.infinity, height: 100),
    );
  }
}

//////////////////////////////////////////////////

class Example17 extends Example {
  final String code = "UnconstrainedBox(\n"
      "   child: LimitedBox(maxWidth: 100,\n"
      "      child: Container(color: Colors.red,\n"
      "                       width: double.infinity, height: 100));";
  final String explanation = "Здесь ошибки не будет, "
      "потому что когда LimitedBox получает бесконечный размер от UnconstrainedBox, "
      "он передаст своему ребенку размер 100"
      "\n\n"
      "Но если заменить UnconstrainedBox на Center, то LimitedBox больше работать не будет, т.к. "
      "он работает только в условиях бесконечных ограничений";
      
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: LimitedBox(
        maxWidth: 100,
        child:
            Container(color: Colors.red, width: double.infinity, height: 100),
      ),
    );
  }
}

//////////////////////////////////////////////////

class Example18 extends Example {
  final String code = "FittedBox(\n"
      "   child: Text('Some Example Text.'));";
  final String explanation =
      "Экран говорит FittedBox быть точно размеров экрана."
      "\n\n"
      "Текст будет иметь некоторую свою естественную ширину"
      "\n\n"
      "FittedBox позволит Text иметь любой размер, который он хочет, "
      "но после того как Text сообщит свой размер FittedBox,"
      "FittedBox будет масштабировать его до своей ширины";

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text("Some Example Text."),
    );
  }
}

//////////////////////////////////////////////////

class Example19 extends Example {
  final String code = "Center(\n"
      "   child: FittedBox(\n"
      "      child: Text('Some Example Text.')));";
  final String explanation =
      "Но что будет, если FittedBox обернуть в Center? "
      "Center позволит FittedBox иметь любой размер до размеров экрана"
      "\n\n"
      "FittedBox позволит Text иметь любой размер, какой он хочет и примет его размеры"
      "\n\n"
      "Поскольку и FittedBox и Text имеют одинаковый размер, масштабирования не произойдёт";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        child: Text("Some Example Text."),
      ),
    );
  }
}

////////////////////////////////////////////////////

class Example20 extends Example {
  final String code = "Center(\n"
      "   child: FittedBox(\n"
      "      child: Text('…')));";
  final String explanation =
      "Но что произойдёт, еслли Text слишком велик для экрана"
      "\n\n"
      "FittedBox попытается подстроиться под размер текста, но он не может быть больше экрана"
      "Затем он примет размер экрана и изменит размер текста, чтобы он тоже соотвествовал размеру экрана";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        child: Text(
            "This is some very very very large text that is too big to fit a regular screen in a single line."),
      ),
    );
  }
}

//////////////////////////////////////////////////

class Example21 extends Example {
  final String code = "Center(\n"
      "   child: Text('…'));";
  final String explanation = "If, however, we remove the FittedBox, "
      "the Text will get its maximum width from the screen, "
      "and will break the line so that it fits the screen.";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
          "This is some very very very large text that is too big to fit a regular screen in a single line."),
    );
  }
}

//////////////////////////////////////////////////

class Example22 extends Example {
  final String code = "FittedBox(\n"
      "   child: Container(\n"
      "      height: 20.0, width: double.infinity));";
  final String explanation =
      "Note FittedBox can only scale a widget that is BOUNDED (has non infinite width and height)."
      "\n\n"
      "Otherwise, it won't render anything, and you will get an error in the console.";

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        height: 20.0,
        width: double.infinity,
        color: Colors.red,
      ),
    );
  }
}

//////////////////////////////////////////////////

class Example23 extends Example {
  final String code = "Row(children:[\n"
      "   Container(color: red, child: Text('Hello!'))\n"
      "   Container(color: green, child: Text('Goodbye!'))]";
  final String explanation =
      "The screen forces the Row to be exactly the same size of the screen."
      "\n\n"
      "Just like an UnconstrainedBox, the Row won't impose any constraints to its children, "
      "and will instead let them have any size they want."
      "\n\n"
      "The Row will then put them side by side, and any extra space will remain empty.";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(color: red, child: Text("Hello!", style: big)),
        Container(color: green, child: Text("Goodbye!", style: big)),
      ],
    );
  }
}

//////////////////////////////////////////////////

class Example24 extends Example {
  final String code = "Row(children:[\n"
      "   Container(color: red, child: Text('…'))\n"
      "   Container(color: green, child: Text('Goodbye!'))]";
  final String explanation =
      "Since the Row won't impose any constraints to its children, "
      "it's quite possible that the children will be too big to fit the available Row width."
      "\n\n"
      "In this case, just like an UnconstrainedBox, the Row will display the \"overflow warning\".";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            color: red,
            child: Text("This is a very long text that won't fit the line.",
                style: big)),
        Container(color: green, child: Text("Goodbye!", style: big)),
      ],
    );
  }
}

//////////////////////////////////////////////////

class Example25 extends Example {
  final String code = "Row(children:[\n"
      "   Expanded(\n"
      "       child: Container(color: red, child: Text('…')))\n"
      "   Container(color: green, child: Text('Goodbye!'))]";
  final String explanation =
      "When a Row child is wrapped in an Expanded widget, the Row will not let this child define its own width anymore."
      "\n\n"
      "Instead, it will define the Expanded width according to the other children, and only then the Expanded widget will force the original child to have the Expanded's width."
      "\n\n"
      "In other words, once you use Expanded, the original child's width becomes irrelevant, and will be ignored.";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Center(
          child: Container(
              color: red,
              child: Text("This is a very long text that won't fit the line.",
                  style: big)),
        )),
        Container(color: green, child: Text("Goodbye!", style: big)),
      ],
    );
  }
}

//////////////////////////////////////////////////

class Example26 extends Example {
  final String code = "Row(children:[\n"
      "   Expanded(\n"
      "       child: Container(color: red, child: Text('…')))\n"
      "   Expanded(\n"
      "       child: Container(color: green, child: Text('Goodbye!'))]";
  final String explanation =
      "If all Row children are wrapped in Expanded widgets, each Expanded will have a size proportional to its flex parameter, "
      "and only then each Expanded widget will force their child to have the Expanded's width."
      "\n\n"
      "In other words, the Expanded ignores their children preferred width.";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
                color: red,
                child: Text("This is a very long text that won't fit the line.",
                    style: big))),
        Expanded(
            child:
                Container(color: green, child: Text("Goodbye!", style: big))),
      ],
    );
  }
}

//////////////////////////////////////////////////

class Example27 extends Example {
  final String code = "Row(children:[\n"
      "   Flexible(\n"
      "       child: Container(color: red, child: Text('…')))\n"
      "   Flexible(\n"
      "       child: Container(color: green, child: Text('Goodbye!'))]";
  final String explanation =
      "The only difference if you use Flexible instead of Expanded, "
      "is that Flexible will let its child be SMALLER than the Flexible width, "
      "while Expanded forces its child to have the same width of the Expanded."
      "\n\n"
      "But both Expanded and Flexible will ignore their children width when sizing themselves."
      "\n\n"
      "Note, this means it's IMPOSSIBLE to expand Row children proportionally to their sizes. "
      "The Row will either use the exact child's with, or ignore it completely when you use Expanded or Flexible.";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            child: Container(
                color: red,
                child: Text("This is a very long text that won't fit the line.",
                    style: big))),
        Flexible(
            child:
                Container(color: green, child: Text("Goodbye!", style: big))),
      ],
    );
  }
}

//////////////////////////////////////////////////

class Example28 extends Example {
  final String code = "Scaffold(\n"
      "   body: Container(color: blue,\n"
      "   child: Column(\n"
      "      children: [\n"
      "         Text('Hello!'),\n"
      "         Text('Goodbye!')])))";

  final String explanation =
      "The screen forces the Scaffold to be exactly the same size of the screen."
      "\n\n"
      "So the Scaffold fills the screen."
      "\n\n"
      "The Scaffold tells the Container it can be any size it wants, but not bigger than the screen."
      "\n\n"
      "Note: When a widget tells its child it can be smaller than a certain size, "
      "we say the widget supplies \"loose\" constraints to its child. More on that later.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: blue,
        child: Column(
          children: [
            Text('Hello!'),
            Text('Goodbye!'),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////

class Example29 extends Example {
  final String code = "Scaffold(\n"
      "   body: Container(color: blue,\n"
      "   child: SizedBox.expand(\n"
      "      child: Column(\n"
      "         children: [\n"
      "            Text('Hello!'),\n"
      "            Text('Goodbye!')]))))";

  final String explanation =
      "If we want the Scaffold's child to be exactly the same size as the Scaffold itself, "
      "we can wrap its child into a SizedBox.expand."
      "\n\n"
      "Note: When a widget tells its child it must be of a certain size, "
      "we say the widget supplies \"tight\" constraints to its child. More on that later.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          color: blue,
          child: Column(
            children: [
              Text('Hello!'),
              Text('Goodbye!'),
            ],
          ),
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////
