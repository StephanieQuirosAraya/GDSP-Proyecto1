package com.api.sp.controller;

import com.api.sp.entity.Product;
import com.api.sp.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping ("/product")
public class ProductController {

    @Autowired
    ProductService prodServ;

    @PostMapping("/addProduct")
    public ResponseEntity<String> addProducts(@RequestBody Product prod){
        prodServ.addProduct(prod);
        return new ResponseEntity("Se guardó un nuevo producto.",
                                  HttpStatus.CREATED);
    }

    //trae los datos del body y llame desde service al SP
    //retorna mensaje
}
