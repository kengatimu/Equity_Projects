//package com.equitybankgroup.payments.b2c.service.user;
//
//import com.equitybankgroup.payments.b2c.repository.UserRepository;
//import com.equitybankgroup.payments.b2c.model.UserEntity;
//import java.util.Collection;
//import java.util.List;
//import java.util.Optional;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.core.GrantedAuthority;
//import org.springframework.security.core.userdetails.UserDetails;
//import org.springframework.security.core.userdetails.UserDetailsService;
//import org.springframework.security.core.userdetails.UsernameNotFoundException;
//import org.springframework.stereotype.Service;
//import org.springframework.transaction.annotation.Transactional;
//
//@Service
//@Transactional
//public class CustomUserDetailsService implements UserDetailsService {
//
//    
//    @Autowired
//    private UserRepository userRepository; 
//
//    @Override
//    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
//        Optional<UserEntity> userOpt = userRepository.findByUsername(username);
//        if (userOpt.isEmpty()) {
//            throw new UsernameNotFoundException("User not found");
//        }
//        UserEntity user = userOpt.get();
//        
//        Collection<? extends GrantedAuthority> authorities = user.getAuthorities();
//        
//
//        return new org.springframework.security.core.userdetails.User(
//                user.getUsername(), user.getPassword(), user.isEnabled(),
//                user.isAccountNonExpired(), user.isCredentialsNonExpired(),
//                user.isAccountNonLocked(), authorities);
//
//    }
//    
//    public List<UserEntity> getAllUsers()
//    {
//        return userRepository.findAll();
//    }
//    
//    public UserEntity saveUser(UserEntity user)
//    {
//        return userRepository.save(user);
//    }
//    
//    public Optional<UserEntity> findByUsername(String username)
//    {
//        return userRepository.findByUsername(username);
//    }
//    
//    public void deleteUser(Long id)
//    {
//        userRepository.deleteById(id);
//    }
//    
//    
//}
