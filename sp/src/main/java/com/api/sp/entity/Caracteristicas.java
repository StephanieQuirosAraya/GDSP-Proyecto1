package com.api.sp.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Caracteristicas {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int caracteristicaID;
    private String name;
    private String description;
    private int maxSelection;
    private String categoryName;
    private String value;
    private String productName;
    private String optionalName;  //nombre de la caracteristica opcional
    private int extraPrice;

    public Caracteristicas(){
    }

    public Caracteristicas(String name, String description, int maxSelection, String categoryName,
                           String value, String productName, String optionalName, int extraPrice) {
        this.name = name;
        this.description = description;
        this.maxSelection = maxSelection;
        this.categoryName = categoryName;
        this.value = value;
        this.productName = productName;
        this.optionalName = optionalName;
        this.extraPrice = extraPrice;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getMaxSelection() {
        return maxSelection;
    }

    public void setMaxSelection(int maxSelection) {
        this.maxSelection = maxSelection;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getOptionalName() {
        return optionalName;
    }

    public void setOptionalName(String optionalName) {
        this.optionalName = optionalName;
    }

    public int getExtraPrice() {
        return extraPrice;
    }

    public void setExtraPrice(int extraPrice) {
        this.extraPrice = extraPrice;
    }
}
