const express = require('express');
const userRoute = express.Router();
const auth =require('../middlewares/auth');
const { Product } = require('../models/product');
const User = require('../models/user');
const Order = require('../models/order');
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
                    isFound =true;
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
//? add product to user cart function
userRoute.delete("/api/removefromcart/:id",auth,async(req,res)=>{
    try{
       const {id} = req.params;
       const product = await Product.findById(id);
       let user = await User.findById(req.user);

            for(let i=0;i<user.cart.length;i++){
                if(user.cart[i].product._id.equals(product._id)){
                    if(user.cart[i].quantity ==1){
                       user.cart.splice(i,1);
                    }else {
                        user.cart[i].quantity -=1;
                    }
                }
        }
        user = await user.save();
        res.json(user);

    }catch(e){
        res.status(500).json({error:e.message});
    }
});

//? add user address 
userRoute.post("/api/adduseraddress",auth,async(req,res)=>{
    try{
       const {address} = req.body;
       let user = await User.findById(req.user);
        user.address = address;
        user = await user.save();
        res.json(user);

    }catch(e){
        res.status(500).json({error:e.message});
    }
});

//? order products
userRoute.post("/api/order",auth,async(req,res)=>{
    try{
       const {cart,totalAmount,address} = req.body;
       let products = [];
       
       //? 
       for(let i=0;i<cart.length;i++){
        let product = await Product.findById(cart[i].product._id);

        if(product.quantity >= cart[i].quantity){
            product.quantity -= cart[i].quantity;
            products.push({product , quantity:cart[i].quantity});
            await product.save();
        }else {
            return res.status(400).json({msg:`${product.name} Is Out Of Stock!`});
        }
       }
       //?
       let user = await User.findById(req.user);
       user.cart = [];
       user = await user.save(); 
       //? 
       let order = new Order({
        products,
        totalPrice: totalAmount,
        address,
        userId:req.user,
        orderAt : new Date().getTime,
       });
       order = await order.save();
       res.json(order);
    }catch(e){
        res.status(500).json({error:e.message});
    }
});


module.exports = userRoute;