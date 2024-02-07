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