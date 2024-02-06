const UserModel=require('../model/userModel');


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
}

module.exports=UserService;