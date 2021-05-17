package com.api.sp.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;


@Entity
public class Menu {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int menuId;
    private String commerceName;
    private String menuName;
    private String pictureMenu;
    private String name;
    private String description;
    private int price;
    private boolean available;
    private String categoryName;
    private String pictureURL;
    private String caractName;
    private String caractDescription;
    private int maxSelection;
    private String value;
    private String optionName;
    private int extraPrice;


    public Menu(){
    }

    public Menu(String commerceName, String menuName, String pictureMenu, String name, String description,
                int price, boolean available, String categoryName, String pictureURL, String caractName,
                String caractDescription, int maxSelection, String value, String optionName, int extraPrice) {
        this.commerceName = commerceName;
        this.menuName = menuName;
        this.pictureMenu = pictureMenu;
        this.name = name;
        this.description = description;
        this.price = price;
        this.available = available;
        this.categoryName = categoryName;
        this.pictureURL = pictureURL;
        this.caractName = caractName;
        this.caractDescription = caractDescription;
        this.maxSelection = maxSelection;
        this.value = value;
        this.optionName = optionName;
        this.extraPrice = extraPrice;
    }

    public String getCommerceName() {
        return commerceName;
    }

    public void setCommerceName(String commerceName) {
        this.commerceName = commerceName;
    }

    public String getMenuName() {
        return menuName;
    }

    public void setMenuName(String menuName) {
        this.menuName = menuName;
    }

    public String getPictureMenu() {
        return pictureMenu;
    }

    public void setPictureMenu(String pictureMenu) {
        this.pictureMenu = pictureMenu;
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

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public boolean isAvailable() {
        return available;
    }

    public void setAvailable(boolean available) {
        this.available = available;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getPictureURL() {
        return pictureURL;
    }

    public void setPictureURL(String pictureURL) {
        this.pictureURL = pictureURL;
    }

    public String getCaractName() {
        return caractName;
    }

    public void setCaractName(String caractName) {
        this.caractName = caractName;
    }

    public String getCaractDescription() {
        return caractDescription;
    }

    public void setCaractDescription(String caractDescription) {
        this.caractDescription = caractDescription;
    }

    public int getMaxSelection() {
        return maxSelection;
    }

    public void setMaxSelection(int maxSelection) {
        this.maxSelection = maxSelection;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getOptionName() {
        return optionName;
    }

    public void setOptionName(String optionName) {
        this.optionName = optionName;
    }

    public int getExtraPrice() {
        return extraPrice;
    }

    public void setExtraPrice(int extraPrice) {
        this.extraPrice = extraPrice;
    }
}