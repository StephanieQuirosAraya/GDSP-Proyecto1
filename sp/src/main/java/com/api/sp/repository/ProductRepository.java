package com.api.sp.repository;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.api.sp.entity.Products;
import org.springframework.data.jpa.repository.JpaRepository;

import javax.transaction.Transactional;

@Repository
public interface ProductRepository extends JpaRepository<Products, Integer> {

    @Transactional@Modifying
    @Query(value = "{call addProducts(:commerceName, :pName, :pDescription, :pPrice, :pAvailable, :pCatName, :pPictureURL)}", nativeQuery = true)
    void addProducts(
            @Param("commerceName") String commerceName,
            @Param("pName") String pName,
            @Param("pDescription") String pDescription,
            @Param("pPrice") int pPrice,
            @Param("pAvailable") boolean pAvailable,
            @Param("pCatName") String pCatName,
            @Param("pPictureURL") String pPictureURL
    );
}
