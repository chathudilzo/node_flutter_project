const TodoService=require('../services/todoServices');


exports.createTodo=async(req,res,next)=>{
    try{
        console.log(req.body);
        const {userId,title,desc}=req.body;
        let todo=await TodoService.createTodo(userId,title,desc);

        res.json({status:true,success:todo});
        
    }catch(error){
        next(error);
    }
}


exports.getAllTodos=async(req,res,next)=>{
    try{
        const {userId}=req.body;
        let todos=await TodoService.getTodos(userId);

        res.json({status:true,success:todos});

    }catch(error){
        next(error);
    }


};


exports.deleteTask=async(req,res,next)=>{
    try{
        const {id}=req.body;

        let deleted=await TodoService.deleteTask(id);

        res.json({status:true,success:deleted});


    }catch(error){
        next(error);
    }
}