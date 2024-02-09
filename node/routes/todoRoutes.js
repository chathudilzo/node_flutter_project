const express=require('express');
const router=express.Router();
const TodoController=require('../controller/todoController');


router.post('/createtodo',TodoController.createTodo);
router.post('/getalltodos',TodoController.getAllTodos);
router.post('/deletetask',TodoController.deleteTask);



module.exports=router;