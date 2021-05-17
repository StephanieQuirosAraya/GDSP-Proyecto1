package com.api.sp.controller;

import com.api.sp.entity.Products;
import com.api.sp.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
//@RequestMapping ("/product")
public class ProductController {

    @Autowired
    ProductService productService;

    @PostMapping("/addProducts")
    public ResponseEntity<?> addProducts(@RequestBody Products prod){
        try {
            productService.addProduct(prod);
            return new ResponseEntity("Se guardó un nuevo producto.", HttpStatus.CREATED);

        } catch (Exception e){
            return new ResponseEntity("Controller: "+e, HttpStatus.CREATED);
        }

    }

}
