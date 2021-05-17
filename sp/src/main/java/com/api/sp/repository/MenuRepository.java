package com.api.sp.repository;

import com.api.sp.entity.Products;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;


@Repository
public interface MenuRepository extends JpaRepository<Products, Integer> {

    @Transactional
    @Modifying
    @Query(value = "{call addMenu(:commerceName, :menuName, :pictureMenu, :pName," +
            ":pDescription, :pPrice, :pAvailable, :pCatName, :pPictureURL, :cName," +
            ":cDescription, :cMaxSelection, :cValue, :cOpName, :cOpExtraPrice)}", nativeQuery = true)
    void addMenu(
            @Param("commerceName") String commerceName,
            @Param("menuName") String menuName,
            @Param("pictureMenu") String pictureMenu,
            @Param("pName") String pName,
            @Param("pDescription") String pDescription,
            @Param("pPrice") int pPrice,
            @Param("pAvailable") boolean pAvailable,
            @Param("pCatName") String pCatName,
            @Param("pPictureURL") String pPictureURL,
            @Param("cName") String cName,
            @Param("cDescription") String cDescription,
            @Param("cMaxSelection") int cMaxSelection,
            @Param("cValue") String cValue,
            @Param("cOpName") String cOpName,
            @Param("cOpExtraPrice") int cOpExtraPrice
    );
}