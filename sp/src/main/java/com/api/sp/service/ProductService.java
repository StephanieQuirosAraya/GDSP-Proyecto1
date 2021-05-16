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

    public void addProduct (Product prod) { //llama al rep
        productRep.addProducts(prod.getCommerceName(), prod.getName(), prod.getDescription(),
                prod.getPrice(), prod.isAvailable(), prod.getCategoryName(), prod.getPictureURL());
    }

    //aqui llamo al controller mediante el repositorio



}
