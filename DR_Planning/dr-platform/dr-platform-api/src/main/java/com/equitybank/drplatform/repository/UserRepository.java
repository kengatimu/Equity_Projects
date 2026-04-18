package com.equitybank.drplatform.repository;

import com.equitybank.drplatform.entity.UserEntity;
import com.equitybank.drplatform.enums.UserRole;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

@Repository
public interface UserRepository extends JpaRepository<UserEntity, UUID> {
    Optional<UserEntity> findByEmail(String email);
    Optional<UserEntity> findByLdapDn(String ldapDn);
    List<UserEntity> findBySubsidiaryIdAndRole(String subsidiaryId, UserRole role);
    Page<UserEntity> findBySubsidiaryIdAndRole(String subsidiaryId, UserRole role, Pageable pageable);
    Page<UserEntity> findBySubsidiaryId(String subsidiaryId, Pageable pageable);
    Page<UserEntity> findByRole(UserRole role, Pageable pageable);
    List<UserEntity> findByIsActiveTrue();
    List<UserEntity> findByRole(UserRole role);
    boolean existsByEmail(String email);
}
