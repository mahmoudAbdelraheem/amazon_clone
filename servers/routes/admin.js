const express = require('express');
const adminRoute = express.Router();
const admin = require('../middlewares/admin');
const Product = require('../models/product');

//? add product function
adminRoute.post("/admin/addproduct",admin,async(req,res)=>{
    try{
        const{name, description,imagesUrl,quantity,price,category} = req.body;
        let product =new Product({
            name:name,
            description :description,
            images : imagesUrl,
            quantity : quantity,
            price:price,
            category:category,
        });

        product = await product.save();
        res.json(product);
    }catch(e){
        res.status(500).json({error:e.message});
    }
});

//? get All Products for home Screen

adminRoute.get("/admin/getproducts",admin,async(req,res)=>{
    try{
        const products= await Product.find();
        res.json(products);
    }catch(e){
        res.status(500).json({error:e.message});
    }
});

module.exports = adminRoute;