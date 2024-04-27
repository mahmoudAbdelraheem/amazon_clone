const express = require('express');
const productRoute = express.Router();
const auth = require('../middlewares/auth');
const Product = require('../models/product');

//? get All Products by Category
//? /api/products?category=Mobiles
//?  console.log(req.query.category);
 
productRoute.get("/api/products",auth,async(req,res)=>{
    try{
        const products= await Product.find({category:req.query.category});
        res.json(products);
    }catch(e){
        res.status(500).json({error:e.message});
    }
    
});
productRoute.get("/api/products/search/:name",auth,async(req,res)=>{
    try{
        const products= await Product.find({name:{$regex: req.params.name,$options:"i"},},);
        res.json(products);
    }catch(e){
        res.status(500).json({error:e.message});
    }
    
});
//? reating products
productRoute.post("/api/ratingproduct",auth,async(req,res)=>{
    
    try{
        const {id , rating} = req.body;
        let product= await Product.findById(id);
        for(let i=0;i<product.ratings.length;i++){
            if(product.ratings[i].userId == req.user){
                product.ratings.splice(i,1); //? deleteing previoues user rating if it's found 
                break;
            }
        }
        const ratingSchema = {
            userId : req.user,
            rating : rating,
        }

        product.ratings.push(ratingSchema);
        product =await product.save();
        res.json(product);


    }catch(e){
        res.status(500).json({error:e.message});
    }
    
});

productRoute.get('/api/dealofday',auth,async(req,res)=>{
    try{
        let products = await Product.find({});
        products = products.sort((a,b)=>{
            let aSum=0;
            let bSum=0;
            for(let i=0;i<a.ratings.length;i++){
                aSum = a.ratings[i].rating;
            }
            for(let i=0;i<b.ratings.length;i++){
                bSum = b.ratings[i].rating;
            }
            return aSum<bSum ? 1 : -1;
        });
        res.json(products[0]);
    }catch(e){
        res.status(500).json({error:e.message});
    }

});

module.exports = productRoute;