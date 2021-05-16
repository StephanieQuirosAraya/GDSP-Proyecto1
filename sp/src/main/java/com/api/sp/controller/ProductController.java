package com.api.sp.controller;

import com.api.sp.entity.Product;
import com.api.sp.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping ("/product")
public class ProductController {

    @Autowired
    ProductService prodServ;

    @GetMapping("/addProduct")
    public ResponseEntity<String> addProducts(){
        String message = ProductService.addProducts();
        return new ResponseEntity(message, HttpStatus.OK);
    }

    //trae los datos del body y llame desde service al SP
    //retorna mensaje
}