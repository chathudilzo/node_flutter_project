const UserModel=require('../model/userModel');
const jwt=require('jsonwebtoken');

class UserService{
    static async registerUser(email,password){
        try{
            console.log(`Email: ${email}  PASSSWORD:${password} `)
            const createUser=new UserModel({email:email,password:password});
            return await createUser.save();
        }catch(error){
            throw error;
        }
    }

    static async checkUser(email){
        try{
            return await UserModel.findOne({email});
        }catch(error){
            throw error;
        }
    }

    static async generateToken(tokenData,secreateKey,jwt_expire){
        return jwt.sign(tokenData,secreateKey,{expiresIn:jwt_expire});
    }
}

module.exports=UserService;