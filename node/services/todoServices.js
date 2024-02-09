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

    static async getTodos(userId){
        try{
            const todoData= await ToDoModel.find({userId});
            return todoData;
        }catch(error){
            console.log(error);
        }
    }

    static async deleteTask(id){
        const deleted=await ToDoModel.findOneAndDelete({_id:id});
        return deleted;
    }
}


module.exports=TodoService;