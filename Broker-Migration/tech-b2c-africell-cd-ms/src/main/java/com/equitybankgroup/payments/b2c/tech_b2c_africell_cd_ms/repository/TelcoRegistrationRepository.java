package com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.repository;

import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.model.TelcoRegistration;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import org.springframework.data.domain.Page;

@Repository
public interface TelcoRegistrationRepository extends JpaRepository<TelcoRegistration, Long> {

    @Query(value = "SELECT * FROM drc_telco_registrations t  WHERE  t.msisdn = :msisdn order by t.date_created desc", nativeQuery = true)
    Optional<TelcoRegistration> findByMsisdn(@Param("msisdn") String paramString);
    
    @Query(value = "SELECT * FROM drc_telco_registrations t  WHERE  t.msisdn = :msisdn "
            + "and t.country_code = :countryCode "
            + "and t.source_account_number = :sourceAccount order by t.date_created desc", nativeQuery = true)
    Optional<TelcoRegistration> findByMsisdAndSourceAccount(@Param("msisdn") String msisdn, 
            @Param("sourceAccount") String sourceAccount, 
            @Param("countryCode") String countryCode);
    
    @Query(value = "SELECT * FROM drc_telco_registrations t  WHERE  t.msisdn = :msisdn "
            + "and t.country_code = :countryCode "
            + "and (t.currency is null) or (t.currency = :currency) "
            + "and t.source_account_number = :sourceAccount order by t.date_created desc", nativeQuery = true)
    List<TelcoRegistration> findByMsisdAndSourceAccountList(@Param("msisdn") String msisdn, 
            @Param("sourceAccount") String sourceAccount, 
            @Param("countryCode") String countryCode,
            @Param("currency") String currency);
    
}


