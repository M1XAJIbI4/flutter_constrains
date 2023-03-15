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
          child: Container(
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
      "Вы можете предположить, что Container должен быть между 70 и 150, но вы ошибаетесь "
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
  final String explanation = "Если убрать FittedBox, "
      "Text получит максимальную ширину от экрана "
      "и перенесёт строку, если она не влезает";

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
      "FittedBox может ограничить только виджет, который ОГРАНИЧЕН (имеет не бесконечную ширину и высоту)."
      "\n\n"
      "Иначе рендер не произойдёт и в консоли будет ошибка";

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
      "Экран заставляет Row быть размером с экран."
      "\n\n"
      "Как и UnconstrainedBox, Row не будет накладывать никаких ограничений для дочерних элементов"
      "и позволит им иметь размер, какой они хотят"
      "\n\n"
      "Row поместит их рядом, и любое дополнительное пространство останется пустым";

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
      "Т.к. строка не накладывает ограничения на дочерних элементов "
      "вполне возможно, что дочерние элементы будут слишком большими, "
      "чтобы соответствовать доступной ширине строки"
      "\n\n"
      "Тогда (как и в случае с UnconstrainedBox) будет отображаться \"overflow warning\".";

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
      "Когда дочерний элемент Row заключен в Expanded, Row больше не позволяет этому дочернему элементу определять свою собственную ширину."
      "\n\n"
      "Вместо этого он будет определять свою ширину в соответствии с другими дочерними элементами, и только тогда Expanded заставит дочерний элемент иметь свою ширину"
      "\n\n";

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
      "Если все дочерние элементы Row заключены в Expanded, каждый Expanded будет иметь размер пропорционально его параметру flex "
      "и Expanded заставит свой дочерний элемент иметь свою ширину."
      "\n\n"
      "Другими словами, Expanded игнорирует предпочтительную ширину своих дочерних элементов";

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
      "Разница между Flexible и Expanded в том, что"
      "Flexible позволяет своему дочернему элементу быть МЕНЬШЕ, чем ширина Flexible "
      "в то время как Expanded заставляет свои дочерние элементы быть своей ширины";
     
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

/////////////////////////////////////////////////
class Example28 extends Example {
  final code = '';
  final explanation = '';

  final _containerHeight = 60.0;

  @override 
  Widget build(BuildContext context) {
   return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: _getChildren(),
    );
  }

final _colors = [Colors.white, Colors.blue, Colors.red];

List<Widget> _getChildren() {
  return _colors.map(
    (e) => Container(
      margin: const EdgeInsets.all(2),
      width: double.infinity,
      height: _containerHeight,
      color: e,
    ))
  .toList();
 }

















//  Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constrains) {
//         return SingleChildScrollView(
//           child: ConstrainedBox(
//             constraints: BoxConstraints(minHeight: constrains.maxHeight),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               mainAxisSize: MainAxisSize.min,
//               children: _getChildren(),
//             ),
//           ),
//         );
//       }
//     );
}
