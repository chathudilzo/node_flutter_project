const UserService=require('../services/userServices');





exports.register=async(req,res,next)=>{
    try{
        console.log(req);
        const {email,password}=req.body;
        console.log(`Email: ${email}  PASSSWORD:${password} `);

        const successResponse=await UserService.registerUser(email,password);

        res.json({status:true,success:'User Registered Successfully!'})
    }catch(error){
        throw error;
    }
}