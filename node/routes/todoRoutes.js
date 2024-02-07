const express=require('express');
const router=express.Router();
const TodoController=require('../controller/todoController');


router.post('/createtodo',TodoController.createTodo);


module.exports=router;