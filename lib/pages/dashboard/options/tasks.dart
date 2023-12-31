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
          CustomEasyLoading.instance.dismiss();
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
            margin: EdgeInsetsDirectional.only(start: 15, end: 15, top: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  spaced(10, 5),
                  Text(
                    'Filtrar tareas por:',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2F2F2F),
                        fontFamily: 'Nunito'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsetsDirectional.symmetric(horizontal: 20),
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: backgroundColor,
                        border: Border.all(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton(
                      onChanged: (value) {
                        setState(() {
                          selected = value!;
                          tasksLoad();
                        });
                      },
                      value: selected,
                      items: [
                        DropdownMenuItem(
                            child: Text('Tareas pendientes'), value: false),
                        DropdownMenuItem(
                            child: Text('Tareas completadas'), value: true)
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
                  Expanded(
                      child: SingleChildScrollView(
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: showTasks(context),
                        )),
                  ))
                ]),
          ),
        ),
      ),
    );
  }

  void tasksLoad() {
    listTasks.clear();
    CustomEasyLoading.instance.showLoading('Cargando tareas...');
    getTaskService(selected).then((value) {
      CustomEasyLoading.instance.dismiss();
      setState(() {
        listTasks = value.data!;
      });
    }).catchError((e) {
      CustomEasyLoading.instance.showError(e.toString());
    });
  }

  List<Widget> showTasks(BuildContext context) {
    DateTime newDateTime = now.subtract(Duration(hours: 5, minutes: 0));
    if (!selected) {
      return [
        for (var task in listTasks)
          if (newDateTime.isBefore(task.dueDate)) cardTask(context, task),
        spaced(25, 0),
      ];
    } else {
      return [
        for (var task in listTasks) cardTask(context, task),
        spaced(25, 0),
      ];
    }
  }

  Padding cardTask(BuildContext context, Task task) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: cardButtonTaskWidget(
          icon: Icons.format_list_bulleted_rounded,
          tittle: task.task.title,
          subtitle: ' ${task.task.estimatedTime} minutos',
          onPressed: () async {
            //CustomEasyLoading.instance.showLoading("Cargando tarea...");
            await Navigator.pushNamed(context, 'detail-task', arguments: {
              'idAssigment': task.id,
            }).then((value) {
              selected = false;
              tasksLoad();
            });
          }),
    );
  }
}
