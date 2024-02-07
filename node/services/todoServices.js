const ToDoModel=require('../model/todoModel');


class TodoService{
    static async createTodo(userId,title,desc){
        try{
            console.log('mongoose:::'+userId,title,desc);
            const createTodo=new ToDoModel({userId,title,desc});
        return await createTodo.save();
        }catch(error){
            throw error;
        }
    }
}


module.exports=TodoService;