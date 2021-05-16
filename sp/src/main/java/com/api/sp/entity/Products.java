package com.api.sp.entity;


import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Products {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String CommerceName;
    private String Name;
    private String Description;
    private int Price;
    private boolean Available;
    private String CategoryName;
    private String PictureURL;

    public Products() {
    }

    public Products(String CommerceName, String Name, String Description, int Price, boolean Available,
                   String CategoryName, String PictureURL) {
        this.CommerceName = CommerceName;
        this.Name = Name;
        this.Description = Description;
        this.Price = Price;
        this.Available = Available;
        this.CategoryName = CategoryName;
        this.PictureURL = PictureURL;
    }

    public String getCommerceName() {
        return CommerceName;
    }

    public void setCommerceName(String commerceName) {
        CommerceName = commerceName;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String description) {
        Description = description;
    }

    public int getPrice() {
        return Price;
    }

    public void setPrice(int price) {
        Price = price;
    }

    public boolean isAvailable() {
        return Available;
    }

    public void setAvailable(boolean available) {
        Available = available;
    }

    public String getCategoryName() {
        return CategoryName;
    }

    public void setCategoryName(String categoryName) {
        CategoryName = categoryName;
    }

    public String getPictureURL() {
        return PictureURL;
    }

    public void setPictureURL(String pictureURL) {
        PictureURL = pictureURL;
    }
}
