package com.api.sp.service;

import com.api.sp.entity.Products;
import com.api.sp.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProductService {
    @Autowired
    ProductRepository productRepository;

    public void addProduct (Products prod) { //llama al rep
        try{
            productRepository.addProducts(prod.getCommerceName(), prod.getName(), prod.getDescription(),
                    prod.getPrice(), prod.isAvailable(), prod.getCategoryName(),
                    prod.getPictureURL());
        } catch (Exception e){
            System.out.println("Service: "+e.getMessage());
        }

    }
}
