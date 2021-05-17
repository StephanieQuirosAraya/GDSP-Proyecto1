package com.api.sp.service;

import com.api.sp.entity.Caracteristicas;
import com.api.sp.repository.CaractRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class CaractService {
    @Autowired
    CaractRepository caractRepository;

    public void addCaracteristica (Caracteristicas caract) { //llama al rep
        try{
            caractRepository.addCharacteristicProduct(caract.getName(), caract.getDescription(), caract.getMaxSelection(),
                                                      caract.getCategoryName(), caract.getValue(), caract.getProductName(),
                                                      caract.getOptionalName(), caract.getExtraPrice());
        } catch (Exception e){
            System.out.println("Service: "+e.getMessage());
        }

    }
}
