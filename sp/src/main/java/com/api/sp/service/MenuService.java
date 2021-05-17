package com.api.sp.service;


import com.api.sp.entity.Menu;
import com.api.sp.repository.MenuRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class MenuService {
    @Autowired
    MenuRepository menuRepository;

    public void addMenu (Menu menu) { //llama al rep
        try{
            menuRepository.addMenu(menu.getCommerceName(), menu.getMenuName(), menu.getPictureMenu(), menu.getName(),
                                   menu.getDescription(), menu.getPrice(), menu.isAvailable(), menu.getCategoryName(),
                                   menu.getPictureURL(), menu.getCaractName(), menu.getCaractDescription(),
                                   menu.getMaxSelection(), menu.getValue(), menu.getOptionName(), menu.getExtraPrice());
        } catch (Exception e){
            System.out.println("Service: "+e.getMessage());
        }

    }
}