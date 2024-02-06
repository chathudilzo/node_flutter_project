const express=require('express');
const router=express.Router();
const UserController=require('../controller/userController')

router.post('/register',UserController.register);


module.exports=router;