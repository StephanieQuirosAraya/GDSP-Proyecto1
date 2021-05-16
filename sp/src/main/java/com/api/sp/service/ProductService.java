package com.api.sp.service;

import com.api.sp.entity.Product;
import com.api.sp.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProductService {
    @Autowired
    ProductRepository productRep;

    public String addProducts(String commerceName, String pName, String pDescription,
                            int pPrice, boolean pAvailable, String pCatName,
                            string pPictureURL){
        productRep.addProducts(commerceName, pName, pDescription,
                pPrice, pAvailable, pCatName, pPictureURL); //llama al rep
        return "Se agregó el producto.";
    }

    //aqui llamo al controller mediante el repositorio



}
