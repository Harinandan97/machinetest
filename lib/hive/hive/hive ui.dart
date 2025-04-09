import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main()async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('todotask');
  runApp(MaterialApp(home: Hiveui(),));
}
class Hiveui extends StatefulWidget {
  const Hiveui({super.key});

  @override
  State<Hiveui> createState() => _HiveuiState();
}

class _HiveuiState extends State<Hiveui> {
  final task=Hive.box("todotask");
  List<Map<String,dynamic>> todotask=[];

  @override
  void initState(){
    loadtask();
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      todotask.isEmpty?
          const Center(
            child: Text("no data",
            style: TextStyle(fontSize: 40),

            ),

          ):


      ListView.builder(itemBuilder: (context,index){
        return Card(
          child: ListTile(
            title: Text(todotask[index]["title"]),
            subtitle: Text("dxfcg"),
            trailing: Wrap(
              children: [
                IconButton(onPressed: (){
                 showform(todotask [index]['key']);
                 }, icon: Icon(Icons.edit)),



                IconButton(onPressed: (){
                  delete(todotask [index]['key']);

                }, icon: Icon(Icons.delete))




              ],
            ),
          ),
        );
      },itemCount: todotask.length,),
      floatingActionButton: FloatingActionButton(onPressed: ()=>showform(null),
        child: Icon(Icons.add),),
    );
  }

  final title_controller=TextEditingController();
  final subtitle_controller=TextEditingController();

  void showform(int ? id)async {
    if(id !=null){
      final existdata=todotask.firstWhere((element)=>element["key"]==id);
      title_controller.text=existdata["title"];
      subtitle_controller.text=existdata["subtitle"];
    }

    showModalBottomSheet(isScrollControlled: true,
        context: context, builder: (context)=>Container(
          padding: EdgeInsets.only(
            left: 10,
            top: 20,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom+120,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextField(
                controller: title_controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "title"
                ),
              ),
              SizedBox(height: 30,),
              TextField(
                controller: subtitle_controller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "subtitle"
                ),
              ),
              SizedBox(height: 30,),
              ElevatedButton(onPressed: ()async{
                if(id==null){
                  createtask({"title":title_controller.text,"subtitle":subtitle_controller.text});
                }
                if(id !=null){
updatetask(id,{"title":title_controller.text,"subtitle":subtitle_controller.text});

                }
                title_controller.text="";
                subtitle_controller.text="";
                Navigator.of(context).pop();
              }, child: Text(id==null ? "Create" : "Update"))
            ],
          ),
        ));
  }

  void createtask(Map<String, dynamic> ctask)async {
    await task.add(ctask);
    loadtask();
  }
  void loadtask()async{
    final data=task.keys.map((id){

      final values=task.get(id);

      return{"key":id,"title":values["title"],"subtitle":values["subtitle"]};


    }).toList();
    setState(() {
      todotask=data.reversed.toList();
    });
  }

  void updatetask(int key, Map<String,dynamic> uptack)async{
    await task.put(key, uptack);
    loadtask();
  }
Future<void>delete(int key)async{
    await task.delete(key);
    loadtask();
}

}