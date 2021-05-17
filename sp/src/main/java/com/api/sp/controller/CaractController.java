package com.api.sp.controller;

import com.api.sp.entity.Caracteristicas;
import com.api.sp.service.CaractService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CaractController {

    @Autowired
    CaractService caractService;

    @PostMapping("/addCaract")
    public ResponseEntity<?> addCaracteristica(@RequestBody Caracteristicas caract){
        try {
            caractService.addCaracteristica(caract);
            return new ResponseEntity("Se guardó una nueva caracteristica.", HttpStatus.CREATED);

        } catch (Exception e){
            return new ResponseEntity("Controller: "+e, HttpStatus.CREATED);
        }

    }

}
