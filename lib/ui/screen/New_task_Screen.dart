import 'package:flutter/material.dart';
import 'package:task_manager/Data/Services/network_caller.dart';
import 'package:task_manager/Data/utils/Urls.dart';
import 'package:task_manager/ui/widgets/Circular_progress_indicator.dart';
import 'package:task_manager/ui/widgets/Tm_app_Bar.dart';
import 'package:task_manager/ui/widgets/snackBarMessage.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  static const String name='/new-task-adden-screen';


  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {

 TextEditingController _titleTEcontroller=TextEditingController();
TextEditingController _descriptionTEcontroller=TextEditingController();

  GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  bool _addNewTaskInProgress=false;

  @override
  Widget build(BuildContext context) {
    final texttheme=Theme.of(context).textTheme;
    return Scaffold(
      appBar: TMappBar(),

      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(height: 56,),
              Text('Add new task',
              style: texttheme.titleLarge,
              ),
              SizedBox(height: 16,),
              TextFormField(
                controller: _titleTEcontroller,
                decoration: InputDecoration(
                  labelText: 'Title'
                ),
                validator: (String? value){
                  if(value?.trim().isEmpty ?? true){
                    return 'Enter your title here.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16,),
              TextFormField(
                controller: _descriptionTEcontroller,
                maxLines: 8,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                validator: (String? value){
                  if(value?.trim().isEmpty ?? true){
                    return 'Enter your description here';
                  }
                  return null;
                },

              ),
              SizedBox(height: 16,),
              Visibility(
                visible: _addNewTaskInProgress==false,
                replacement: CenteredCircularProgressIndicator(),
                child: ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()){
                      _createNewTask();
                    }
                  },
                  child: Icon(Icons.arrow_circle_right_outlined),
                ),
              )
            ],

          ),
        ),
      ),
    );
  }

  Future<void> _createNewTask() async{
    _addNewTaskInProgress=true;
    setState(() {});
    Map<String,dynamic> requestBody={

        "title":_titleTEcontroller.text.trim(),
        "description":_descriptionTEcontroller.text.trim(),
        "status":"New"
      };


     NetworkResponse response= await NetworkCaller.postRequest(Url: Urls.createTaskUrl,body: requestBody);
     _addNewTaskInProgress=false;
     setState(() {});
     if(response.isSuccess){
       _clearTextFields();
       showSnackBarMessage(context, 'Successfully new task Added!');
       Navigator.pop(context);

     }
     else{
       showSnackBarMessage(context, response.errorMessage);
     }
  }

  void _clearTextFields(){
    _titleTEcontroller.clear();
    _descriptionTEcontroller.clear();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleTEcontroller.dispose();
    _descriptionTEcontroller.dispose();
  }
}
