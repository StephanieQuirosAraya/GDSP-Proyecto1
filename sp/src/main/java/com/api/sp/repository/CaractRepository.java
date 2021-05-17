package com.api.sp.repository;

import com.api.sp.entity.Caracteristicas;
import com.api.sp.entity.Products;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;


@Repository
public interface CaractRepository extends JpaRepository<Caracteristicas, Integer> {

    @Transactional
    @Modifying
    @Query(value = "{call addCharacteristicProduct(:cName, :cDescription, :cMaxSelection, :pCatName, :cValue, :pName, :cOpName, :cOpExtraPrice)}", nativeQuery = true)
    void addCharacteristicProduct(
            @Param("cName") String cName,
            @Param("cDescription") String cDescription,
            @Param("cMaxSelection") int cMaxSelection,
            @Param("pCatName") String pCatName,
            @Param("cValue") String cValue,
            @Param("pName") String pName,
            @Param("cOpName") String cOpName,
            @Param("cOpExtraPrice") int cOpExtraPrice
    );
}
