import 'package:TeraFlex/pages/classes/alerts.dart';
import 'package:TeraFlex/pages/classes/styles.dart';
import 'package:TeraFlex/pages/designs/appBar.dart';
import 'package:TeraFlex/pages/designs/cardButton.dart';
import 'package:TeraFlex/pages/interfaces/tasksInterface.dart';
import 'package:TeraFlex/pages/services/taskService.dart';
import 'package:flutter/material.dart';

bool selected = false;
List<Task> listTasks = [];
DateTime now = DateTime.now();
DateTime newDateTime = now.subtract(Duration(hours: 5, minutes: 0));

class tasksList extends StatefulWidget {
  const tasksList({super.key});

  @override
  State<tasksList> createState() => _tasksListState();
}

class _tasksListState extends State<tasksList> {
  @override
  void initState() {
    super.initState();
    CustomEasyLoading.instance.showLoading('Cargando tareas...');
    listTasks.clear();
    getTaskService(selected).then((value) {
      CustomEasyLoading.instance.dismiss();
      if (value.data != null) {
        setState(() {
          listTasks = value.data!;
        });
      } else {
        CustomEasyLoading.instance.showError(value.message!);
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    listTasks.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          listTasks.clear();
          Navigator.pop(context);
          return true;
        },
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: AppBarCustom(
                tittle: 'Tareas',
                subTittle: 'Atrás',
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icons.arrow_back_rounded,
              )),
          body: Container(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
            margin: EdgeInsets.only(top: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Filtrar tareas por:',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF2F2F2F),
                    fontFamily: 'Nunito'),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButton(
                  onChanged: (value) {
                    setState(() {
                      selected = value!;
                      listTasks.clear();
                      CustomEasyLoading.instance
                          .showLoading('Cargando tareas...');
                      getTaskService(selected).then((value) {
                        CustomEasyLoading.instance.dismiss();
                        setState(() {
                          listTasks = value.data!;
                        });
                      }).catchError((e) {
                        CustomEasyLoading.instance.showError(e.toString());
                      });
                    });
                  },
                  value: selected,
                  items: [
                    DropdownMenuItem(child: Text('Pendientes'), value: false),
                    DropdownMenuItem(child: Text('Completadas'), value: true)
                  ],
                  isExpanded: true,
                  icon: Icon(
                    Icons.arrow_drop_down_rounded,
                    color: Colors.black,
                  ),
                  iconSize: 50,
                  hint: Text(
                    'Selecciona una opción',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  underline: Container(),
                ),
              ),
              spaced(25, 0),
              taskList()
            ]),
          ),
        ),
      ),
    );
  }
}

class taskList extends StatelessWidget {
  const taskList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: showTasks(context),
          ),
        ),
      ),
    );
  }

  List<Widget> showTasks(BuildContext context) {
    if (!selected) {
      return [
        for (var task in listTasks)
          if (newDateTime.day <= task.dueDate.day &&
              newDateTime.month <= task.dueDate.month &&
              newDateTime.year <= task.dueDate.year)
            taskListGeneral(task: task),
        spaced(25, 0),
      ];
    } else {
      return [
        for (var task in listTasks) taskListGeneral(task: task),
        spaced(25, 0),
      ];
    }
  }
}

class taskListGeneral extends StatelessWidget {
  const taskListGeneral({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: cardButtonTaskWidget(
          icon: Icons.format_list_bulleted_rounded,
          tittle: task.task.title,
          subtitle: ' ${task.task.estimatedTime} minutos',
          onPressed: () {
            CustomEasyLoading.instance.showLoading("Cargando tarea...");
            Navigator.pushNamed(context, 'detail-task', arguments: {
              'idAssigment': task.id,
            });
          }),
    );
  }
}
