///*
// * To change this license header, choose License Headers in Project Properties.
// * To change this template file, choose Tools | Templates
// * and open the template in the editor.
// */
//package com.equitybankgroup.payments.b2c.config;
//
///**
// *
// * @author ronaldcheruiyot
// */
//import org.springframework.stereotype.Component;
//import jakarta.servlet.FilterChain;
//import jakarta.servlet.FilterConfig;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.http.HttpFilter;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import java.io.IOException;
//import org.springframework.beans.factory.annotation.Value;
//
//@Component
//public class CustomHeaderFilter extends HttpFilter {
//    
//    @Value("${cors.allowed.origin}")
//    private String allowedOrigin;
//
//    @Override
//    protected void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
//            throws IOException, ServletException {
//        response.setHeader("Access-Control-Allow-Origin", allowedOrigin);
//        response.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
//        response.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");
//        response.setHeader("Access-Control-Allow-Credentials", "true");
//
//
//        chain.doFilter(request, response);
//    }
//}
