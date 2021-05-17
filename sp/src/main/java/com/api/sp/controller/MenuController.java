package com.api.sp.controller;


import com.api.sp.entity.Menu;
import com.api.sp.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;



@RestController
public class MenuController {

    @Autowired
    MenuService menuService;

    @PostMapping("/addMenu")
    public ResponseEntity<?> addMenu(@RequestBody Menu menu){
        try {
            menuService.addMenu(menu);
            return new ResponseEntity("Se guardó un nuevo menú.", HttpStatus.CREATED);

        } catch (Exception e){
            return new ResponseEntity("Controller: "+e, HttpStatus.CREATED);
        }

    }

}