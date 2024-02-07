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


exports.login=async(req,res,next)=>{
    try{
        console.log(req);
        const {email,password}=req.body;

        const user=await UserService.checkUser(email);

        if(!user){
            throw new Error('User doesnot exists');
        }else{
            const isMatch=await user.comparePassword(password);
            if(!isMatch){
                throw new Error('Password invalid');
            }else{
                let tokenData={_id:user._id,email:user.email};
                const token=await UserService.generateToken(tokenData,"5869*",'1h');
                res.status(200).json({status:true,token:token});
            }
        }

        res.json({status:true,success:'User login Successful'});
    }catch(error){
        console.log('Controller:'+error);
    }
}