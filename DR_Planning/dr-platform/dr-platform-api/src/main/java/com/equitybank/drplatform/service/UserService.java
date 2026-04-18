package com.equitybank.drplatform.service;

import com.equitybank.drplatform.dto.request.CreateUserRequest;
import com.equitybank.drplatform.dto.response.PagedResponse;
import com.equitybank.drplatform.dto.response.UserDto;
import com.equitybank.drplatform.entity.UserEntity;
import com.equitybank.drplatform.enums.UserRole;
import com.equitybank.drplatform.exception.ConflictException;
import com.equitybank.drplatform.exception.ResourceNotFoundException;
import com.equitybank.drplatform.exception.ValidationException;
import com.equitybank.drplatform.repository.UserRepository;
import com.equitybank.drplatform.security.DrPlatformUserDetails;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
@Transactional
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;

    public UserDto createUser(CreateUserRequest request) {
        if (userRepository.existsByEmail(request.getEmail())) {
            throw new ConflictException("User with email already exists: " + request.getEmail());
        }
        UserEntity user = UserEntity.builder()
                .email(request.getEmail())
                .displayName(request.getDisplayName())
                .role(request.getRole())
                .subsidiaryId(request.getSubsidiaryId())
                .lineManagerEmail(request.getLineManagerEmail())
                .isActive(true)
                .build();
        return UserDto.fromEntity(userRepository.save(user));
    }

    public UserDto updateRole(UUID userId, UserRole role) {
        UserEntity user = findById(userId);
        user.setRole(role);
        return UserDto.fromEntity(userRepository.save(user));
    }

    public void deactivateUser(UUID userId) {
        UserEntity user = findById(userId);
        user.setActive(false);
        userRepository.save(user);
    }

    @Transactional(readOnly = true)
    public UserDto getUser(UUID userId) {
        return UserDto.fromEntity(findById(userId));
    }

    @Transactional(readOnly = true)
    public UserDto getUserByEmail(String email) {
        return UserDto.fromEntity(userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("User not found: " + email)));
    }

    @Transactional(readOnly = true)
    public UserDto getCurrentUser() {
        var auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.getPrincipal() instanceof DrPlatformUserDetails ud) {
            return UserDto.fromEntity(ud.getUser());
        }
        throw new ValidationException("No authenticated user found");
    }

    @Transactional(readOnly = true)
    public PagedResponse<UserDto> listUsers(int page, int size, String subsidiaryId, UserRole role) {
        var pageable = PageRequest.of(page, size, Sort.by("displayName").ascending());
        if (subsidiaryId != null && role != null) {
            return PagedResponse.from(
                    userRepository.findBySubsidiaryIdAndRole(subsidiaryId, role, pageable)
                            .map(UserDto::fromEntity));
        } else if (subsidiaryId != null) {
            return PagedResponse.from(
                    userRepository.findBySubsidiaryId(subsidiaryId, pageable).map(UserDto::fromEntity));
        } else if (role != null) {
            return PagedResponse.from(
                    userRepository.findByRole(role, pageable).map(UserDto::fromEntity));
        }
        return PagedResponse.from(userRepository.findAll(pageable).map(UserDto::fromEntity));
    }

    private UserEntity findById(UUID id) {
        return userRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("User", id));
    }
}
