const express = require('express');
const userRoute = express.Router();
const auth =require('../middlewares/auth');
const { Product } = require('../models/product');
const User = require('../models/user');
//? add product to user cart function
userRoute.post("/api/addtocart",auth,async(req,res)=>{
    try{
       const {id} = req.body;
       const product = await Product.findById(id);
       let user = await User.findById(req.user);

        if(user.cart.length ==0){
            user.cart.push({product , quantity:1});
        }else {
            let isFound = false;
            for(let i=0;i<user.cart.length;i++){
                if(user.cart[i].product._id.equals(product._id)){
                    isFound ==true;
                }
            }
            if(isFound){
                let foundedProduct = user.cart.find((element)=> element.product._id.equals(product._id));
                foundedProduct.quantity +=1;
            }else {
                user.cart.push({product , quantity:1});
            }

        }
        user = await user.save();
        res.json(user);

    }catch(e){
        res.status(500).json({error:e.message});
    }
});

module.exports = userRoute;